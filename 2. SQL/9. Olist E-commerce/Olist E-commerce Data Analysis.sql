--- create database ---
	create database "olist e-commerce data_analysis"

--- create table olist_customers ---
	create table olist_customers
	(
		customer_id varchar(255),
		customer_unique_id varchar(255),
		customer_zip_code_prefix varchar(255),
		customer_city varchar(255),
		customer_state varchar(255)
	)
	
--- importing data into table ---	
	copy olist_customers (customer_id, customer_unique_id, customer_zip_code_prefix, customer_city,
						  customer_state)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\10. Olist E-commerce\Dataset\olist_customers_dataset.csv'
	delimiter ','
	csv header
	
--- size and details of table ---	
	select * from olist_customers
	select count(*) as rows from olist_customers
	select count(*) as columns from information_schema.columns where table_name = 'olist_customers'
	select column_name, data_type from information_schema.columns where table_name = 'olist_customers'
	
--- create table olist_geolocation ---
	create table olist_geolocation
	(
		geolocation_zip_code_prefix varchar(255),
		geolocation_lat decimal,
		geolocation_lng decimal,
		geolocation_city varchar(255),
		geolocation_state varchar(255)
	)
	
--- importing data into table ---	
	copy olist_geolocation (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city,
							geolocation_state)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\10. Olist E-commerce\Dataset\olist_geolocation_dataset.csv'
	delimiter ','
	csv header
	
--- size and details of table ---	
	select * from olist_geolocation
	select count(*) as rows from olist_geolocation
	select count(*) as columns from information_schema.columns where table_name = 'olist_geolocation'
	select column_name, data_type from information_schema.columns where table_name = 'olist_geolocation'
	
--- create table olist_order_items ---
	create table olist_order_items
	(
		order_id varchar(255),
		order_item_id int8,
		product_id varchar(255),
		seller_id varchar(255),
		shipping_limit_date timestamp,
		price decimal,
		freight_value decimal
	)
	
--- importing data into table ---	
	copy olist_order_items (order_id, order_item_id, product_id, seller_id, shipping_limit_date, price,
							freight_value)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\10. Olist E-commerce\Dataset\olist_order_items_dataset.csv'
	delimiter ','
	csv header
	
--- size and details of table ---	
	select * from olist_order_items
	select count(*) as rows from olist_order_items
	select count(*) as columns from information_schema.columns where table_name = 'olist_order_items'
	select column_name, data_type from information_schema.columns where table_name = 'olist_order_items'

	-- rename table
	alter table olist_order_items
	rename to olist_items
	
--- create table olist_order_payments ---
	create table olist_order_payments
	(
		order_id varchar(255),
		payment_sequential int8,
		payment_type varchar(255),
		payment_installments int8,
		payment_value decimal
	)
	
--- importing data into table ---	
	copy olist_order_payments (order_id, payment_sequential, payment_type, payment_installments,
						  payment_value)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\10. Olist E-commerce\Dataset\olist_order_payments_dataset.csv'
	delimiter ','
	csv header
	
--- size and details of table ---	
	select * from olist_order_payments
	select count(*) as rows from olist_order_payments
	select count(*) as columns from information_schema.columns where table_name = 'olist_order_payments'
	select column_name, data_type from information_schema.columns where table_name = 'olist_order_payments'
	
--- create table olist_order_reviews ---
	create table olist_order_reviews
	(
		review_id varchar(255),
		order_id varchar(255),
		review_score int8
	)
	
--- importing data into table ---	
	copy olist_order_reviews (review_id, order_id, review_score)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\10. Olist E-commerce\Dataset\olist_order_reviews.csv'
	delimiter ','
	csv header
	
--- size and details of table ---	
	select * from olist_order_reviews
	select count(*) as rows from olist_order_reviews
	select count(*) as columns from information_schema.columns where table_name = 'olist_order_reviews'
	select column_name, data_type from information_schema.columns where table_name = 'olist_order_reviews'
	
--- create table olist_orders ---
	create table olist_orders
	(
		order_id varchar(255),
		customer_id varchar(255),
		order_status varchar(255),
		order_purchase_timestamp timestamp,
		order_approved_at timestamp,
		order_delivered_carrier_date timestamp,
		order_delivered_customer_date timestamp,
		order_estimated_delivery_date timestamp
	)
	
--- importing data into table ---	
	copy olist_orders (order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at,
					   order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\10. Olist E-commerce\Dataset\olist_orders_dataset.csv'
	delimiter ','
	csv header
	
--- size and details of table ---	
	select * from olist_orders
	select count(*) as rows from olist_orders
	select count(*) as columns from information_schema.columns where table_name = 'olist_orders'
	select column_name, data_type from information_schema.columns where table_name = 'olist_orders'
	
--- create table olist_products ---
	create table olist_products
	(
		product_id varchar(255),
		product_category_name varchar(255),
		product_name_length int8,
		product_description_length int8,
		product_photos_qty int8,
		product_weight_g int8,
		product_length_cm int8,
		product_height_cm int8,
		product_width_cm int8
	)
	
--- importing data into table ---	
	copy olist_products (product_id, product_category_name, product_name_length, product_description_length,
						 product_photos_qty, product_weight_g, product_length_cm, product_height_cm,
						 product_width_cm)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\10. Olist E-commerce\Dataset\olist_products_dataset.csv'
	delimiter ','
	csv header
	
--- size and details of table ---	
	select * from olist_products
	select count(*) as rows from olist_products
	select count(*) as columns from information_schema.columns where table_name = 'olist_products'
	select column_name, data_type from information_schema.columns where table_name = 'olist_products'
	
--- create table olist_sellers ---
	create table olist_sellers
	(
		seller_id varchar(255),
		seller_zip_code_prefix varchar(255),
		seller_city varchar(255),
		seller_state varchar(255)
	)
	
--- importing data into table ---	
	copy olist_sellers (seller_id, seller_zip_code_prefix, seller_city, seller_state)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\10. Olist E-commerce\Dataset\olist_sellers_dataset.csv'
	delimiter ','
	csv header
	
--- size and details of table ---	
	select * from olist_sellers
	select count(*) as rows from olist_sellers
	select count(*) as columns from information_schema.columns where table_name = 'olist_sellers'
	select column_name, data_type from information_schema.columns where table_name = 'olist_sellers'
	
--- create table product_category_name_translation ---
	create table product_category_name_translation
	(
		product_category_name varchar(255),
		product_category_name_english varchar(255)
	)
	
--- importing data into table ---	
	copy product_category_name_translation (product_category_name, product_category_name_english)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\10. Olist E-commerce\Dataset\product_category_name_translation.csv'
	delimiter ','
	csv header
	
--- size and details of table ---	
	select * from product_category_name_translation
	select count(*) as rows from product_category_name_translation
	select count(*) as columns from information_schema.columns where table_name = 'product_category_name_translation'
	select column_name, data_type from information_schema.columns where table_name = 'product_category_name_translation'
	
--- updating data ---	
	-- updating olist_products to add the column 'product_category_name_english' to join the same column from 'product_category_name_translation'
	alter table olist_products
	add column product_category_name_english varchar(255)

	--
	update olist_products op
	set product_category_name_english = pcnt.product_category_name_english
	from product_category_name_translation pcnt
	where op.product_category_name = pcnt.product_category_name;
	
	-- updating null values to N/A
	select *
	from olist_products op
	where op.product_category_name = ''
		or op.product_category_name is null;
		
	--
	update olist_products
	set product_category_name = 'N/A'
	where product_category_name = ''
		or product_category_name is null
	
	--
	update olist_products
	set product_category_name_english = 'N/A'
	where product_category_name_english is null
	
	--
	select
		product_category_name,
		product_category_name_english
	from olist_products op
	where product_category_name_english = 'N/A'
	
	-- updating 'portateis_cozinha_e_preparadores_de_alimentos' = 'portable_kitchen_and_food_preparers'
	select
		product_category_name,
		product_category_name_english
	from olist_products op
	where product_category_name = 'portateis_cozinha_e_preparadores_de_alimentos'
	
	--
	update olist_products
	set product_category_name_english = 'portable_kitchen_and_food_preparers'
	where product_category_name = 'portateis_cozinha_e_preparadores_de_alimentos'
	
	--
	update olist_products
	set product_category_name_english = 'pc_gamer'
	where product_category_name = 'pc_gamer'
	
--- data analysis ---

--- answering business questions ---
	-- Q1. What is the total revenue generated by Olist, and how has it changed over time?
	
	--timeframe of the dataset
	select
		min(order_purchase_timestamp) as start_date,
		max(order_purchase_timestamp) as end_date
	from olist_orders oo
	
	-- types of order_status
	select
		order_status,
		count(*) as invalid_orders
	from olist_orders oo
	where order_delivered_customer_date is null
	group by order_status
	
	-- total revenue
	select
		round(sum(oop.payment_value), 0) as total_revenue
	from olist_orders oo
	join olist_order_payments oop
		on oo.order_id = oop.order_id
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
		
	-- yearly sales
	select
		to_char(oo.order_purchase_timestamp, 'YYYY') as the_year,
		round(sum(oop.payment_value), 0) as revenue
	from olist_orders oo
	join olist_order_payments oop
		on oo.order_id = oop.order_id
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by the_year
	order by the_year
	
	-- quarterly sales
	select
		extract(year from oo.order_purchase_timestamp) as the_year,
		extract(quarter from oo.order_purchase_timestamp) as the_quarter,
		round (sum(oop.payment_value), 0) as revenue
	from olist_orders oo
	join olist_order_payments oop
		on oo.order_id = oop.order_id
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by the_year, the_quarter
	order by the_year, the_quarter
	
	-- monthly sales
	select
		extract(year from oo.order_purchase_timestamp) as the_year,
		extract(quarter from oo.order_purchase_timestamp) as the_quarter,
		extract(month from oo.order_purchase_timestamp) as the_month,
		round(sum(oop.payment_value), 0) as revenue
	from olist_orders oo
	join olist_order_payments oop
		on oo.order_id = oop.order_id
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by the_year, the_quarter, the_month
	order by revenue desc
	
	-- Q2. How many orders were placed on Olist, and how does this vary by month or season?
	
	-- total orders placed
	select
		count(*) as num_order
	from olist_orders oo
	where
		order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	
	-- quarterly orders
	select
		extract(year from order_purchase_timestamp) as the_year,
		extract(quarter from order_purchase_timestamp) as the_quarter,
		count(*) as num_order
	from olist_orders oo
	where
		order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by the_year, the_quarter
	order by the_year, the_quarter
	
	-- monthly orders
	select
		extract(year from order_purchase_timestamp) as the_year,
		extract(month from order_purchase_timestamp) as the_month,
		count(*) as num_order
	from olist_orders oo
	where
		order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by the_year, the_month
	order by num_order desc
	
	-- Q3. What are the most popular product categories on Olist, and how do their sales volumes compare to each other?
	-- in the description of the dataset on Kaggle, it was mentioned that an order might have multiple items and product_id
	
	-- total product_id
	select
		count(oi.product_id) as total_product_id
	from olist_items oi
	join olist_orders oo
		on oi.order_id = oo.order_id
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	
	-- most popular product categories
	select
		op.product_category_name_english as product_name,
		count(oo.order_id) as num_orders,
		round(100.0 * count(oo.order_id) / total_orders.total_num_orders, 2) as percentage
	from olist_orders oo
	join olist_items oi
		on oo.order_id = oi.order_id
	join(
		select
			product_id,
			product_category_name_english
		from olist_products
		) as op
		on oi.product_id = op.product_id
	cross join(
			select
				count(oo.order_id) as total_num_orders
			from olist_orders oo
			join olist_items oi
				on oo.order_id = oi.order_id
			join olist_products op
				on oi.product_id = op.product_id
			where
				oo.order_status <> 'canceled'
				and oo.order_delivered_customer_date is not null -- 110,189 rows
			) as total_orders
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by op.product_category_name_english, total_orders.total_num_orders
	order by  percentage desc
	
	-- products performance during the 3 year time period
	select
		extract (year from oo.order_purchase_timestamp) as the_year,
		op.product_category_name_english as product_name,
		count(oo.order_id) as num_order,
		rank() over(order by count(oo.order_id) desc) as product_rank
	from olist_orders oo
	join olist_items oi
		on oo.order_id = oi.order_id
	join(
		select
			product_id,
			product_category_name_english
		from olist_products op
		) as op
		on oi.product_id = op.product_id
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by product_name, the_year
	order by product_rank
	
	-- Q4. What is the average order value (AOV) on Olist, and how does this vary by product category or payment method?
	
	-- extracting the uniquely identified rows


	'''AOV = total revenue / total orders
	CPO = total cost of product / total orders'''
	-- AOV & CPO & Profit per order
	select
		round(sum(oop.payment_value) / count(oo.order_id), 0) as aov,
		round(sum(oi.cost) / count(oo.order_id), 0) as cpo,
		round(sum(oop.payment_value) / count(oo.order_id) - (sum(cost) / count(oo.order_id)), 0) as profit_per_order
	from olist_orders oo
	join(
		select
			oo.order_id as order_id,
			sum(payment_value) as payment_value
		from olist_order_payments oop
		join olist_orders oo
			on oo.order_id = oop.order_id
		where
			oo.order_status <> 'canceled'
			and oo.order_delivered_customer_date is not null
		group by oo.order_id
		) as oop 
		on oo.order_id = oop.order_id -- 96,469 row($15421083)
	join(
		select
			oo.order_id as order_id,
			sum(price + freight_value) as cost
		from olist_items oi
		join olist_orders oo
			on oo.order_id = oi.order_id
		where
			oo.order_status <> 'canceled'
			and oo.order_delivered_customer_date is not null
		group by oo.order_id
		) as oi
		on oo.order_id = oi.order_id -- 96,470 rows($15418395)
	
	-- query of profit per order
	with orderpayments
	as (
    	select
        	oo.order_id,
        	sum(oop.payment_value) as total_payment_value
    	from olist_order_payments oop
    	join olist_orders oo
			on oo.order_id = oop.order_id
    	where
        	oo.order_status <> 'canceled'
        	and oo.order_delivered_customer_date is not null
    	group by oo.order_id
		),
		ordercosts as (
    	select
        	oo.order_id,
        	sum(oi.price + oi.freight_value) as total_cost
    	from olist_items oi
    	join olist_orders oo
			on oo.order_id = oi.order_id
    	where
        	oo.order_status <> 'canceled'
        	and oo.order_delivered_customer_date is not null
    	group by oo.order_id
		)
	select
   		oo.order_id,
   		round(sum(op.total_payment_value) / count(oo.order_id), 0) as aov,
		round(sum(oc.total_cost) / count(oo.order_id), 0) as cpo,
    	round((sum(op.total_payment_value) - sum(oc.total_cost)) / count(oo.order_id), 0) as profit_per_order
	from olist_orders oo
	join orderpayments op
		on oo.order_id = op.order_id
	join ordercosts oc
		on oo.order_id = oc.order_id
	group by oo.order_id
	having round((sum(op.total_payment_value) - sum(oc.total_cost)) / count(oo.order_id), 0) > 0
	order by profit_per_order desc
	
	-- AOV on product category (count distinct order_id = 233 rows)
	with orderprofits
	as (
    	select
        	oo.order_id,
        	round(sum(oop.payment_value) / count(oo.order_id), 0) as aov,
        	round(sum(oi.cost) / count(oo.order_id), 0) as cpo,
        	round((sum(oop.payment_value) - sum(oi.cost)) / count(oo.order_id), 0) as profit_per_order
    	from olist_orders oo
    	join (
        	select
            	oo.order_id,
            	sum(oop.payment_value) as payment_value
        	from olist_order_payments oop
        	join olist_orders oo
				on oo.order_id = oop.order_id
        	where
            	oo.order_status <> 'canceled'
            	and oo.order_delivered_customer_date is not null
        	group by oo.order_id
    		) as oop
			on oo.order_id = oop.order_id
    	join (
        	select
            	oo.order_id,
            	sum(oi.price + oi.freight_value) as cost
        	from olist_items oi
        	join olist_orders oo
				on oo.order_id = oi.order_id
       		where
            	oo.order_status <> 'canceled'
            	and oo.order_delivered_customer_date is not null
        	group by oo.order_id
    		) as oi on oo.order_id = oi.order_id
		group by oo.order_id
    	having round((sum(oop.payment_value) - sum(oi.cost)) / count(oo.order_id), 0) > 0),
		productprofits as (
    	select
        	op.product_category_name_english,
        	count(distinct oi.order_id) as profit_count
    	from olist_items oi
    	join olist_products op
			on oi.product_id = op.product_id
    	join orderprofits profit
			on profit.order_id = oi.order_id	
    	group by op.product_category_name_english
		)
	select
    	product_category_name_english as product_name,
    	profit_count
	from productprofits
	order by profit_count desc
	
	-- AOV by payment method
	select
		payment_type,
		round(sum(oop.payment_value) / count(distinct oo.order_id), 0) as aov
	from olist_orders oo
	join olist_order_payments oop
		on oo.order_id = oop.order_id
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by payment_type
	order by aov desc
	
	-- Q5. How many sellers are active on Olist, and how does this number change over time?
	
	-- distinct seller_id
	select
		count(distinct seller_id)
	from olist_sellers os

	-- checking order_id with multiple seller_id
	select
		order_id,
		count(order_item_id),
		count(distinct seller_id)
	from olist_items oi
	group by order_id
	having count (distinct seller_id) > 1
	
	-- active sellers
	with item_order_details
	as (
    	select
        	oi.seller_id,
        	oo.order_id,
        	oo.order_purchase_timestamp,
        	lag(oo.order_purchase_timestamp, 1) over (partition by oi.seller_id order by oo.order_purchase_timestamp) as previous_order_date
    	from olist_orders oo
    	join (
        	select
            	oi.order_id,
            	si.seller_id
        	from olist_items oi
        	join (
            	select
                	order_id
            	from olist_items
            	group by order_id
            	having count(distinct seller_id) > 1
        		) as subquery
        		on oi.order_id = subquery.order_id
        	join (
            	select
                	order_id,
                	seller_id
            	from olist_items
            	group by order_id, seller_id
        		) as si
        		on oi.order_id = si.order_id
    		) as oi
    		on oi.order_id = oo.order_id
    		where oo.order_status <> 'canceled'
        		and oo.order_delivered_customer_date is not null
		),
		active_sellers
		as (
    		select
        		seller_id,
        		max(order_purchase_timestamp) as last_order_date,
        		max(previous_order_date) as last_previous_order_date
    		from item_order_details
    		group by seller_id
    		having extract(day from (max(order_purchase_timestamp) - max(previous_order_date))) <= 30
        		and max(previous_order_date) is not null
			)
	select
		count(seller_id) as num_active_sellers
	from active_sellers
			
	-- active sellers changed over time (total count 1898)
	select
    	extract(year from order_purchase_timestamp) as the_year,
    	extract(quarter from order_purchase_timestamp) as the_quarter,
    	extract(month from order_purchase_timestamp) as the_month,
    	count(seller_id) as active_seller_order_count
	from (
    	-- active sellers changed over time
    	select
        	seller_id,
        	max(order_purchase_timestamp) as order_purchase_timestamp
    	from (
        	select
            	oi.seller_id,
            	oo.order_id,
            	oo.order_purchase_timestamp,
            	lag(oo.order_purchase_timestamp, 1) over (partition by oi.seller_id order by oo.order_purchase_timestamp) as previous_order_date
        	from olist_orders oo
        	join (
            	select
                	si.seller_id as seller_id,
                	oi.order_id,
                	count(oi.order_item_id) as order_item_count
            	from olist_items oi
            	join (
                	select
                    	order_id,
                    	count(distinct seller_id) as distinct_seller_count
                	from olist_items
                	group by order_id
                	having count(distinct seller_id) > 1
           		 	) as subquery
            		on oi.order_id = subquery.order_id
            	join (
                	select
                    	order_id,
                    	seller_id
                	from olist_items
                	group by order_id, seller_id
            		) as si
            		on oi.order_id = si.order_id
            		group by oi.order_id, si.seller_id
            		order by si.seller_id, oi.order_id
        			) as oi
        		on oi.order_id = oo.order_id
        		where oo.order_status <> 'canceled'
          			and oo.order_delivered_customer_date is not null
        		order by oi.seller_id, oo.order_purchase_timestamp desc
    			) as second_last_order_date
    		group by seller_id
    		having extract(day from (max(order_purchase_timestamp) - max(previous_order_date))) <= 30
       			and max(previous_order_date) is not null
    	-- active sellers changed over time
	) as sub
	group by the_year, the_quarter, the_month
	order by the_year, the_quarter, the_month
	
	-- Q6. What is the distribution of seller ratings on Olist, and how does this impact sales performance?
	
	-- distribution of seller ratings
	select
		review_score,
		count(*) as num_review,
		round((100.0 * count(*) / tot_re.total_re), 2) as percentage
	from olist_order_reviews oore
	cross join(
		select
			count(*) as total_re
		from olist_items oi
		) as tot_re
	group by review_score, tot_re.total_re
	order by review_score desc -- 100,000 rows
	
	-- to join the correct rows in the tables, creating views of the review table
	create or replace view review as
	select
		oo.order_id as order_id,
		round(avg(review_score), 0) as review_score
	from olist_orders oo
	join olist_order_reviews oore
		on oo.order_id = oore.order_id
	where oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by oo.order_id --96,470 rows
	
	--to join the correct rows in the tables, creating views of the payment table
	create or replace view payment as
	select
		oo.order_id as order_id,
		sum(oop.payment_value) as payment_value
	from olist_orders oo
	join olist_order_payments oop
		on oo.order_id = oop.order_id
	where oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by oo.order_id --96,469 rows
	
	-- revenue by review scores
	select
		r.review_score,
		coalesce(round(sum(p.payment_value), 0), 0) as total_payment_value,
		round(100.0 * (coalesce(round(sum(p.payment_value), 0), 0) / all_sum.all_pay), 2) as percentage
	from review r
	join payment p
		on r.order_id = p.order_id
	cross join(
		select coalesce(round(sum(p.payment_value), 0), 0) as all_pay
		from payment p
		) as all_sum
	group by r.review_score, all_pay
	order by r.review_score desc
	
	-- Q7. How many customers have made repeat purchases on Olist, and what percentage of total sales do they account for?
	
	-- distinct customers
	select
		count(distinct customer_unique_id) as customers
	from olist_customers oc
	
	-- repeated customers
	select
		count(*) as num_return_customer
	from(
		select
			oc.customer_unique_id as re_customer,
			count(distinct oo.order_id) as num_re_customers
		from olist_orders oo
		join olist_customers oc
			on oo.customer_id = oc.customer_id
		where oo.order_status <> 'canceled'
			and oo.order_delivered_customer_date is not null
		group by re_customer
		having count(oo.order_id) > 1
		order by num_re_customers desc
		) as return_customers
		
	-- revenue of repeat customers
	select
		round(sum(total_rev), 0) as revenue_re_customers
	from(
		select
			oc.customer_unique_id as re_customer,
			count(distinct oo.order_id) as num_re_customers,
			sum(oop.payment_value) as total_rev
		from olist_orders oo
		join olist_customers oc
			on oo.customer_id = oc.customer_id
		join olist_order_payments oop
			on oo.order_id = oop.order_id
		where oc.customer_unique_id
			in(
				select
					oc.customer_unique_id
				from olist_orders oo
				join olist_customers oc
					on oo.customer_id = oc.customer_id
				where oo.order_status <> 'canceled'
					and oo.order_delivered_customer_date is not null
				group by oc.customer_unique_id
				having count(oo.order_id) > 1 -- 2801 rows
				)
			and oo.order_status <> 'canceled'
			and oo.order_delivered_customer_date is not null
		group by re_customer
		having count(oo.order_id) <> 1
		order by num_re_customers
		) as sub -- 2801 rows
		
	-- percentage revenue of repeat customers
	select
		round(100.0 * return_rev / total_revenue, 2) as percentage_of_return_customer
	from(
		-- revenue of repeat customers
		select
			round(sum(total_rev), 0) as return_rev
		from(
			select
				oc.customer_unique_id as re_customer,
				count(distinct oo.order_id) as num_re_customers,
				sum(oop.payment_value) as total_rev
			from olist_orders oo
			join olist_customers oc
				on oo.customer_id = oc.customer_id
			join olist_order_payments oop
				on oo.order_id = oop.order_id
			where oc.customer_unique_id
				in(
					select
						oc.customer_unique_id
					from olist_orders oo
					join olist_customers oc
						on oo.customer_id = oc.customer_id
					where oo.order_status <> 'canceled' and oo.order_delivered_customer_date is not null
					group by oc.customer_unique_id
					having count(oo.order_id) > 1 -- 2801 rows
					)
				and oo.order_status <> 'canceled' and oo.order_delivered_customer_date is not null
			group by re_customer
			having count(oo.order_id) <> 1
			order by num_re_customers
			) as sub
			) as return_customers_revenue, -- 864,357
		-- revenue of repeat customers
			(
			select
				round(sum(oop.payment_value), 0) as total_revenue
			from olist_orders oo
			join olist_order_payments oop
				on oo.order_id = oop.order_id
			where oo.order_status <> 'canceled' and oo.order_delivered_customer_date is not null
			) as total_revenue -- 15,421,083
			
	-- Q8. What is the average customer rating for products sold on Olist, and how does this impact sales performance?
	
	-- average ratings
	select
		round(avg(oore.review_score), 1) as avg_review
	from olist_orders oo
	join olist_order_reviews oore
		on oo.order_id = oore.order_id
	where order_status <> 'canceled'
		and order_delivered_customer_date is not null
	
	-- average review by product category
	select
		product_name,
		round(avg(oore.review_score), 1) as avg_review_score,
		count(oo.order_id) as num_order,
		rank() over (order by count(oo.order_id) desc) as product_rank
	from olist_orders oo
	join(
		select
			oi.order_id as order_id,
			oi.product_id as product_id,
			op.product_category_name_english as product_name
		from olist_items oi
		join olist_orders oo
			on oo.order_id = oi.order_id
		join olist_products op
			on oi.product_id = op.product_id
		where oo.order_status <> 'canceled'
			and oo.order_delivered_customer_date is not null
		order by op.product_category_name_english desc
		) as oi
		on oi.order_id = oo.order_id -- 110,189 rows
	join(
		select
			oo.order_id as order_id,
			avg(oore.review_score) as review_score
		from olist_order_reviews oore
		join olist_orders oo
			on oo.order_id = oore.order_id
		where order_status <> 'canceled'
			and order_delivered_customer_date is not null
		group by oo.order_id
		) as oore
		on oo.order_id = oore.order_id -- 96,470 rows
	where oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by product_name
	-- order by avg_review_score desc
	order by product_rank

	-- calculating the net promoter score as a reference to see the overall customer experience
	select
		sum(case when review_score in (5, 4) then 1 else 0 end) as positive_count,
		sum(case when review_score = 1 then 1 else 0 end) as negative_count,
		count(*) as total_count,
		100.0* (sum(case when review_score in (5, 4) then 1 else 0 end) - sum(case when review_score = 1 then 1 else 0 end)) / count(*) as nps
	from olist_order_reviews oore
	
	-- Q9. What is the average order cancellation rate on Olist, and how does this impact seller performance?
	
	-- average order cancellation rate
	select
		order_status,
		count(order_id) as num_order,
		round(100 * count(order_id) / sum(count(order_id)) over(), 2) as percentage
	from olist_orders oo
	group by order_status
	
	-- Q10. What are the top-selling products on Olist, and how have their sales trends changed over time?
	-- answered in Q3
	
	-- Q11. Which payment methods are most commonly used by Olist customers, and how does this vary by product category or geographic region?
	
	-- most commonly used payment method
	select
		payment_type,
		count(*) as num_pay_type
	from olist_order_payments oop
	join olist_orders oo
		on oo.order_id = oop.order_id
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by payment_type
	order by num_pay_type desc-- 100,748 rows
	
	-- payment type by products
	select
		product_name,
		payment_type,
		count(*) as num_order,
		rank() over (order by count(*) desc) as num_order_rank
	from olist_orders oo
	join(
		select
			oi.order_id as order_id,
			oi.product_id as product_id,
			op.product_category_name_english as product_name
		from olist_items oi
		join olist_orders oo
			on oo.order_id = oi.order_id
		join olist_products op
			on oi.product_id = op.product_id
		where
			oo.order_status <> 'canceled'
			and oo.order_delivered_customer_date is not null
		order by op.product_category_name_english desc
		) as oi
		on oi.order_id = oo.order_id -- 110,189 rows
	join(
		select
			oo.order_id as order_id,
			oop.payment_type as payment_type,
			sum(oop.payment_value) as payment_value
		from olist_order_payments oop
		join olist_orders oo
			on oo.order_id = oop.order_id
		where
			oo.order_status <> 'canceled'
			and oo.order_delivered_customer_date is not null
		group by oo.order_id, oop.payment_type
		) as oop
		on oo.order_id = oop.order_id -- 98,651 rows
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by product_name, payment_type
	order by num_order desc
	-- order by product_name desc, num_order desc
	
	-- payment type by geographic region
	select
		oc.customer_city as city,
		payment_type,
		count(distinct oop.order_id) as order_num,
		rank() over (order by count(distinct oop.order_id) desc) as city_rank
	from olist_order_payments oop
	join olist_orders oo
		on oop.order_id = oo.order_id
	join olist_customers oc
		on oo.customer_id = oc.customer_id
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null
	group by payment_type, city
	order by order_num desc
	
	-- Q12. How do customer reviews and ratings affect sales and product performance on Olist?
	
	--
	select
		round(avg(review_score), 2) as avg_review,
		round(sum(profit), 0) as profit
	from(
		select
			oo.order_id,
			review_score,
			payment_value,
			cost,
			(payment_value - cost) as profit
		from olist_orders oo
		join(
			select
				oo.order_id as order_id,
				round(avg(review_score), 2) as review_score
			from olist_order_reviews oore
			join olist_orders oo
				on oo.order_id = oore.order_id
			where
				oo.order_status <> 'canceled'
				and oo.order_delivered_customer_date is not null
			group by oo.order_id
			) as oore
			on oo.order_id = oore.order_id -- 96,470 rows
		join(
			select
				oo.order_id as order_id,
				sum(payment_value) as payment_value
			from olist_order_payments oop
			join olist_orders oo
				on oo.order_id = oop.order_id
			where
				oo.order_status <> 'canceled'
				and oo.order_delivered_customer_date is not null
			group by oo.order_id
			) as oop
			on oo.order_id = oop.order_id -- 96,469 rows 15,421,083
		join(
			select
				oo.order_id as order_id,
				sum(price + freight_value) as cost
			from olist_items oi
			join olist_orders oo
				on oo.order_id = oi.order_id
			where
				oo.order_status <> 'canceled'
				and oo.order_delivered_customer_date is not null
			group by oo.order_id
			) as oi
			on oo.order_id = oi.order_id -- 96,470 rows 15,418,395
		) as profit
		
	-- Q13. Which product categories have the highest profit margins on Olist, and how can the company increase profitability across different
		-- categories?
	
	-- categories having the highest profit
	select
		oo.order_id,
		payment_value,
		cost,
		round((payment_value - cost), 0) as profit
	from
		olist_orders oo
	join(
		select
			order_id,
			sum(payment_value) as payment_value
		from olist_order_payments oop
		group by order_id
		) as oop
		on oo.order_id = oop.order_id --99,440
	join(
		select
			order_id,
			sum(price + freight_value) as cost
		from olist_items oi
		group by order_id
		) as oi
		on oo.order_id = oi.order_id -- 98,666 rows
	where
		oo.order_status <> 'canceled'
		and oo.order_delivered_customer_date is not null -- 96,469 rows
		and round((payment_value - cost), 0) > 0
	order by profit desc --233 rows
	
	-- table of olist_items
	select *
	from olist_items oi
	where oi.order_id = '6e5fe7366a2e1bfbf3257dba0af1267f'
	
	-- table of olist products
	select *
	from olist_products op
	where product_id
		in ('7721582bb750762d81850267d19881c1', '65bb78cf0bbc3ca6406f30e6793736f9')
	
	-- Q14. Geolocation has high customer density. Calculate customer retention rate according to geolocations.
	
	-- customer retention rate according to geolocations
	with return_customers
	as (
    	select
        	oc.customer_state as state,
        	count(oc.customer_unique_id) as re_customer
    	from olist_customers oc
    	where oc.customer_unique_id
			in (
        		select
					unique_id
        		from (
            		select
                		oc.customer_unique_id as unique_id,
                		count(distinct oo.order_id) as order_count
            		from olist_orders oo
            		join olist_customers oc
						on oo.customer_id = oc.customer_id
            		where
                		oo.order_status <> 'canceled'
                		and oo.order_delivered_customer_date is not null
            		group by oc.customer_unique_id
            		having count(oo.order_id) > 1
        			) as sub
    				)
    	group by oc.customer_state
		),
		total_customers as (
    	select
        	oc.customer_state as state,
        	count(oc.customer_unique_id) as tot_customer
    	from olist_customers oc
    	join olist_orders oo
			on oo.customer_id = oc.customer_id
    	where
        	oo.order_status <> 'canceled'
        	and oo.order_delivered_customer_date is not null
    	group by oc.customer_state
		)
	select
    	rc.state as state,
    	round((rc.re_customer::numeric / tc.tot_customer) * 100, 2) as crr
	from return_customers rc
	join total_customers tc
		on rc.state = tc.state
	order by crr desc