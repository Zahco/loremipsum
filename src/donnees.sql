insert into patient values ('Dupont', 'Pierre', 22);
insert into patient values ('Dupont', 'Paul', 22);
insert into patient values ('Lorem', 'Ipsum', 22);
insert into patient values ('Dupont-Lorem', 'Jack', 23);
insert into patient values ('Dupont-Lorem', 'Michel', 18);
insert into patient values ('Aignant', 'Frederique', 46);
insert into patient values ('Lorem', 'Dolores', 23);
insert into patient values ('Durant', 'Paulette', 88);

insert into carateristique values ('Femme');
insert into carateristique values ('Homme');
insert into carateristique values ('Vieux');
insert into carateristique values ('Non humain');


insert into carateristique_patient values (
  (select ref(c) from carateristique c where description = 'Femme'),
  (select ref(p) from patient p where prenom = 'Ipsum')
);
insert into carateristique_patient values (
  (select ref(c) from carateristique c where description = 'Femme'),
  (select ref(p) from patient p where prenom = 'Dolores')
);
insert into carateristique_patient values (
  (select ref(c) from carateristique c where description = 'Femme'),
  (select ref(p) from patient p where prenom = 'Paulette')
);
insert into carateristique_patient values (
  (select ref(c) from carateristique c where description = 'Vieux'),
  (select ref(p) from patient p where prenom = 'Paulette')
);
insert into carateristique_patient values (
  (select ref(c) from carateristique c where description = 'Homme'),
  (select ref(p) from patient p where prenom = 'Frederique')
);
insert into carateristique_patient values (
  (select ref(c) from carateristique c where description = 'Homme'),
  (select ref(p) from patient p where prenom = 'Michel')
);

insert into maladie values ('ehrlichiose', 'https://fr.wikipedia.org/wiki/Ehrlichiose');
insert into maladie values ('mal de los Rastrojos', 'https://fr.wikipedia.org/wiki/Fi%C3%A8vre_h%C3%A9morragique_d%27Argentine');
insert into maladie values ('Balantidiase', 'https://fr.wikipedia.org/wiki/Balantidiase');
insert into maladie values ('Maladie des griffes du chat', 'https://fr.wikipedia.org/wiki/Maladie_des_griffes_du_chat');
insert into maladie values ('Entérovirus', 'https://fr.wikipedia.org/wiki/Ent%C3%A9rovirus');
insert into maladie values ('Streptocoque B', 'https://fr.wikipedia.org/wiki/Streptocoque_B');
insert into maladie values ('Hépatite E', 'https://fr.wikipedia.org/wiki/H%C3%A9patite_E');
insert into maladie values ('Hymenolepis nana', 'https://fr.wikipedia.org/wiki/Hymenolepis_nana');
insert into maladie values ('Pou du pubis', 'https://fr.wikipedia.org/wiki/Pou_du_pubis');
insert into maladie values ('Fièvre Q', 'https://fr.wikipedia.org/wiki/Fi%C3%A8vre_Q');
insert into maladie values ('Syphilis', 'https://fr.wikipedia.org/wiki/Syphilis');
insert into maladie values ('zygomycose', 'https://fr.wikipedia.org/wiki/Mucormycose');
insert into maladie values ('Paludisme', 'https://fr.wikipedia.org/wiki/Paludisme');
insert into maladie values ('Grippe', 'https://fr.wikipedia.org/wiki/Grippe');
insert into maladie values ('Peste', 'https://fr.wikipedia.org/wiki/Peste');
insert into maladie values ('Septicémie', 'https://fr.wikipedia.org/wiki/Sepsis');

insert into substance_active values ('abacavir', 'https://www.vidal.fr/Substance/abacavir-18415.htm');
insert into substance_active values ('abatacept', 'https://www.vidal.fr/Substance/abatacept-22898.htm');
insert into substance_active values ('abciximab', 'https://www.vidal.fr/Substance/abciximab-11965.htm');
insert into substance_active values ('abiratérone', 'https://www.vidal.fr/Substance/abiraterone-23420.htm');
insert into substance_active values ('paracétamol', 'https://www.vidal.fr/Substance/paracetamol-2649.htm');

insert into medicament values ('doliprane',
  (select ref(s) from substance_active s where nom = 'paracétamol')
);
insert into medicament values ('actifed',
  (select ref(s) from substance_active s where nom = 'paracétamol')
);
insert into medicament values ('efferalgan',
  (select ref(s) from substance_active s where nom = 'paracétamol')
);
insert into medicament values ('zytiga',
  (select ref(s) from substance_active s where nom = 'abiratérone')
);

insert into laboratoire values ('CHU', 'Rouen');
insert into laboratoire values ('IGIS', 'Technopole du madrillet');
insert into laboratoire values ('Leo Farma', 'Dreux');

insert into developpement values ('12/03/1994', '12/03/1995',
  (select ref(m) from medicament m where nom = 'actifed'),
  (select ref(l) from laboratoire l where nom = 'CHU')
);
insert into developpement values ('12/03/1995', '12/03/1996',
  (select ref(m) from medicament m where nom = 'doliprane'),
  (select ref(l) from laboratoire l where nom = 'IGIS')
);
insert into developpement values ('12/03/1990', '12/03/1995',
  (select ref(m) from medicament m where nom = 'zytiga'),
  (select ref(l) from laboratoire l where nom = 'CHU')
);

insert into medecin values ('Roy', 'Amedee',
  (select ref(l) from laboratoire l where nom = 'Leo Farma')
);
insert into medecin values ('Marignier', 'Gabin',
  (select ref(l) from laboratoire l where nom = 'Leo Farma')
);
insert into medecin values ('Souris', 'Esther',
  (select ref(l) from laboratoire l where nom = 'CHU')
);
insert into medecin values ('Sourissette', 'Frederique',
  (select ref(l) from laboratoire l where nom = 'IGIS')
);
insert into medecin values ('Pellereau', 'Joris',
  NULL
);

insert into effet_indesirable values ('vomissement');
insert into effet_indesirable values ('démangeaison');
insert into effet_indesirable values ('maux de tête');
insert into effet_indesirable values ('coma');
insert into effet_indesirable values ('mort');
insert into effet_indesirable values ('fatigue');

insert into effet_i_substance_a values (
  (select ref(e) from effet_indesirable e where description = 'paracétamol'),
  (select ref(s) from substance_active s where description = 'mort')
);
insert into effet_i_substance_a values (
  (select ref(e) from effet_indesirable e where description = 'paracétamol'),
  (select ref(s) from substance_active s where description = 'coma')
);
insert into effet_i_substance_a values (
  (select ref(e) from effet_indesirable e where description = 'paracétamol'),
  (select ref(s) from substance_active s where description = 'fatigue')
);
insert into effet_i_substance_a values (
  (select ref(e) from effet_indesirable e where description = 'abiratérone'),
  (select ref(s) from substance_active s where description = 'vomissement')
);


insert into traitement values ( 10, 'conseil: 3 fois par jour'
  (select ref(m) from maladie m where nom = 'Pou du pubis')
);
insert into traitement values ( 10, 'conseil: 3 fois par jour'
  (select ref(m) from maladie m where nom = 'Syphilis')
);
insert into traitement values ( 10, 'conseil: 3 fois par jour'
  (select ref(m) from maladie m where nom = 'Grippe')
);
insert into traitement values ( 10, 'conseil: 3 fois par jour'
  (select ref(m) from maladie m where nom = 'Peste')
);

insert into substance_active_traitement values (
  (select ref(s) from substance_active s where nom = 'paracétamol'),
  (select ref(t) from traitement t where deref(maladie).nom = 'Peste')
);
insert into substance_active_traitement values (
  (select ref(s) from substance_active s where nom = 'abiratérone'),
  (select ref(t) from traitement t where deref(maladie).nom = 'Pou du pubis')
);
insert into substance_active_traitement values (
  (select ref(s) from substance_active s where nom = 'abciximab'),
  (select ref(t) from traitement t where deref(maladie).nom = 'Syphilis')
);
insert into substance_active_traitement values (
  (select ref(s) from substance_active s where nom = 'paracétamol'),
  (select ref(t) from traitement t where deref(maladie).nom = 'Grippe')
);
