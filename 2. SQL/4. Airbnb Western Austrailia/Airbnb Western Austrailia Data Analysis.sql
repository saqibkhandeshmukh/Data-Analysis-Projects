--- create table listings ---
	
	create table listings
	(
		id int8,
		name varchar(255),
		host_id int8,
		host_name varchar(255),
		neighbourhood_group varchar(255),
		neighbourhood varchar(255),
		latitude numeric,
		longitude numeric,
		room_type varchar(255),
		price int8,
		minimum_nights int8,
		number_of_reviews int8,
		last_review date,
		reviews_per_month numeric,
		calculated_host_listings_count int8,
		availability_365 int8,
		number_of_reviews_ltm int8,
		license varchar(255)
	)
	
--- import data into listings ---

	copy listings (id, name, host_id, host_name, neighbourhood_group, neighbourhood, latitude, longitude, room_type, price,
				   minimum_nights, number_of_reviews, last_review, reviews_per_month, calculated_host_listings_count,
				   availability_365, number_of_reviews_ltm, license)
	from 'D:\SKD\Data Analyst\3. SQL\4. Project\9. Airbnb Western Austrailia\listings.csv'
	delimiter ','
	csv header
	
--- size and details of listings ---

	select * from listings
	select count(*) as rows from listings
	select count(*) as columns from information_schema.columns where table_name = 'listings'
	select column_name, data_type from information_schema.columns where table_name = 'listings'
	
--- changing data type of column host_id ---

	alter table listings
	alter column host_id type varchar(255)
	
--- Queries ---
	
	-- Q1. How many total listings are there in Western Australia?
		
	-- total listings
	select 
		count(distinct host_id) as total_hosts
	from listings
	
	-- inactive listings
	select
		count(*) as inactive_listings
	from listings
	where (availability_365 = 0 and number_of_reviews = 0)
	
	-- active listings
	select
		count(*) as active_listings
	from listings
	where not
		(availability_365 = 0 and number_of_reviews = 0)
	
	-- hosts x listings
	select
		distinct host_id,
		host_name,
		calculated_host_listings_count as total_listings
	from listings
	order by total_listings desc
	
	-- Follow up: I want to know how many of those hosts’ listings are more than one
	drop table if exists distinct_host;
	create temporary table distinct_host
	select
		distinct host_id,
		host_name, calculated_host_listings_count as total_listings,
		round((100.0 * calculated_hosts_listings_count / total_count.total_listings_count), 2) as percentage_of_total_listings
	from listings
	cross join(
			select
				count (calculated_host_listings_count) as total_listings_count
			from listings
			) as total_count
	order by total_listings desc
		
	select *
	from distinct_host
	
	--
	select
		count (host_id) as number_of_host,
		round(sum(percentage_of_total_listings), 2) as percentage_of_listing
	from distinct_host
	where total_listings > 1
	
	-- Q2. Which areas have the most Airbnb Units in WA, and what is the price range?
		
	-- areas
	select
		count (distinct neighbourhood) as areas
	from listings
	
	-- avg_price
	select
		round(avg (price), 0) as price
	from listings
	
	-- top 10 most listed areas
	select
		neighbourhood,
		count(*) as num_listing
	from listings
	group by neighbourhood
	order by num_listing desc
	limit 10
	
	-- Q3. Do hosts rent out their entire home or just a room?
		
	-- price of different room types
	select
		room_type,
		count(*) as room_type_count,
		round(100 * count(*) / (select count(*) from listings), 2) as percentage,
		round(avg(price), 0) as avg_price
	from listings
	group by room_type
	order by avg_price desc
		
	-- the price in different areas
	select
		neighbourhood as suburb,
		room_type,
		round(avg(price), 0) as avg_price
	from listings
	group by neighbourhood, room_type
	-- having room_type = 'Entire home/apt'
	order by avg_price desc
		
	-- price in waroona neighbourhood
	select
		name,
		host_id,
		neighbourhood,
		room_type,
		price
	from listings
	where neighbourhood = 'WAROONA'
	order by price desc
		
	-- prices of those top 5 areas excluding waroona
	select
		neighbourhood as suburb,
		room_type,
		round(avg(case when host_id = '367775749' then null else price end), 0) as avg_price
	from listings
	group by neighbourhood, room_type
	having room_type = 'Entire home/apt'
	order by avg_price desc
		
	-- for hotel rooms
	select
		neighbourhood as suburb,
		room_type,
		round(avg(price), 0) as avg_price
	from listings
	group by neighbourhood, room_type
	having room_type = 'Hotel room'
	order by avg_price desc
		
	-- For private rooms, I found column ‘name’ shows ‘hotel’ in some rows, but column ‘room_type’ is shown as ‘private room’.
	select
		name,
		price,
		room_type
	from listings
	where name like '%Hotel%'
		
	-- After eliminating those rows in which the ‘name’ column contains the word ’hotel’. We have a more precise result.
	select
		neighbourhood as suburb,
		room_type,
		round (avg(case when name like '%Hotel%' then null else price end), 0) as avg_price
	from listings
	group by neighbourhood, room_type
	having room_type = 'Private room'
	order by avg_price desc
	
	-- for shared rooms
	select
		neighbourhood,
		room_type,
		round (avg(price), 0) as avg_price
	from listings
	group by neighbourhood, room_type
	having room_type = 'Shared room'
	order by avg_price desc
	
	-- Are you as intrigued as I am when I see that Chittering has a shared room that costs $999?
	select *
	from listings
	where
		room_type ='Shared room'
		and neighbourhood = 'CHITTERING'
	order by price desc
	
	-- Q4. Have hosts used Airbnb as a platform for long-term rental to avoid regulations or accountability?
	select
		night_range,
		count(*) as listing_count,
		round(100.0 * count(*) / sum(count(*)) over (), 2) as percentage_of_listing_count,
		round(avg(price), 0) as average_price
	from(
		select
			host_id,
			host_name,
			neighbourhood,
			room_type,
			price,
			minimum_nights,
		case
			when minimum_nights between 1 and 7 then '1 week'
			when minimum_nights between 8 and 14 then '2 weeks'
			when minimum_nights between 15 and 28 then '3-4 weeks'
			else 'over a month'
			end as night_range
		from listings
		) as subquery
	group by night_range
	order by night_range