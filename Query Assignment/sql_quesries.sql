
\! echo "--------------------------------SQL assignment 1------------------------------------------------"

\! echo "Find out the PG-13 rated comedy movies. DO NOT use the film_list table."
SELECT f.title 
	FROM film f
		JOIN film_category fc 
			ON f.film_id = fc.film_id
		JOIN category c 
			ON fc.category_id = c.category_id
	WHERE c.name = 'Comedy' AND f.rating = 'PG-13';


\! echo "Top 3 rented Horror movies."
SELECT f.title, c.name, i.film_id, COUNT(f.film_id) AS count 
	FROM film f 
		JOIN film_category fc 
			ON f.film_id = fc.film_id 
		JOIN category c 
			ON fc.category_id = c.category_id 
		JOIN inventory i 
			ON f.film_id = i.film_id 
		JOIN rental r 
			ON i.inventory_id = r. inventory_id 
	WHERE c.name = 'Horror' 
	GROUP BY i.film_id 
	ORDER BY COUNT(f.film_id) DESC 
	LIMIT 3;

\! echo "List of customers from India who have rented sports movies.";
SELECT DISTINCT cust.first_name, cust.last_name, cnty.country 
	FROM film_category fc 
		JOIN category c 
			ON fc.category_id = c.category_id 
		JOIN inventory i 
			ON fc.film_id = i.film_id 
		JOIN rental r 
			ON i.inventory_id = r. inventory_id 
		JOIN customer cust
			ON r.customer_id = cust.customer_id
		JOIN address a
			ON cust.address_id = a.address_id
		JOIN city 
			ON a.city_id = city.city_id
		JOIN country cnty
			ON city.country_id = cnty.country_id
	WHERE cnty.country = 'India' AND c.name = 'Sports';

\! echo "List of customers from Canada who have rented NICK WAHLBERG movies.";
SELECT DISTINCT cust.first_name, cust.last_name, cnty.country 
	FROM film f 
		JOIN film_actor fa 
			ON f.film_id = fa.film_id
		JOIN actor a
			ON  fa.actor_id = a.actor_id
		JOIN inventory i 
			ON f.film_id = i.film_id 
		JOIN rental r 
			ON i.inventory_id = r. inventory_id 
		JOIN customer cust
			ON r.customer_id = cust.customer_id
		JOIN address ad
			ON cust.address_id = ad.address_id
		JOIN city 
			ON ad.city_id = city.city_id
		JOIN country cnty
			ON city.country_id = cnty.country_id
	WHERE cnty.country = 'Canada' AND a.first_name = 'NICK' AND a.last_name = 'WAHLBERG';

\! echo "Number of movies in which SEAN WILLIAMS acted."
SELECT CONCAT(a.first_name," ",a.last_name) AS actor, COUNT(fa.actor_id) AS num_of_movies
	FROM film f 
		JOIN film_actor fa 
			ON f.film_id = fa.film_id
		JOIN actor a
			ON  fa.actor_id = a.actor_id
	WHERE a.first_name = 'SEAN' AND a.last_name = 'WILLIAMS';


\! echo "--------------------------------SQL assignment 2-------------------------------------------------"

\! echo "Number of documentaries with deleted scenes."
SELECT COUNT(c.name) AS num
	FROM film f 
		JOIN film_category fc 
			ON f.film_id = fc.film_id 
		JOIN category c 
			ON fc.category_id = c.category_id 
	WHERE c.name = 'Documentary' AND f.special_features = 'Deleted Scenes';

\! echo "Number of sci-fi movies rented by the store managed by Jon Stephens."
SELECT COUNT(fc.film_id) AS num
	FROM film_category fc 
		JOIN category c 
			ON fc.category_id = c.category_id 
		JOIN inventory i 
			ON fc.film_id = i.film_id 
		JOIN rental r 
			ON i.inventory_id = r. inventory_id 
	    JOIN staff s
			ON r.staff_id = s.staff_id
    WHERE c.name = "Sci-Fi" AND s.first_name = "Jon" AND s.last_name = "Stephens";

\! echo "Total sales from Animation movies."
SELECT sum(p.amount) AS sales
	FROM film f 
		JOIN film_category fc 
			ON f.film_id = fc.film_id 
		JOIN category c 
			ON fc.category_id = c.category_id 
		JOIN inventory i 
			ON f.film_id = i.film_id 
		JOIN rental r 
			ON i.inventory_id = r.inventory_id 
		JOIN payment p
			ON r.rental_id = p.rental_id
	WHERE c.name = 'Animation';

\! echo "Top 3 rented category of movies  by PATRICIA JOHNSON."
SELECT c.name AS category, COUNT(c.name) AS count 
 	FROM film f 
		JOIN film_category fc 
			ON f.film_id = fc.film_id 
		JOIN category c 
			ON fc.category_id = c.category_id 
		JOIN inventory i 
			ON fc.film_id = i.film_id 
		JOIN rental r 
			ON i.inventory_id = r.inventory_id 
		JOIN customer cust
			ON r.customer_id = cust.customer_id
	WHERE cust.first_name = 'PATRICIA' AND cust.last_name = 'JOHNSON'
	GROUP BY c.name
	ORDER BY COUNT(c.name) DESC
	LIMIT 3;

\! echo "Number of R rated movies rented by SUSAN WILSON."
SELECT COUNT(f.rating) AS count
 	FROM film f 
		JOIN inventory i 
			ON f.film_id = i.film_id 
		JOIN rental r 
			ON i.inventory_id = r.inventory_id 
		JOIN customer cust
			ON r.customer_id = cust.customer_id
	WHERE f.rating = 'R' AND cust.first_name = 'SUSAN' AND cust.last_name = 'WILSON';
