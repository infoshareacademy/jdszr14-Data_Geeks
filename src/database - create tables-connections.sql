-- creating the "codgeo_libgeo" table, which will contain data aggregated from the tables
	-- "base_etablissement_par_tranche_effectif",
	-- "net_salary_per_town_categories",
	-- "population"
-- to create relationships between tables.

create table codgeo_libgeo (
	codgeo_libgeo_id serial primary key,
	codgeo int,
	libgeo varchar(50)
	);
	
-- creating a "circo" table containing repeated data from the "name_geographic_information" table, in order to avoid duplicate elements in the database

create table circo (
	eu_circo_id serial primary key,
	eu_circo varchar(20)
	);

-- creating a "region" table containing repeated data from the "name_geographic_information" table, in order to avoid duplicate elements in the database

create table region (
	region_id serial primary key,
	code_region int4 NULL,
	nom_region varchar(50) NULL,
	adm_center varchar(50) NULL
	);

-- creating a "department" table containing repeated data from the "name_geographic_information" table, in order to avoid duplicate elements in the database
	
create table department (
	department_id serial primary key,
	numéro_département int4 NULL,
	nom_département varchar(30) NULL,
	préfecture varchar(30) NULL
	);
	
-- creating the "sex" table, giving the values from the "population" table the corresponding values according to the database documentation.

create table sex (
	sex_id serial primary key,
	sex char
	);
	
-- entering M and K values into the "sex" table for the corresponding primary key values (M-1, K-2)

insert into sex (sex) VALUES('M');
insert into sex (sex) VALUES('K');

-- inserting data into the codgeo-libgeo table using the UNION function (loading unique data from all tables)
	-- "base_etablissement_par_tranche_effectif",
	-- "net_salary_per_town_categories",
	-- "population"

insert into codgeo_libgeo (codgeo, libgeo)
	select codgeo, libgeo from base_etablissement_par_tranche_effectif
union
	select codgeo, libgeo from net_salary_per_town_categories
union
	select codgeo, libgeo from population;

-- inserting data into the "circo" table from "name_geographic_information"

insert into circo (eu_circo)
	select distinct eu_circo from name_geographic_information;

-- inserting data into the "region" table from "name_geographic_information"
	
insert into region (code_region, nom_region, adm_center)
	select distinct code_région, nom_région, "chef.lieu_région" from name_geographic_information;

-- inserting data into the "department" table from "name_geographic_information"
	
insert into department (numéro_département, nom_département, préfecture)
	select distinct numéro_département, nom_département, préfecture from name_geographic_information;

-- adding additional columns to table "name_geographic_information":
	-- column "name_geographic_id" will be PRIMARY KEY
	-- columns "eu_circo_id", "region_id", "department_id" will be FOREIGN KEYS

alter table name_geographic_information 
	add column name_geographic_id serial primary key,
	add column eu_circo_id int,
	add column region_id int,
	add column department_id int;

-- adding additional columns to table "name_geographic_information":
	-- column "base_etablissement_id" will be PRIMARY KEY
	-- columns "codgeo_libgeo_id", "region_id" will be FOREIGN KEYS

alter table base_etablissement_par_tranche_effectif 
	add column base_etablissement_id serial primary key,
	add column codgeo_libgeo_id int,
	add column region_id int;

-- adding additional columns to table "name_geographic_information":
	-- column "net_salary_id" will be PRIMARY KEY
	-- column "codgeo_libgeo_id" will be FOREIGN KEY

alter table net_salary_per_town_categories 
	add column net_salary_id serial primary key,
	add column codgeo_libgeo_id int;

-- adding additional columns to table "name_geographic_information":
	-- column "population_id" will be PRIMARY KEY
	-- column "codgeo_libgeo_id" will be FOREIGN KEY

alter table population 
	add column population_id serial primary key,
	add column codgeo_libgeo_id int;

-- filling the "codgeo_libgeo_id" column in the "base_etablissement_par_tranche_effectif" table with the value from the "codgeo_libgeo" table according to the indicated condition

update base_etablissement_par_tranche_effectif as A
	set codgeo_libgeo_id = B.codgeo_libgeo_id
	from codgeo_libgeo as B
	where A.codgeo = B.codgeo and A.libgeo = B.libgeo;

-- filling the "region_id" column in the "base_etablissement_par_tranche_effectif" table with the value from the "region" table according to the indicated condition
	
update base_etablissement_par_tranche_effectif as A
	set region_id = B.region_id
	from region as B
	where A.reg = B.code_region;

-- filling the "codgeo_libgeo_id" column in the "net_salary_per_town_categories" table with the value from the "codgeo_libgeo" table according to the indicated condition

update net_salary_per_town_categories as A
	set codgeo_libgeo_id = B.codgeo_libgeo_id
	from codgeo_libgeo as B
	where A.codgeo = B.codgeo and A.libgeo = B.libgeo; 

-- filling the "codgeo_libgeo_id" column in the "population" table with the value from the "codgeo_libgeo" table according to the indicated condition

update population as A
	set codgeo_libgeo_id = B.codgeo_libgeo_id
	from codgeo_libgeo as B
	where A.codgeo = B.codgeo and A.libgeo = B.libgeo; 

-- filling the "eu_circo_id" column in the "name_geographic_information" table with the value from the "circo" table according to the indicated condition

update name_geographic_information as A
	set eu_circo_id = B.eu_circo_id
	from circo as B
	where A.eu_circo = B.eu_circo;

-- filling the "region_id" column in the "name_geographic_information" table with the value from the "region" table according to the indicated condition

update name_geographic_information as A
	set region_id = B.region_id
	from region as B
	where A.code_région = B.code_region and A.nom_région = B.nom_region and A."chef.lieu_région" = B.adm_center;

-- filling the "department_id" column in the "name_geographic_information" table with the value from the "department" table according to the indicated condition

update name_geographic_information as A
	set department_id = B.department_id
	from department as B
	where A.numéro_département = B.numéro_département and A.nom_département = B.nom_département and A.préfecture = B.préfecture;

-- setting foreign keys for table "base_etablissement_par_tranche_effectif"

alter table base_etablissement_par_tranche_effectif
	add constraint fk_codgeo_libgeo_id foreign key (codgeo_libgeo_id) references codgeo_libgeo(codgeo_libgeo_id),
	add constraint fk_region_id foreign key (region_id) references region(region_id);

-- setting foreign key for table "net_salary_per_town_categories"

alter table net_salary_per_town_categories
	add constraint fk_codgeo_libgeo_id foreign key (codgeo_libgeo_id) references codgeo_libgeo(codgeo_libgeo_id);

-- setting foreign keys for table "population"

alter table population
	add constraint fk_codgeo_libgeo_id foreign key (codgeo_libgeo_id) references codgeo_libgeo(codgeo_libgeo_id),
	add constraint fk_sex_id foreign key (sexe) references sex(sex_id);

-- setting foreign keys for table "name_geographic_information"

alter table name_geographic_information
	add constraint fk_eu_circo_id foreign key (eu_circo_id) references circo(eu_circo_id),
	add constraint fk_region_id foreign key (region_id) references region(region_id),
	add constraint fk_department_id foreign key (department_id) references department(department_id);

-- cleaning all tables from unnecessary columns

alter table population 
	drop column codgeo,
	drop column libgeo;

alter table base_etablissement_par_tranche_effectif 
	drop column codgeo,
	drop column libgeo;

alter table net_salary_per_town_categories 
	drop column codgeo,
	drop column libgeo;

alter table name_geographic_information
	drop column eu_circo,
	drop column code_région,
	drop column nom_région,
	drop column "chef.lieu_région",
	drop column numéro_département,
	drop column nom_département,
	drop column préfecture;
	


