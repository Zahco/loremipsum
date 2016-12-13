set serveroutput on;

-- 1. une méthode donnant un traitement à un patient.
create or replace procedure prescrire
  (nom_patient in patient.nom%type, 
  prenom_patient in patient.prenom%type, 
  nom_maladie in maladie.nom%type, 
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


execute prescrire('Lorem', 'Ipsum', 'Peste', 'Roy', 'Amedee', '10-10-10', 'doliprane');


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

