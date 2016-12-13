set serveroutput on;

-- 2. une méthode donnant les traitements en cours d’un patient.
create or replace procedure traitement_du_patient
  (nom in patient.nom%type, prenom in patient.prenom%type, ret out sys_refcursor)
is
begin
  open ret for 
  select deref(deref(traitement).maladie)
  from traitement_prescription
  where current_date < deref(prescription).debut + deref(traitement).duree
  and prescription = (
    select ref(pr) from prescription pr where patient = (
      select ref(pa) from patient pa where pa.nom = nom and pa.prenom = prenom));
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
  dbms_output.put_line(medic_nom);
  open ret for 
  select deref(es.effet_indesirable).description 
  from effet_i_substance_a es
  where es.substance_active = (
    select substance_active from medicament where nom = 'doliprane'
  );
end;
/

declare 
  ret sys_refcursor;
  line effet_indesirable.description%type;
begin
  dbms_output.put_line('coucou');
  ei_par_medicament('doliprane', ret);
  loop
    fetch ret into line;
    exit when ret%notfound;
    dbms_output.put_line(line);
  end loop;
  
  close ret;
end;
/
