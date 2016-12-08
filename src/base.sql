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

create type effet_indesirable_type as object (
  description varchar(1024)
);
/
create table effet_indesirable of effet_indesirable_type;

create type substance_active_type as object (
  description varchar(1024)
);
/
create table substance_active of substance_active_type;

create table effet_indesirable_substance_active (
  effet_indesirable ref effet_indesirable_type,
  substance_active ref substance_active_type
);

create type maladie_type as object (
  description varchar(1024)
);
/
create table maladie of maladie_type;
/*
create type interaction_type as object (
  medicament
);*/
