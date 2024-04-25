--- Question Set 1 - Easy ---

	-- Q1: Who is the senior most employee based on job title?
	select *
	from employee
	order by levels desc
	limit 1

	-- Q2: Which countries have the most invoices?
	select
		billing_country,
		count(*)
	from invoice
	group by billing_country
	order by count desc

	-- Q3: What are the top 3 values of total invoice?
	select total
	from  invoice
	order by total desc
	limit 3

	-- Q4: Which city has best customers? We would like to throw a promotional music festival
	--	in the city we made the most money. Write the query that returns one city that has the
	--	highest sum of invoice totals. Return both the city name and the sum of all invoice totals.
	select
		billing_city,
		sum(total)as total
	from invoice
	group by billing_city
	order by total desc
	
	-- Q5: Who is the best customer? The customer who has spent the most money will be declared the best
	--	customer. Write the query that returns the person who has spent the most money.
	select
		customer.customer_id,
		customer.first_name,
		customer.last_name,
		sum(invoice.total) as invoice_total
	from customer
	join invoice
	on customer.customer_id = invoice.customer_id
	group by customer.customer_id
	order by invoice_total desc
	limit 1
	
--- Question Set 2 - Moderate ---

	-- Q1: Write query to return the email, first name, last name, and genre of all rock music
	--	listeners. Return your list ordered alphabetically by email starting with A.	
	select
		distinct email,
		first_name,
		last_name
	from customer
	join invoice
	on customer.customer_id = invoice.customer_id
	join invoice_line
	on invoice.invoice_id = invoice_line.invoice_id
	where track_id in(
					select track_id
					from track
					join genre
					on track.genre_id = genre.genre_id
					where genre.name like 'Rock'
					)
	order by email
					 
	-- Q2: Lets invite the artists who have written the most rock music in our dataset. Write 
	--	a query that returns the artist name and total track count of the top 10 rock bands.
	select
		artist.artist_id,
		artist.name,
		count(artist.artist_id) as number_of_songs
	from track
	join album
	on album.album_id = track.album_id
	join artist
	on artist.artist_id = album.artist_id
	join genre
	on genre.genre_id = track.genre_id
	where genre.name like 'Rock'
	group by artist.artist_id
	order by number_of_songs desc
	limit 10
	
	-- Q3: Return all the track names that have a song length longer than the average song length.
	--	Return the name and milliseconds for each track. Order by the song length with the longest
	--	songs listed first.
	select
		name,
		milliseconds
	from track
	where milliseconds >(
						select
							avg(milliseconds) as avg_track_length
						from track
						)
	order by milliseconds desc
	
---Question Set 3 - Advance---

	-- Q1: Find how much amount spent by each customer on artists? Write a query to return customer name,
	--	artist name and total spent.
	with best_selling_artist
	as(
		select
			artist.artist_id as artist_id,
			artist.name as artist_name,
			sum(invoice_line.unit_price*invoice_line.quantity) as total_sales
		from invoice_line
		join track
		on track.track_id = invoice_line.track_id
		join album
		on album.album_id = track.album_id
		join artist
		on artist.artist_id = album.artist_id
		group by 1
		order by 3 desc
		limit 1
		)
		select
			c.customer_id,
			c.first_name,
			c.last_name,
			bsa.artist_name,
			sum(il.unit_price * il.quantity) as amount_spent
		from invoice i
		join customer c
		on c.customer_id = i.customer_id
		join invoice_line il
		on il.invoice_id = i.invoice_id
		join track t
		on t.track_id = il.track_id
		join album alb
		on alb.album_id = t.album_id
		join best_selling_artist bsa
		on bsa.artist_id = alb.artist_id
		group by 1,2,3,4
		order by 5 desc
		
	-- Q2: We want to find out the most popular music genre for each country. We determine the most popular
	--	genre as the genre with the highest amount of purchases. Write query that returns each country along
	--	with the top genre. For countries where the maximum number of purchases is shared return all genres.

	-- Method 1
	with popular_genre
	as(
		select
			count(invoice_line.quantity)as purchases,
			customer.country,
			genre.name,
			genre.genre_id,
			row_number() over(partition by customer.country order by count(invoice_line.quantity)desc)as row_no
		from invoice_line
		join invoice
		on invoice.invoice_id = invoice_line.invoice_id
		join customer
		on customer.customer_id = invoice.customer_id
		join track
		on track.track_id = invoice_line.track_id
		join genre
		on genre.genre_id = track.genre_id
		group by 2,3,4
		order by 2 asc, 1 desc
		)
	select *
	from popular_genre
	where row_no <= 1
	
	-- Method 2
	with recursive sales_per_country
	as(
		select
			count(*) as purchases_per_genre,
			customer.country,
			genre.name,
			genre.genre_id
		from invoice_line
		join invoice
		on invoice.invoice_id = invoice_line.invoice_id
		join customer
		on customer.customer_id = invoice.customer_id
		join track
		on track.track_id = invoice_line.track_id
		join genre
		on genre.genre_id = track.genre_id
		group by 2,3,4
		order by 2
		),
		max_genre_per_country as(
								select
									max (purchases_per_genre) as max_genre_number,
									country
								from sales_per_country
								group by 2
								order by 2
								)
	select sales_per_country.*
	from sales_per_country
	join max_genre_per_country
	on sales_per_country.country = max_genre_per_country.country
	where sales_per_country.purchases_per_genre = max_genre_per_country.max_genre_number

	-- Q3: Write a query that determines the customer that has spent the most on music for each country.
	--	Write a query that returns the country along with the top customer and how much they spent. For
	--	countries where the top amount spent is shared, provide all customers who spent this amount.

	-- Method 1
	with recursive customer_with_country
	as(
		select
			customer.customer_id,
			first_name,
			last_name,
			billing_country,
			sum(total) as total_spending
		from invoice
		join customer
		on customer.customer_id = invoice.customer_id
		group by 1,2,3,4
		order by 2,3 desc
		),
		country_max_spending as(
								select
									billing_country,
									max(total_spending) as max_spending
								from customer_with_country
								group by billing_country
								)
	select
		cc.billing_country,
		cc.total_spending,
		cc.first_name,
		cc.customer_id
	from customer_with_country cc
	join country_max_spending ms
	on cc.billing_country = ms.billing_country
	where cc.total_spending = ms.max_spending
	order by 1
	
	-- Method 2
	with customer_with_country
	as(
		select
			customer.customer_id,
			first_name,
			last_name,
			billing_country,
			sum(total) as total_spending,
			row_number () over (partition by billing_country order by sum(total) desc) as row_no
		from invoice
		join customer
		on customer.customer_id = invoice.customer_id
		group by 1,2,3,4
		order by 4 asc, 5 desc
		)
	select *
	from customer_with_country
	where row_no <= 1