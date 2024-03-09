/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */




select "Actor Name" from (select actor_id, first_name || ' ' || last_name as "Actor Name" from (select t.actor_id, actor.first_name as first_name, actor.last_name as last_name from(SELECT DISTINCT mc.actor_id
FROM film_actor mc
JOIN film m ON mc.film_id = m.film_id
JOIN film_actor mc_bacon ON m.film_id = mc_bacon.film_id
JOIN actor a ON mc_bacon.actor_id = a.actor_id
WHERE mc_bacon.actor_id = 112) as t join
actor on t.actor_id=actor.actor_id) as w) as z
where "Actor Name" != 'RUSSELL BACALL'
order BY "Actor Name";
