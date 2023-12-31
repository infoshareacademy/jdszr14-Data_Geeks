alter table public.name_geographic_information drop column column15;
alter table public.name_geographic_information drop column column16;
alter table public.name_geographic_information rename column numéro_circonscription TO number_circumpscription;
alter table public.name_geographic_information rename column nom_commune TO name_town;
alter table public.name_geographic_information rename column codes_postaux TO post_codes_relative_town;
alter table public.name_geographic_information rename column code_insee TO unique_code_of_town;
alter table public.name_geographic_information rename column éloignement TO distance;
alter table public.region rename column code_region TO code_of_region;
alter table public.region rename column nom_region TO name_of_region;
alter table public.region rename column adm_center TO local_administrative_division;
alter table public.department rename column numéro_département TO code_of_department;
alter table public.department rename column nom_département TO name_of_department;
alter table public.department rename column préfecture TO local_administrative_division;
alter table population rename column nivgeo to geo_lvl;
alter table population rename column moco to cohabitation_mode;
alter table population rename column ageq80_17 to age_category;
alter table population rename column sexe to sex;
alter table population rename column nb to number_of_people_in_the_category;
