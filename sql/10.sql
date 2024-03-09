/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 *
 * Write a query that computes the total amount that each customer has spent.
 * Include a "percentile" column that contains the customer's percentile spending,
 * and include only customers in at least the 90th percentile.
 * Order the results alphabetically.
 *
 * HINT:
 * I used the `ntile` window function to compute the percentile.
 */


SELECT customer_id, name, total_payment, percentile from (select t.customer_id, first_name || ' ' || last_name AS name, total_payment,
ntile(100) over(order by total_payment asc) AS percentile
from (SELECT p.customer_id, SUM(amount) as total_payment
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY p.customer_id) as t
join customer c2 on t.customer_id=c2.customer_id) as z
where percentile >= 90
order by name;
