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
  (select ref(p) from patient p where prenom = 'Ipsum')
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
insert into maladie values ('peste', 'https://fr.wikipedia.org/wiki/Peste'); 
insert into maladie values ('Septicémie', 'https://fr.wikipedia.org/wiki/Sepsis'); 



