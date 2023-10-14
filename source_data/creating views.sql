create view population_analysis as
	select 
		s.sex, 
		p.age_category, 
		sum(p.number_of_people_in_the_category)
	from population p 
	join sex s on s.sex_id = p.sex_id 
	group by p.age_category, s.sex
	order by s.sex 	
	
create view sex_region_count as
	select 
		r.name_of_region  , 
		s.sex, 
		sum(p.number_of_people_in_the_category)  
	from population p 
	join base_etablissement_par_tranche_effectif bepte on bepte.codgeo_libgeo_id = p.codgeo_libgeo_id 
	join region r on r.region_id = bepte.region_id 
	join sex s on s.sex_id = p.sex_id 
	group by s.sex, r.name_of_region  
	
create view companies_size_count as
	select 
		sum(bepte.from1to5_emloyees_firms_town + bepte.from6to9_emloyees_firms_town) as mikro,
		sum(bepte.from10to19_emloyees_firms_town + bepte.from20to49_emloyees_firms_town) as small,
		sum(bepte.from100to199_emloyees_firms_town + bepte.from50to99_emloyees_firms_town) as medium,
		sum(bepte.from200to499_emloyees_firms_town  + bepte.more_then_500_emloyees_firms_town) as big
	from base_etablissement_par_tranche_effectif bepte 
	
create view cohabitation_categories_count as
	select cc.cohabitation_mode_description, sum(p.number_of_people_in_the_category)  from population p 
	join cohabitation_categories cc on cc.cohabitation_mode = p.cohabitation_mode 
	group by cc.cohabitation_mode_description 

create view statistic_salary_data_all as
	select 
		avg(nsptc."NS") as srednia,
		mode() within group (order by nsptc."NS") as moda,
		percentile_cont(0.5) within group (order by nsptc."NS") as mediana,
		percentile_cont(0.25) within group (order by nsptc."NS") as "kwartyl_1",
		percentile_cont(0.75) within group (order by nsptc."NS") as "kwartyl_3"
	from net_salary_per_town_categories nsptc 
	
create view statistic_salary_data_woman as
	select 
		avg(nsptc."NS_women") as srednia,
		mode() within group (order by nsptc."NS_women") as moda,
		percentile_cont(0.5) within group (order by nsptc."NS_women") as mediana,
		percentile_cont(0.25) within group (order by nsptc."NS_women") as "kwartyl_1",
		percentile_cont(0.75) within group (order by nsptc."NS_women") as "kwartyl_3"
	from net_salary_per_town_categories nsptc 
	
create view statistic_salary_data_man as
	select 
		avg(nsptc."NS_man") as srednia,
		mode() within group (order by nsptc."NS_man") as moda,
		percentile_cont(0.5) within group (order by nsptc."NS_man") as mediana,
		percentile_cont(0.25) within group (order by nsptc."NS_man") as "kwartyl_1",
		percentile_cont(0.75) within group (order by nsptc."NS_man") as "kwartyl_3"
	from net_salary_per_town_categories nsptc




	