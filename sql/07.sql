/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

select fin.first_name || ' ' || fin.last_name as "Actor Name" from (select actor_id from (SELECT DISTINCT mc2.actor_id, a.first_name || ' ' || a.last_name as "Actor Name" 
    from actor a 
    join film_actor mc2 on a.actor_id=mc2.actor_id
    JOIN film m2 ON mc2.film_id = m2.film_id
    WHERE m2.film_id IN (
        SELECT DISTINCT m3.film_id 
        FROM film_actor mc3 
        JOIN film m3 ON mc3.film_id = m3.film_id
        WHERE mc3.actor_id IN (
            SELECT DISTINCT mc4.actor_id 
            FROM film_actor mc4 
            JOIN film m4 ON mc4.film_id = m4.film_id
            WHERE m4.film_id IN (
                SELECT DISTINCT m5.film_id 
                FROM film_actor mc5 
                JOIN film m5 ON mc5.film_id = m5.film_id
                WHERE mc5.actor_id = 112 
            )   
        )   
    )
ORDER by "Actor Name" ) as w

EXCEPT

select actor_id from( select actor_id , first_name || ' ' || last_name as "Actor Name" 
from (select t.actor_id, actor.first_name as first_name, actor.last_name as last_name from(SELECT DISTINCT mc.actor_id
FROM film_actor mc
JOIN film m ON mc.film_id = m.film_id
JOIN film_actor mc_bacon ON m.film_id = mc_bacon.film_id
JOIN actor a ON mc_bacon.actor_id = a.actor_id
WHERE mc_bacon.actor_id = 112) as t join
actor on t.actor_id=actor.actor_id) as w
) as q) as z
join actor fin
on z.actor_id=fin.actor_id
order by "Actor Name";
