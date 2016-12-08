create type carateristique_type as object (
  description varchar(1024)
);
/
create table carateristique of carateristique_type;

create type patient_type as object (
  nom varchar(128),
  prenom varchar(128),
  age number
);
/
create table patient of patient_type;

create table carateristique_patient (
  carateristique ref carateristique_type,
  patient ref patient_type
);

create type laboratoire_type as object (
  nom varchar(128),
  adresse varchar(128)
);
create table laboratoire of laboratoire_type;

create type developpement_type as object (
  date_debut date,
  date_fin date,
  medicament ref medicament_type,
  laboratoire ref laboratoire_type
);

create table developpement of developpement_type;
