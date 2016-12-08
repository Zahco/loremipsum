create type carateristique_type as object (
  description varchar(1024)
);
/

create type patient_type as object (
  nom varchar(128),
  prenom varchar(128),
  age number
);
/

create table carateristique of carateristique_type;
create table patient of patient_type;

create table carateristique_patient (
  carateristique ref carateristique_type,
  patient ref patient_type
);
