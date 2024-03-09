/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */


select title from(select f.title
from film f
join film_actor fa on f.film_id=fa.film_id
join actor a on fa.actor_id=a.actor_id
join film_actor fa2 on a.actor_id=fa2.actor_id
join film f2 on f2.film_id=fa2.film_id
where a.actor_id in
(select actor.actor_id
from actor
join film_actor on actor.actor_id=film_actor.actor_id
join film on film_actor.film_id=film.film_id
where title = 'ACADEMY DINOSAUR')


INTERSECT


select f.title
from film f
join film_actor fa on f.film_id=fa.film_id
join actor a on fa.actor_id=a.actor_id
join film_actor fa2 on a.actor_id=fa2.actor_id
join film f2 on f2.film_id=fa2.film_id
where a.actor_id in
( SELECT actor.actor_id
from actor
join film_actor on actor.actor_id=film_actor.actor_id
join film on film_actor.film_id=film.film_id
where title = 'AGENT TRUMAN')

INTERSECT

select f.title
from film f
join film_actor fa on f.film_id=fa.film_id
join actor a on fa.actor_id=a.actor_id
join film_actor fa2 on a.actor_id=fa2.actor_id
join film f2 on f2.film_id=fa2.film_id
where a.actor_id in
( select actor.actor_id
from actor
join film_actor on actor.actor_id=film_actor.actor_id
join film on film_actor.film_id=film.film_id
where title = 'AMERICAN CIRCUS')) as t
order by t.title;
