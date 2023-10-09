select * from population p 


--zmiany kolumn population 
alter table population rename column nivgeo to geo_lvl;
alter table population rename column moco to cohabitation_mode;
alter table population rename column ageq80_17 to age_category;
alter table population rename column sexe to sex_id;
alter table population rename column nb to number_of_people_in_the_category;
    
