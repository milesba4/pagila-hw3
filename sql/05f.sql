/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

select title from (
        select title from (select title, count(*) as num from (SELECT f2.title, category.name
FROM film f
JOIN film_category fact1 ON (f.film_id = fact1.film_id)
join category on (fact1.category_id=category.category_id)
join film_category fact2 on (category.category_id=fact2.category_id)
JOIN film f2 ON (f2.film_id = fact2.film_id)
where f.title = 'AMERICAN CIRCUS') as t group by title) as w
where num >= 2

intersect

select title from (select title, count(*) as num from (SELECT f2.title, actor.actor_id
FROM film f
JOIN film_actor fact1 ON (f.film_id = fact1.film_id)
join actor on (fact1.actor_id=actor.actor_id)
join film_actor fact2 on (actor.actor_id=fact2.actor_id)
JOIN film f2 ON (f2.film_id = fact2.film_id)
where f.title = 'AMERICAN CIRCUS') as t group by title) as w
where num >= 1
order by title
) as t
order by title;
