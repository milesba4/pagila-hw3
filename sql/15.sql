/*
 * Find every documentary film that is rated PG.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */

select q.film_title as title, group_concat((((upper("substring"(q.first_name, 1, 1)) || lower("substring"(q.first_name, 2))) || upper("substring"(q.last_name, 1, 1))) || lower("substring"(q.last_name, 2)))) AS actors from (select film_title, z.actor_id, actor.first_name, actor.last_name from (SELECT
    f.title AS film_title,
    a.actor_id
FROM
    film f
JOIN
    film_category fc ON f.film_id = fc.film_id
JOIN
    category c ON fc.category_id = c.category_id AND c.name = 'Documentary'
JOIN
    film_actor fa ON f.film_id = fa.film_id
JOIN
    actor a ON fa.actor_id = a.actor_id
WHERE
    f.rating = 'G') as z
join actor on z.actor_id=actor.actor_id) as q
group by q.film_title
order by film_title;
