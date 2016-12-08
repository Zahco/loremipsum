insert into patient values ('Dupont', 'Pierre', 22);
insert into patient values ('Dupont', 'Paul', 22);
insert into patient values ('Lorem', 'Ipsum', 22);
insert into patient values ('Dupont-Lorem', 'Jack', 23);

insert into carateristique values ('Femme');
insert into carateristique values ('Homme');
insert into carateristique values ('Vieux');
insert into carateristique values ('Non humain');


insert into carateristique_patient values (
  (select ref(c) from carateristique c where description = 'Femme'),
  (select ref(p) from patient p where prenom = 'Ipsum'),
);
