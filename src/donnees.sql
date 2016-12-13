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

insert into maladie values ('ehrlichiose', 'https://fr.wikipedia.org/wiki/Ehrlichiose', null);
insert into maladie values ('mal de los Rastrojos', 'https://fr.wikipedia.org/wiki/Fi%C3%A8vre_h%C3%A9morragique_d%27Argentine', null);
insert into maladie values ('Balantidiase', 'https://fr.wikipedia.org/wiki/Balantidiase', null);
insert into maladie values ('Maladie des griffes du chat', 'https://fr.wikipedia.org/wiki/Maladie_des_griffes_du_chat', null);
insert into maladie values ('Entérovirus', 'https://fr.wikipedia.org/wiki/Ent%C3%A9rovirus', null);
insert into maladie values ('Streptocoque B', 'https://fr.wikipedia.org/wiki/Streptocoque_B', null);
insert into maladie values ('Hépatite A', 'https://fr.wikipedia.org/wiki/H%C3%A9patite_A', (select ref(m) from maladie m where nom = 'Hépatites Virales Humaine'));
insert into maladie values ('Hépatite B', 'https://fr.wikipedia.org/wiki/H%C3%A9patite_B', (select ref(m) from maladie m where nom = 'Hépatites Virales Humaine'));
insert into maladie values ('Hépatite C', 'https://fr.wikipedia.org/wiki/H%C3%A9patite_C', (select ref(m) from maladie m where nom = 'Hépatites Virales Humaine'));
insert into maladie values ('Hépatite D', 'https://fr.wikipedia.org/wiki/H%C3%A9patite_D', (select ref(m) from maladie m where nom = 'Hépatites Virales Humaine'));
insert into maladie values ('Hépatite E', 'https://fr.wikipedia.org/wiki/H%C3%A9patite_E', (select ref(m) from maladie m where nom = 'Hépatites Virales Humaine'));
insert into maladie values ('Hépatites Virales Humaine', 'http://www.hetop.eu', null);
insert into maladie values ('Hymenolepis nana', 'https://fr.wikipedia.org/wiki/Hymenolepis_nana', null);
insert into maladie values ('Pou du pubis', 'https://fr.wikipedia.org/wiki/Pou_du_pubis', null);
insert into maladie values ('Fièvre Q', 'https://fr.wikipedia.org/wiki/Fi%C3%A8vre_Q', null);
insert into maladie values ('Syphilis', 'https://fr.wikipedia.org/wiki/Syphilis', null);
insert into maladie values ('zygomycose', 'https://fr.wikipedia.org/wiki/Mucormycose', null);
insert into maladie values ('Paludisme', 'https://fr.wikipedia.org/wiki/Paludisme', null);
insert into maladie values ('Grippe', 'https://fr.wikipedia.org/wiki/Grippe', null);
insert into maladie values ('Peste', 'https://fr.wikipedia.org/wiki/Peste', null);
insert into maladie values ('Septicémie', 'https://fr.wikipedia.org/wiki/Sepsis', null);
insert into maladie values ('Diabète', 'https://fr.wikipedia.org/wiki/Diabète', null);
insert into maladie values ('Epilepsie', 'https://fr.wikipedia.org/wiki/Epilepsie', null);
insert into maladie values ('Alzheimer', 'https://fr.wikipedia.org/wiki/Alzheimer', null);

insert into maladie_chronique values (
  (select ref(p) from patient p where nom = 'Lorem' and prenom = 'Dolores'),
  (select ref(m) from maladie m where nom = 'Diabète')
);
insert into maladie_chronique values (
  (select ref(p) from patient p where nom = 'Lorem' and prenom = 'Dolores'),
  (select ref(m) from maladie m where nom = 'Epilepsie')
);
insert into maladie_chronique values (
  (select ref(p) from patient p where nom = 'Lorem' and prenom = 'Dolores'),
  (select ref(m) from maladie m where nom = 'Alzheimer')
);
insert into maladie_chronique values (
  (select ref(p) from patient p where nom = 'Lorem' and prenom = 'Ipsum'),
  (select ref(m) from maladie m where nom = 'Alzheimer')
);

insert into substance_active values ('abacavir', 'https://www.vidal.fr/Substance/abacavir-18415.htm', null);
insert into substance_active values ('abatacept', 'https://www.vidal.fr/Substance/abatacept-22898.htm', null);
insert into substance_active values ('abciximab', 'https://www.vidal.fr/Substance/abciximab-11965.htm', null);
insert into substance_active values ('abiratérone', 'https://www.vidal.fr/Substance/abiraterone-23420.htm', null);
insert into substance_active values ('paracétamol', 'https://www.vidal.fr/Substance/paracetamol-2649.htm', null);
insert into substance_active values ('salicylates', 'http://www.hetop.eu', null);
insert into substance_active values ('acide acetylsalicylique', 'https://www.vidal.fr/substances/20/acide_acetylsalicylique/', (select ref(s) from substance_active s where nom = 'salicylates'));
insert into substance_active values ('Acides amino-salicyliques', 'http://www.hetop.eu', (select ref(s) from substance_active s where nom = 'salicylates'));


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
insert into medicament values ('aspirine',
  (select ref(s) from substance_active s where nom = 'acide acetylsalicylique')
);

insert into interaction values (
  (select ref(m1) from medicament m1 where nom = 'doliprane'),
  (select ref(m2) from medicament m2 where nom = 'actifed')
);
insert into interaction values (
  (select ref(m1) from medicament m1 where nom = 'doliprane'),
  (select ref(m2) from medicament m2 where nom = 'efferalgan')
);
insert into interaction values (
  (select ref(m1) from medicament m1 where nom = 'efferalgan'),
  (select ref(m2) from medicament m2 where nom = 'actifed')
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

insert into effet_indesirable values ('Effet secondaire d une médication', null);
insert into effet_indesirable values ('vomissement',  (select ref(e) from effet_indesirable e where description = 'Effet secondaire d une médication'));
insert into effet_indesirable values ('démangeaison', (select ref(e) from effet_indesirable e where description = 'Effet secondaire d une médication'));
insert into effet_indesirable values ('eruption', (select ref(e) from effet_indesirable e where description = 'Effet secondaire d une médication'));
insert into effet_indesirable values ('maux de tête', (select ref(e) from effet_indesirable e where description = 'Effet secondaire d une médication'));
insert into effet_indesirable values ('coma', (select ref(e) from effet_indesirable e where description = 'Effet secondaire d une médication'));
insert into effet_indesirable values ('mort non digne', (select ref(e) from effet_indesirable e where description = 'Effet secondaire d une médication'));
insert into effet_indesirable values ('fatigue', (select ref(e) from effet_indesirable e where description = 'Effet secondaire d une médication'));

insert into effet_i_substance_a values (
  (select ref(s) from effet_indesirable s  where description = 'mort non digne'),
  (select ref(e) from substance_active e where description = 'paracétamol')
);
insert into effet_i_substance_a values (
  (select ref(s) from effet_indesirable s  where description = 'coma'),
  (select ref(e) from substance_active e where description = 'paracétamol')
);
insert into effet_i_substance_a values (
  (select ref(s) from effet_indesirable s  where description = 'maux de tête'),
  (select ref(e) from substance_active e where description = 'paracétamol')
);
insert into effet_i_substance_a values (
  (select ref(s) from effet_indesirable s  where description = 'maux de tête'),
  (select ref(e) from substance_active e where description = 'abiratérone')
);



insert into traitement values ( 10, 'conseil: 3 fois par jour',
  (select ref(m) from maladie m where nom = 'Pou du pubis')
);
insert into traitement values ( 10, 'conseil: 4 fois par jour',
  (select ref(m) from maladie m where nom = 'Syphilis')
);
insert into traitement values ( 10, 'conseil: 30 fois par jour',
  (select ref(m) from maladie m where nom = 'Grippe')
);
insert into traitement values ( 10, 'conseil: 1 fois par jour',
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
