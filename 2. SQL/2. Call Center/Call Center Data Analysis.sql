--- step 1 - create database ---
	create database "call center data analysis"

--- step 2 - create table ---
	create table calls
	(
	id char(100),
 	customer_name char(100),
 	sentiment char(100),
 	csat_score int8,
 	call_timestamp timestamp,
 	reason char(100),
 	city char(100),
 	state char(100),
 	channel char(100),
 	response_time char(100),
 	"call duration in minutes" int8,
 	call_center char(100)
	)

--- step 3 - import data into table ---
	copy calls (id, customer_name, sentiment, csat_score, call_timestamp, reason, city, state, channel, response_time,
				"call duration in minutes", call_center)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\2. Call Center\calls.csv'
	delimiter ','
	csv header

--- step 4 - data cleaning and processing ---
	--
	alter table calls
	alter column call_timestamp type date
	
	--
	alter table calls
	rename column "call duration in minutes" to call_duration_in_minutes

--- step 5 - exploratory data analysis(eda) ---

	-- size and details of data imported
	select * from calls
	select count(*) as rows from calls
	select count(*) as columns from information_schema.columns  where table_name = 'calls'
	select column_name, data_type from information_schema.columns where table_name = 'calls'
	
	-- checking different distinct values
	--
	select
		distinct sentiment
	from calls
	
	--
	select
		distinct reason
	from calls
	
	--
	select
		distinct channel
	from calls
	
	--
	select
		distinct response_time
	from calls
	
	--
	select
		distinct call_center
	from calls
	
	--
	select
		distinct state
	from calls
	
	-- count and percentage from total of each of the distinct values
	--
	select
		sentiment,
		count(*),
		round(100 * count(*)/(select count(*)  from calls), 2) as pct
	from calls
	group by sentiment
	order by pct desc
	
	--
	select
		reason,
		count(*),
		round (100 * count(*)/(select count(*) from calls), 2) as pct
	from calls
	group by reason
	order by pct desc
	
	--
	select
		channel,
		count(*),
		round (100 * count(*)/(select count(*) from calls), 2) as pct
	from calls
	group by channel
	order by pct desc
	
	--
	select
		response_time,
		count(*),
		round(100 * count(*)/(select count(*) from calls), 2) as pct
	from calls
	group by response_time
	order by pct desc
	
	--
	select
		call_center,
		count(*),
		round(100 * count(*)/(select count(*) from calls), 2) as pct
	from calls
	group by call_center
	order by pct desc
	
	--
	select
		state,
		count(*)
	from calls
	group by state
	order by count desc
	
	-- which day has most calls
	select 
		to_char(call_timestamp, 'day')as day,
		count(*) as total_calls
	from calls
	group by day
	order by total_calls desc
	
	-- aggregate functions
	--
	select
		min(csat_score) as min_score,
		max(csat_score)as max_score,
		round(avg(csat_score), 2) as avg_score
	from calls
	where csat_score != 0	
	
	--
	select
		min(call_timestamp) as earliest_date,
		max(call_timestamp) as most_recent
	from calls
	
	--
	select
		min(call_duration_in_minutes) as min_call_duration,
		max(call_duration_in_minutes) as max_call_duration,
		round(avg(call_duration_in_minutes), 2) as avg_call_duration
	from calls
	
	--
	select
		call_center,
		response_time,
		count(*) as count
	from calls
	group by call_center, response_time
	order by call_center, count desc
	
	--
	select
		call_center,
		round(avg(call_duration_in_minutes), 2) as average
	from calls
	group by call_center
	order by average desc
	
	--
	select
		channel,
		round(avg(call_duration_in_minutes), 2) as average
	from calls
	group by channel
	order by average desc
	
	--
	select
		state,
		count(*) as total_count
	from calls
	group by state
	order by total_count desc
	
	--
	select
		state,
		reason,
		count(*)
	from calls
	group by state, reason
	order by state, reason, count
	
	--
	select
		state,
		sentiment,
		count(*)
	from calls
	group by state, sentiment
	order by state, count desc
	
	--
	select
		state,
		round(avg(csat_score), 2) as avg_csat_score
	from calls
	where csat_score != 0
	group by state
	order by avg_csat_score desc
	
	--
	select
		sentiment,
		round(avg(call_duration_in_minutes), 2) as avg_call_duration
	from calls
	group by sentiment
	order by avg_call_duration desc
	
	-- how many calls are within, below or above the service-level-agreement time
	select
		call_timestamp,
		max(call_duration_in_minutes)
			over (partition by call_timestamp) as max_call_duration
	from calls
	group by call_duration_in_minutes, call_timestamp
	order by max_call_duration desc