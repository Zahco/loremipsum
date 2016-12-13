select deref(cp.patient) from carateristique_patient cp
where deref(cp.carateristique).description = 'Femme';

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
