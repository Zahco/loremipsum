select deref(cp.patient) from carateristique_patient cp
where deref(cp.carateristique).description = 'Femme';
