CREATE TABLE public.age_categories_table (
	age_category int4 NOT NULL,
	ac_description varchar(25) NOT NULL,
	CONSTRAINT uk_age_category UNIQUE (age_category)
);

CREATE TABLE public.circo (
	eu_circo_id serial4 NOT NULL,
	eu_circo varchar(20) NULL,
	CONSTRAINT circo_pkey PRIMARY KEY (eu_circo_id)
);

CREATE TABLE public.codgeo_libgeo (
	codgeo_libgeo_id serial4 NOT NULL,
	codgeo int4 NULL,
	libgeo varchar(50) NULL,
	CONSTRAINT codgeo_libgeo_pkey PRIMARY KEY (codgeo_libgeo_id)
);

CREATE TABLE public.cohabitation_categories (
	cohabitation_mode int4 NOT NULL,
	cohabitation_mode_description varchar(50) NOT NULL,
	CONSTRAINT uk_cohabitation_mode UNIQUE (cohabitation_mode)
);

CREATE TABLE public.department (
	department_id serial4 NOT NULL,
	code_of_department int4 NULL,
	name_of_department varchar(30) NULL,
	local_administrative_division varchar(30) NULL,
	CONSTRAINT department_pkey PRIMARY KEY (department_id)
);

CREATE TABLE public.region (
	region_id serial4 NOT NULL,
	code_of_region int4 NULL,
	name_of_region varchar(50) NULL,
	local_administrative_division varchar(50) NULL,
	CONSTRAINT region_pkey PRIMARY KEY (region_id)
);

CREATE TABLE public.sex (
	sex_id serial4 NOT NULL,
	sex bpchar(1) NULL,
	CONSTRAINT sex_pkey PRIMARY KEY (sex_id)
);

CREATE TABLE public.base_etablissement_par_tranche_effectif (
	region_number int4 NULL,
	department_number int4 NULL,
	total_number_of_firms_town int4 NULL,
	unknow_null_firms_town int4 NULL,
	from1to5_emloyees_firms_town int4 NULL,
	from6to9_emloyees_firms_town int4 NULL,
	from10to19_emloyees_firms_town int4 NULL,
	from20to49_emloyees_firms_town int4 NULL,
	from50to99_emloyees_firms_town int4 NULL,
	from100to199_emloyees_firms_town int4 NULL,
	from200to499_emloyees_firms_town int4 NULL,
	more_then_500_emloyees_firms_town int4 NULL,
	base_etablissement_id int4 NOT NULL DEFAULT nextval('base_etablissement_par_tranche_effect_base_etablissement_id_seq'::regclass),
	codgeo_libgeo_id int4 NULL,
	region_id int4 NULL,
	CONSTRAINT base_etablissement_par_tranche_effectif_pkey PRIMARY KEY (base_etablissement_id)
);

CREATE TABLE public.name_geographic_information (
	number_circumpscription int4 NULL,
	name_town varchar(50) NULL,
	post_codes_relative_town int4 NULL,
	unique_code_of_town int4 NULL,
	latitude float4 NULL,
	longitude float4 NULL,
	distance varchar(50) NULL,
	name_geographic_id serial4 NOT NULL,
	eu_circo_id int4 NULL,
	region_id int4 NULL,
	department_id int4 NULL,
	CONSTRAINT name_geographic_information_pkey PRIMARY KEY (name_geographic_id)
);

CREATE TABLE public.net_salary_per_town_categories (
	"NS" float4 NULL,
	"NS_executive" float4 NULL,
	"NSH_middle_manager" float4 NULL,
	"NSH_employee" float4 NULL,
	"NSH_worker" float4 NULL,
	"NS_women" float4 NULL,
	"NSH_feminin_executive" float4 NULL,
	"NSH_feminin_middle_manager" float4 NULL,
	"NSH_feminin_employee" float4 NULL,
	"NSH_feminin_worker" float4 NULL,
	"NS_man" float4 NULL,
	"NSH_masculin_executive" float4 NULL,
	"NSH_masculin_middle_manager" float4 NULL,
	"NSH_masculin_employee" float4 NULL,
	"NSH_masculin_worker" float4 NULL,
	"NSH_18_25" float4 NULL,
	"NSH_26_50" float4 NULL,
	"NSH_50high" float4 NULL,
	"NSH_women_18_25" float4 NULL,
	"NSH_women_26_50" float4 NULL,
	"NSH_women_50high" float4 NULL,
	"NSH_men_18_25" float4 NULL,
	"NSH_men_26_50" float4 NULL,
	"NSH_men_50high" float4 NULL,
	net_salary_id serial4 NOT NULL,
	codgeo_libgeo_id int4 NULL,
	CONSTRAINT net_salary_per_town_categories_pkey PRIMARY KEY (net_salary_id)
);

CREATE TABLE public.population (
	geo_lvl varchar(50) NULL,
	cohabitation_mode int4 NULL,
	age_category int4 NULL,
	sex_id int4 NULL,
	number_of_people_in_the_category int4 NULL,
	population_id serial4 NOT NULL,
	codgeo_libgeo_id int4 NULL,
	CONSTRAINT population_pkey PRIMARY KEY (population_id)
);

ALTER TABLE public.population ADD CONSTRAINT fk_ac_id FOREIGN KEY (age_category) REFERENCES public.age_categories_table(age_category);
ALTER TABLE public.population ADD CONSTRAINT fk_cm_id FOREIGN KEY (cohabitation_mode) REFERENCES public.cohabitation_categories(cohabitation_mode);
ALTER TABLE public.population ADD CONSTRAINT fk_codgeo_libgeo_id FOREIGN KEY (codgeo_libgeo_id) REFERENCES public.codgeo_libgeo(codgeo_libgeo_id);
ALTER TABLE public.population ADD CONSTRAINT fk_sex_id FOREIGN KEY (sex_id) REFERENCES public.sex(sex_id);
ALTER TABLE public.net_salary_per_town_categories ADD CONSTRAINT fk_codgeo_libgeo_id FOREIGN KEY (codgeo_libgeo_id) REFERENCES public.codgeo_libgeo(codgeo_libgeo_id);
ALTER TABLE public.name_geographic_information ADD CONSTRAINT fk_department_id FOREIGN KEY (department_id) REFERENCES public.department(department_id);
ALTER TABLE public.name_geographic_information ADD CONSTRAINT fk_eu_circo_id FOREIGN KEY (eu_circo_id) REFERENCES public.circo(eu_circo_id);
ALTER TABLE public.name_geographic_information ADD CONSTRAINT fk_region_id FOREIGN KEY (region_id) REFERENCES public.region(region_id);
ALTER TABLE public.base_etablissement_par_tranche_effectif ADD CONSTRAINT fk_codgeo_libgeo_id FOREIGN KEY (codgeo_libgeo_id) REFERENCES public.codgeo_libgeo(codgeo_libgeo_id);
ALTER TABLE public.base_etablissement_par_tranche_effectif ADD CONSTRAINT fk_region_id FOREIGN KEY (region_id) REFERENCES public.region(region_id);
