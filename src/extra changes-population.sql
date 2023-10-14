-- tworzenie tabel talic do kolumn 'cohabitaton_mode' i 'age_category'/making tables 'cohabitation_categories' and 'age_categories_table'
create table cohabitation_categories
(cohabitation_mode INT primary key not null,
cohabitation_mode_description varchar (50) not null);

create table age_categories_table
(age_category INT primary key not null,
ac_description varchar (25) not null);
--

--uzupełnianie tabel 'cohabitation_mode' i 'age_category'/ filing in tables
insert into age_categories_table
(age_category, ac_description)
values 
(0, 'people between 0-4'),
(5, 'people between 5-9'),
(10, 'people between 10-14'),
(15, 'people between 15-19'),
(20, 'people between 20-24'),
(25, 'people between 25-29'),
(30, 'people between 30-34'),
(35, 'people between 35-39'),
(40, 'people between 40-44'),
(45, 'people between 45-49'),
(50, 'people between 50-54'),
(55, 'people between 55-59'),
(60, 'people between 60-64'),
(65, 'people between 65-69'),
(70, 'people between 70-74'),
(75, 'people between 75-79'),
(80, 'people 80+');


insert into cohabitation_categories 
(cohabitation_mode, cohabitation_mode_description)
values 
(11, 'children living with two parents'),
(12, 'children living with one parent'),
(21, 'adults living in couple without child'),
(22, 'adults living in couple with children'),
(23, 'adults living alone with children'),
(31, 'people not from family living in the home'),
(32, 'people living alone');
--

--nadawanie uniqów utoworznym tabelom/ making uniques
alter table age_categories_table
add constraint uk_age_category unique (age_category)
alter table cohabitation_categories 
add constraint uk_cohabitation_mode unique (cohabitation_mode);
--

--nadawanie kluczy obcych/ making foreign keys
alter table population
add constraint fk_cm_id foreign key (cohabitation_mode) references cohabitation_categories(cohabitation_mode),
add constraint fk_ac_id foreign key (age_category) references age_categories_table(age_category);
--



