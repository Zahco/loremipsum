select deref(cp.patient) from carateristique_patient cp
where deref(cp.carateristique).description = 'Femme';

-- 2. une méthode donnant les traitements en cours d’un patient.
create or replace procedure traitement_du_patient
  (nom in patient.nom%type, prenom in patient.prenom%type, ret out traitement%rowtype)
is
begin
  select deref(traitement) into ret
  from traitement_prescription
  where current_date < deref(prescription).debut + deref(traitement).duree
  and prescription = (
    select ref(pr) from prescription pr where patient = (
      select ref(pa) from patient pa where pa.nom = nom and pa.prenom = prenom));
end;
/
