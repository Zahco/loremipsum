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
  description varchar(1024),
  effet_indesirable ref effet_indesirable_type
);
/
create table effet_indesirable of effet_indesirable_type;

create type substance_active_type as object (
  nom varchar(128),
  description varchar(1024),
  substance_active ref substance_active_type
);
/
create table substance_active of substance_active_type;

create table effet_i_substance_a (
  effet_indesirable ref effet_indesirable_type,
  substance_active ref substance_active_type
);

create type medicament_type as object (
  nom varchar(128),
  substance_active ref substance_active_type
);
/
create table medicament of medicament_type;

create type interaction_type as object (
  medicament1 ref medicament_type,
  medicament2 ref medicament_type
);
/
create table interaction of interaction_type;

create type maladie_type as object (
  nom varchar(128),
  description varchar(1024),
  maladie ref maladie_type
);
/
create table maladie of maladie_type;


create type laboratoire_type as object (
  nom varchar(128),
  adresse varchar(128)
);
/
create table laboratoire of laboratoire_type;

create type developpement_type as object (
  date_debut date,
  date_fin date,
  medicament ref medicament_type,
  laboratoire ref laboratoire_type
);
/
create table developpement of developpement_type;

create type medecin_type as object (
  nom varchar(128),
  prenom varchar(128),
  laboratoire ref laboratoire_type
);
/
create table medecin of medecin_type;

create table medecin_developpement (
  medecin ref medecin_type,
  developpement ref developpement_type
);

create type consultation_type as object (
  dateT date,
  medecin ref medecin_type
);
/
create table consultation of consultation_type;

create type traitement_type as object (
  duree number,
  conseil varchar(2048),
  maladie ref maladie_type
);
/
create table traitement of traitement_type;

create table substance_active_traitement (
  substance_active ref substance_active_type,
  traitement ref traitement_type
);

create table maladie_chronique (
  patient ref patient_type,
  maladie ref maladie_type
);

create type symptome_type as object (
  description varchar(1024),
  maladie ref maladie_type
);
/
create table symptome of symptome_type;

create table symptome_consultation (
  consultation ref consultation_type,
  symptome ref symptome_type
);

create type prescription_type as object(
  debut date,
  consultation ref consultation_type,
  medicament ref medicament_type,
  patient ref patient_type
);
/
create table prescription of prescription_type;

create table traitement_prescription(
  traitement ref traitement_type,
  prescription ref prescription_type
);
