/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMP,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */


SELECT title from (select title, count(*) as num from (SELECT f2.title,actor.first_name, actor.last_name
FROM film f
JOIN film_actor fact1 ON (f.film_id = fact1.film_id)
join actor on (fact1.actor_id=actor.actor_id)
join film_actor fact2 on (actor.actor_id=fact2.actor_id)
JOIN film f2 ON (f2.film_id = fact2.film_id)
WHERE f.title in ('AMERICAN CIRCUS', 'AGENT TRUMAN', 'ACADEMY DINOSAUR')) as t group by title ) as w
where num >2
order by title;
