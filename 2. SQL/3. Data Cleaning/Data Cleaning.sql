--- step 1 - create database ---
	create database "data cleaning"

--- step 2 - create table ---
	create table "laptop_data"
	(
	"Unnamed: 0" char(100),
	Company	char(100),
	TypeName char(100),
	Inches char(100),
	ScreenResolution char(100),
	Cpu char(100),
	Ram	char(100),
	Memory	char(100),
	Gpu	char(100),
	OpSys	char(100),
	Weight	char(100),
	Price char(100)
	)

--- step 3 - import data into table ---
	copy laptop_data ("Unnamed: 0", Company, TypeName, Inches, ScreenResolution, Cpu, Ram, Memory, Gpu, OpSys, Weight, Price)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\3. Data Cleaning\laptop_data.csv'
	delimiter ','
	csv header

--- step 4 - data cleaning ---
	
	-- size and details of the dataset
	select * from laptop_data
	select count(*) as rows from laptop_data
	select count(*) as columns from information_schema.columns where table_name = 'laptop_data'
	select column_name, data_type from information_schema.columns where table_name = 'laptop_data'
	
	-- delete irrelevant columns
	alter table laptop_data
	drop column "Unnamed: 0"

	-- checking null values
	select *
	from laptop_data
	where company is null
    	and typename is null
    	and inches is null
    	and screenresolution is null
    	and cpu is null
    	and ram is null
    	and memory is null
    	and gpu is null
    	and opsys is null
    	and weight is null
    	and price is null
	-- OR --
	select *
	from laptop_data
	where
		coalesce(company, typename, inches, screenresolution, cpu, ram, memory, gpu, opsys, weight, price) is null

	-- delete null values
	delete
	from laptop_data
	where company is null
		and typename is null
		and inches is null
		and screenresolution is null
		and cpu is null
		and ram is null
		and memory is null
		and gpu is null
		and opsys is null
		and weight is null
		and price is null
	-- OR --
	delete
	from laptop_data
	where
		coalesce(company, typename, inches, screenresolution, cpu, ram, memory, gpu, opsys, weight, price) is null

	-- identifying duplicate values
	select
		company,
		typename,
		inches,
		screenresolution,
		cpu,
		ram,
		memory,
		gpu,
		opsys,
		weight,
		price,
		count(*)
	from laptop_data
	group by company, typename, inches, screenresolution, cpu,ram, memory, gpu, opsys, weight, price
	having count(*) > 1
	-- OR --
	with duplicate_values as(
    select
        ctid,
		row_number() over(
		partition by company, typename, inches, screenresolution, cpu, ram, memory, gpu, opsys, weight, price
	order by ctid
    ) as row_num
    from laptop_data
	)
	select *
	from laptop_data
	join duplicate_values
		on laptop_data.ctid = duplicate_values.ctid
	where duplicate_values.row_num > 1

	-- removing duplicate values
	with duplicate_values as(
    select
        ctid,
		row_number() over(
		partition by company, typename, inches, screenresolution, cpu, ram, memory, gpu, opsys, weight, price
	order by ctid
    ) as row_num
    from laptop_data
	)
	delete from laptop_data
	using duplicate_values
	where laptop_data.ctid = duplicate_values.ctid
	and duplicate_values.row_num > 1

	-- checking and correcting datatypes
	select
		column_name, data_type
	from information_schema.columns
	where table_name = 'laptop_data'
	
	-- inches
	select
		distinct inches
	from laptop_data

	select *
	from laptop_data
	where inches = '?'

	delete
	from laptop_data
	where inches = '?'
	
	alter table laptop_data
	alter column inches type decimal(10,1)
		using inches::decimal(10,1)

	-- price
	-- updating data type
	alter table laptop_data
	alter column price type numeric
		using price::numeric

	-- rounding the values
	update laptop_data
	set price = round(price)
	
	-- weight
	-- removing kg keyword
	update laptop_data
	set weight = replace(weight,'kg','')
	
	-- updating data type
	select
		distinct weight
	from laptop_data

	select *
	from laptop_data
	where weight = '?'

	delete
	from laptop_data
	where weight = '?'
		
	alter table laptop_data
	alter column weight type decimal (10,1)
		using weight::decimal (10,1)
	
	-- ram
	-- removing GB keyword
	update laptop_data
	set ram = replace(ram,'GB','')
	
	--updating data type
	select
		distinct ram
	from laptop_data
	
	alter table laptop_data
	alter column ram type int8
		using ram::int8

--- cleaning the remaining columns ---

	-- creating new columns for resolution weight and height
	-- creating the new columns
	alter table laptop_data
	add column resolution_width int8
		-- after screenresolution (after clause is not supported in postgre sql)
	
	alter table laptop_data
	add column resolution_height int8
		-- after screenresolution (after clause is not supported in postgre sql)

	-- extracting the resolution_height
	update laptop_data
	set resolution_height = cast(split_part(screenresolution, 'x', 2) as bigint);
				-- cast clause is used to define the datatype of column
		
	-- extracting the resolution_width
	update laptop_data
	set resolution_width = cast(split_part(split_part(screenresolution, 'x', 1), ' ', -1) as bigint)

	-- creating new column for touchscreen info
	-- creating column
	alter table laptop_data
	add column is_touchscreen int8
		-- after screenresolution (after clause is not supported in postgre sql)
	
	-- updating values in the column
	update laptop_data
	set is_touchscreen = case
		when screenresolution like '%Touchscreen%' then 1 -- (use ilike for case insensitive)
		else 0
		end

	-- separating cpu column values
	-- creating new columns
	alter table laptop_data
	add column cpu_brand varchar(255)
		--after cpu (after clause is not supported in postgre sql)
	
	alter table laptop_data
	add column cpu_name varchar(255)
		--after cpu_brand (after clause is not supported in postgre sql)

	alter table laptop_data
	add column cpu_speed decimal(10,1)
		--after cpu_name (after clause is not supported in postgre sql)

	-- updating values in the column
	update laptop_data
	set cpu_brand = split_part(cpu,' ',1)
	
	update laptop_data
	set cpu_name = regexp_replace (replace(cpu, cpu_brand, ''), '\s+\S+$', '')
	
	update laptop_data
	set cpu_speed = cast (replace (regexp_replace (Cpu, '.*\s(\S+)$', '\1' ), 'GHz', '') as numeric)
	-- below query is to add values with GHz. but before this change column datatype to varchar or text
		-- alter table laptop_data
		-- add column cpu_speed varchar(255)
		-- update laptop_data
		-- set cpu_speed = regexp_replace (cpu, '.*\s(\d+\.?\d*)\s*GHz$', '\1 GHz')

	-- separating values from memory column
	-- creating new columns
	alter  table laptop_data
	add column memory_type varchar(255),
		-- after memory (after clause is not supported in postgre sql)
	add column primary_storage int8,
		-- after memory_type (after clause is not supported in postgre sql)
	add column secondary_storage int8
		-- after primary_storage (after clause is not supported in postgre sql)
	
	-- updating values in columns
	update laptop_data
	set memory_type = case 
		when memory ilike '%ssd%' and memory like '%hdd%' then 'hybrid'
		when memory ilike '%flash storage%' and memory like '%hdd%' then 'hybrid'
		when memory ilike '%ssd%' then 'SSD'
		when memory ilike '%hdd%' then 'HDD'
		when memory ilike '%flash storage%' then 'Flash Storage'
		else 'Null'
		end

	update laptop_data
	set primary_storage = coalesce (nullif (regexp_replace(split_part(memory, '+', 1), '[^0-9]', '', 'g'), '')::int, 0),
    	secondary_storage = coalesce (nullif (regexp_replace (case
												when memory like '%+%' then split_part(memory, '+', 2)
												else '0'
												end,
												'[^0-9]', '', 'g'), '')::int, 0)
											
	-- converting TB values into GB
	update laptop_data
	set primary_storage = case
			when primary_storage <= 2 then primary_storage * 1024
			else primary_storage
			end,
		secondary_storage = case
			when secondary_storage <= 2 then secondary_storage * 1024
			else secondary_storage
			end
											
	-- separating values from gpu column
	-- creating new columns
	alter table laptop_data
	add column gpu_brand varchar(255),
		-- after gpu (after clause is not supported in postgre sql)
	add column gpu_name varchar(255)
		-- after gpu_brand (after clause is not supported in postgre sql)

	-- updating values in column
	update laptop_data
	set gpu_brand = split_part (gpu,' ',1)
		
	update laptop_data
	set gpu_name = replace(gpu,gpu_brand,'')

	-- update opsys column
	update laptop_data
	set opsys = case
		when opsys ilike '%mac%' then 'macos'
		when opsys ilike 'windows%' then 'windows'
		when opsys ilike '%linux%' then 'linux'
		when opsys ilike 'no OS' then 'N/A'
		else 'other'
		end

	-- deleting irrelevant columns post data cleaning process
	alter table laptop_data
	drop column screenresolution,
	drop column cpu,
	drop column gpu,
	drop column memory
	
	-- size and details of dataset post data cleaning
	select * from laptop_data
	select count(*) from laptop_data
	select count(*) from information_schema.columns where table_name = 'laptop_data'
	select column_name, data_type from information_schema.columns where table_name ='laptop_data'
							