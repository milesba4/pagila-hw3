/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */

select m.title
from film m
    inner join film_actor cm on cm.film_id = m.film_id
    inner join actor a on cm.actor_id = a.actor_id
where a.actor_id in (25, 26, 105, 119, 126)
group by m.title
having count(m.film_id) > 1
order by m.title;
