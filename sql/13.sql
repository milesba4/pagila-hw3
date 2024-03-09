/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */


select actor_id, first_name, last_name, film_id, title, rank, revenue from (SELECT
        a.actor_id,
        a.first_name,
        a.last_name,
        f.film_id,
        f.title AS title,
        SUM(p.amount) AS revenue,
        ROW_NUMBER() OVER (PARTITION BY a.actor_id ORDER BY SUM(p.amount) DESC) AS "rank"
    FROM
        actor a
    JOIN
        film_actor fa ON a.actor_id = fa.actor_id
    JOIN
        film f ON fa.film_id = f.film_id
    JOIN
        inventory i ON f.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    JOIN
        payment p ON r.rental_id = p.rental_id
    GROUP BY
        a.actor_id, f.film_id, f.title) as w  where rank <= 3
order by actor_id;
