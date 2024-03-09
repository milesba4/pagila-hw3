/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

select q.customer_id, cust.first_name, cust.last_name from (SELECT customer_id, count(*) from (SELECT
    c.customer_id,
    cat.name,
    r.rental_date
FROM
    customer c
LEFT JOIN LATERAL (
    SELECT rental_id, rental_date, inventory_id
    FROM rental
    WHERE customer_id = c.customer_id
    ORDER BY rental_date DESC
    LIMIT 5
) r ON true
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fa ON f.film_id = fa.film_id
JOIN category cat ON fa.category_id = cat.category_id
WHERE cat.name = 'Action') as t
GROUP BY customer_id
HAVING count(*) >= 4) as q
join customer as cust on cust.customer_id = q.customer_id
order by customer_id;
