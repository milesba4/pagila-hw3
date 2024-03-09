/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

SELECT title from film join film_actor using(film_id) join actor using(actor_id) where actor_id in(
SELECT
    actor_id
FROM
    film
JOIN
    film_actor USING(film_id)
JOIN
    actor USING(actor_id)
WHERE
    film.title='AMERICAN CIRCUS')
ORDER BY title;
