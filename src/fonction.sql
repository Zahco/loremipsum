set serveroutput on;

-- 1. une méthode donnant un traitement à un patient.
create or replace procedure prescrire
  (nom_patient in patient.nom%type, 
  prenom_patient in patient.prenom%type, 
  nom_maladie in maladie.nom%type, 
  desc_symptome in symptome.description%type, 
  nom_medecin in medecin.nom%type, 
  prenom_medecin in medecin.prenom%type, 
  date_debut in date, 
  nom_medicament in medicament.nom%type)
is
begin
  insert into consultation values ('10-10-10',  
                                 (select ref(med) from medecin med 
                                     where med.nom = nom_medecin 
                                        and med.prenom = prenom_medecin
                                        and rownum = 1),
                                 (select ref(pa) from patient pa 
                                     where pa.nom = nom_patient 
                                        and pa.prenom = prenom_patient
                                        and rownum = 1));
  insert into prescription values (date_debut,
  (select ref(co) from consultation co where co.dateT = '10-10-10'  
                                          and co.medecin = (select ref(med) from medecin med 
                                                              where med.nom = nom_medecin 
                                                                 and med.prenom = prenom_medecin
                                                                 and rownum = 1)
                                          and co.patient = (select ref(pa) from patient pa 
                                                              where pa.nom = nom_patient 
                                                                 and pa.prenom = prenom_patient
                                                                 and rownum = 1)
                                          and rownum = 1
  ),
  (select ref(me) from medicament me 
      where me.nom = nom_medicament
      and rownum = 1)
      
   );

  insert into symptome_consultation values (
  (select ref(sym) from symptome sym where sym.description = desc_symptome)
  
  
  ,
  (select ref(co) from consultation co where co.dateT = '10-10-10'  
                                          and co.medecin = (select ref(med) from medecin med 
                                                              where med.nom = nom_medecin 
                                                                 and med.prenom = prenom_medecin
                                                                 and rownum = 1)
                                          and co.patient = (select ref(pa) from patient pa 
                                                              where pa.nom = nom_patient 
                                                                 and pa.prenom = prenom_patient
                                                                 and rownum = 1)
                                          and rownum = 1)
  );
   
   
   
   
  insert into traitement_prescription values (
      (select ref(t) from traitement t 
         where ref(t) = (select e.traitement from substance_active_traitement e 
                          where e.substance_active = (select m.substance_active from medicament m 
                                                         where m.nom = nom_medicament
                                                         and rownum = 1
                                                     )
                            and rownum = 1
                        )
         and maladie = (select ref(ma) from maladie ma 
                          where ma.nom = nom_maladie
                          and rownum = 1)
         and rownum = 1
       ),
      (select ref(p) from prescription p 
         where consultation = (select ref(co) from consultation co 
                                   where dateT = '10-10-10' and
                                   medecin = (select ref(med) from medecin med 
                                                 where med.nom = nom_medecin 
                                                   and med.prenom = prenom_medecin
                                                   and rownum = 1) 
                                    and patient = (select ref(pa) from patient pa 
                                                 where pa.nom = nom_patient 
                                                    and pa.prenom = prenom_patient
                                                    and rownum = 1)
                                    and rownum = 1
                               )
      and rownum = 1)
  ); 
end;
/


execute prescrire('Lorem', 'Ipsum', 'Peste', 'Bubons' , 'Sourissette', 'Frederique', '10-10-10', 'doliprane');
execute prescrire('Lorem', 'Dolores', 'Balantidiase', 'Bubons' , 'Sourissette', 'Frederique', '10-10-10', 'doliprane');


-- 2. une méthode donnant les traitements en cours d’un patient.
create or replace procedure traitement_du_patient
  (nom_patient in patient.nom%type, prenom_patient in patient.prenom%type, ret out sys_refcursor)
is
begin
  open ret for 
  select deref(deref(tp.traitement).maladie)
  from traitement_prescription tp
  where /*current_date < deref(tp.prescription).debut + deref(tp.traitement).duree
  and*/ tp.prescription = (
    select ref(pr) from prescription pr where pr.consultation = (
      select ref(con) from consultation con 
      where con.patient = (
        select ref(pa) from patient pa 
        where pa.nom = nom_patient
        and pa.prenom = prenom_patient
      )
    )
  );
end;
/

declare 
  ret sys_refcursor;
  line maladie%rowtype;
begin
  traitement_du_patient('Lorem', 'Ipsum', ret);
  loop
    fetch ret into line;
    exit when ret%notfound;
    dbms_output.put_line(line.nom);
  end loop;
  
  close ret;
end;
/

-- 3. Une méthode donnant la liste et le nombre d’effets indésirables connus 
--    d’un médicament.

create or replace procedure ei_par_medicament
  (medic_nom in medicament.nom%type, ret out sys_refcursor)
is
begin
  open ret for 
  select deref(es.effet_indesirable).description
  from effet_i_substance_a es
  where es.substance_active = (
    select substance_active from medicament where nom = medic_nom
  );
end;
/
declare 
  ret sys_refcursor;
  line effet_indesirable.description%type;
begin
  ei_par_medicament('doliprane', ret);
  loop
    fetch ret into line;
    exit when ret%notfound;
    dbms_output.put_line(line);
  end loop;
  
  close ret;
end;
/
-- 4. Une méthode donnant la liste des medicament provocant des interections.

create or replace procedure liste_interaction
  (nom_med in medicament.nom%type,
   ret out sys_refcursor)
is
begin
  open ret for 
    select deref(medicament2) from interaction 
    where deref(medicament1).nom = nom_med
    union all
    select deref(medicament1) from interaction 
    where deref(medicament2).nom = nom_med; 
 
end;
/


declare 
  ret sys_refcursor;
  line medicament%rowtype;
begin
  liste_interaction('efferalgan', ret);
  loop
    fetch ret into line;
    exit when ret%notfound;
    dbms_output.put_line(line.nom);
  end loop;
  
  close ret;
end;
/

-- 5. une fonction permettant de proposer une liste de médicaments à partir de la
--    maladie diagnostiquée, même si un lien direct maladie-médicament n’existe
--    pas.

create or replace procedure medicament_recommende
  (maladie_nom in maladie.nom%type,
   ret out sys_refcursor)
is
begin
  open ret for 
    select med.nom from medicament med
    where med.substance_active = (
      select substance_active from substance_active_traitement sat 
      where deref(deref(sat.traitement).maladie).nom = maladie_nom
    );
end;
/


declare 
  ret sys_refcursor;
  line medicament.nom%type;
begin
  medicament_recommende('Peste', ret);
  loop
    fetch ret into line;
    exit when ret%notfound;
    dbms_output.put_line(line);
  end loop;
  
  close ret;
end;
/

-- 6. une méthode qui détermine pour un médicament la liste des efets indésirables
--    probables (déduits des hiérarchies de substances actives)..

create or replace procedure ei_probable_par_medicament
  (medic_nom in medicament.nom%type, ret out sys_refcursor)
is
begin
  open ret for 
  select distinct deref(es.effet_indesirable).description
  from effet_i_substance_a es, effet_indesirable ei
  start with es.substance_active = (select substance_active from medicament where nom = medic_nom)
    connect by prior es.effet_indesirable = ei.effet_indesirable;
end;
/

declare 
  ret sys_refcursor;
  line effet_indesirable.description%type;
begin
  ei_probable_par_medicament('doliprane', ret);
  loop
    fetch ret into line;
    exit when ret%notfound;
    dbms_output.put_line(line);
  end loop;
  
  close ret;
end;
/

-- 7. afin de contrôler les prescriptions, on doit pouvoir déterminer s’il y a un
--    ensemble de médicaments qui ne sont prescrits que par des médecins qui ont
--    travaillé à leur développement.

create or replace procedure a_medecin_verreux
  (ret out sys_refcursor)
is
begin
  open ret for 
    select distinct deref(pr.medicament).nom from prescription pr
    where not exists (
      select deref(pr.consultation).medecin from prescription pr
      where deref(pr.medicament).nom = deref(pr.medicament).nom
      and deref(pr.consultation).medecin not in (
        select md.medecin from medecin_developpement md
        where deref(deref(md.developpement).medicament).nom = deref(pr.medicament).nom
      )
    );
end;
/

declare 
  ret sys_refcursor;
  line medicament.nom%type;
begin
  a_medecin_verreux(ret);
  loop
    fetch ret into line;
    exit when ret%notfound;
    dbms_output.put_line(line);
  end loop;
  
  close ret;
end;
/

-- 8. on doit pouvoir déterminer s’il y a des médicaments qui ne sont prescrits que
--    par des médecins ayant travaillé dans les laboratoires les fabriquant.

create or replace procedure a_medecin_corrompu
  (ret out sys_refcursor)
is
begin
  open ret for 
    select distinct deref(pr.medicament).nom from prescription pr
    where not exists (
      select deref(pr.consultation).medecin from prescription pr
      where deref(pr.medicament).nom = deref(pr.medicament).nom
      and deref(pr.consultation).medecin not in (
        select ref(med) from medecin med
        where med.laboratoire = (
          select dev.laboratoire from developpement dev
          where dev.medicament = pr.medicament
        )
      )
    );
end;
/

declare 
  ret sys_refcursor;
  line medicament.nom%type;
begin
  a_medecin_corrompu(ret);
  loop
    fetch ret into line;
    exit when ret%notfound;
    dbms_output.put_line(line);
  end loop;
  
  close ret;
end;
/

-- 9. on doit pouvoir identifier la/les maladie(s) probable(s) et aider à la prescrip-
--    tion en fonction d’observations (symptômes) et des caractéristiques du patient
--    (vous pourrez trier les traitements proposés par nombre d’effets indésirables
--    par exemple).

create or replace procedure diagnostique_preliminaire
  (nom_patient in patient.nom%type, prenom_patient in patient.prenom%type, desc_symptome in symptome.description%type, ret out sys_refcursor)
is
begin
  open ret for 
  select distinct deref(sym.maladie).nom from symptome sym 
    where sym.description = desc_symptome
    or ref(sym) in (select truc.symptome from symptome_consultation truc
                        where deref(truc.consultation).patient in 
                             (select cp.patient from carateristique_patient cp 
                                where deref(cp.carateristique).description in (select deref(cpat.carateristique).description from carateristique_patient cpat 
                                                                where deref(cpat.patient).nom = nom_patient 
                                                                  and deref(cpat.patient).prenom = prenom_patient)
                              )
    
                    
  );
end;
/

declare 
  ret sys_refcursor;
  line maladie.nom%type;
begin
  diagnostique_preliminaire('Lorem', 'Ipsum', 'Fièvre', ret);
  loop
    fetch ret into line;
    exit when ret%notfound;
    dbms_output.put_line(line);
  end loop;
  
  close ret;
end;
/


-- 10. une fonction permettant d’indiquer à un médecin prescrivant si le traitement
--     envisagé, risque d’interagir avec un traitement ’en cours’ et proposer le cas
--     échéant un autre traitement.

create or replace procedure est_prescrivable
  (patient_nom in patient.nom%type, 
  patient_prenom in patient.prenom%type,
  nom_medicament in medicament.nom%type,
  ret out sys_refcursor)
is
begin
  open ret for 
    select deref(medicament2).nom from interaction 
    where medicament1 = (select ref(med) from medicament med where med.nom = nom_medicament)
    and medicament2 = (select pres.medicament from prescription pres
                           where deref(deref(pres.consultation).patient).nom = patient_nom
                           and deref(deref(pres.consultation).patient).prenom = patient_prenom)
    union all
    select deref(medicament1).nom from interaction 
    where medicament2 = (select ref(med) from medicament med where med.nom = nom_medicament)
    and medicament1 = (select pres.medicament from prescription pres
                           where deref(deref(pres.consultation).patient).nom = patient_nom
                           and deref(deref(pres.consultation).patient).prenom = patient_prenom);
end;
/

declare 
  ret sys_refcursor;
  line medicament.nom%type;
begin
  est_prescrivable('Lorem', 'Ipsum', 'efferalgan', ret);
  loop
    fetch ret into line;
    exit when ret%notfound;
    dbms_output.put_line(line);
  end loop;
  
  close ret;
end;
/



create or replace procedure meilleure_presc
  (nom_maladie in maladie.nom%type,
  nom_medicament in medicament.nom%type,
  ret out sys_refcursor)
is
begin
  open ret for 
    select medo.nom from medicament medo where medo.substance_active in 
                                (select ts.substance_active from substance_active_traitement ts 
                                where deref(deref(ts.traitement).maladie).nom = nom_maladie)
    and medo.nom != nom_medicament
    and medo.nom not in (select deref(i1.medicament2).nom from interaction i1
    where i1.medicament1 = (select ref(med) from medicament med where med.nom = nom_medicament)
    and deref(i1.medicament2).substance_active in (select ts.substance_active from substance_active_traitement ts where deref(deref(ts.traitement).maladie).nom = nom_maladie)
    union all
    select deref(i2.medicament1).nom from interaction i2
    where i2.medicament2 = (select ref(med) from medicament med where med.nom = nom_medicament)
    and deref(i2.medicament1).substance_active in (select ts.substance_active from substance_active_traitement ts where deref(deref(ts.traitement).maladie).nom = nom_maladie));
end;
/

declare 
  ret sys_refcursor;
  line medicament.nom%type;
begin
  meilleure_presc('Peste', 'efferalgan', ret);
  loop
    fetch ret into line;
    exit when ret%notfound;
    dbms_output.put_line(line);
  end loop;
  
  close ret;
end;
/



