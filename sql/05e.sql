/* 
 * You've decided that you don't actually like ACADEMY DINOSAUR and AGENT TRUMAN,
 * and want to focus on more movies that are similar to AMERICAN CIRCUS.
 * This time, however, you don't want to focus only on movies with similar actors.
 * You want to consider instead movies that have similar categories.
 *
 * Write a SQL query that lists all of the movies that share 2 categories with AMERICAN CIRCUS.
 * Order the results alphabetically.
 *
 * NOTE:
 * Recall that the following query lists the categories for the movie AMERICAN CIRCUS:
 * ```
 * SELECT name
 * FROM category
 * JOIN film_category USING (category_id)
 * JOIN film USING (film_id)
 * WHERE title = 'AMERICAN CIRCUS';
 * ```
 * This problem should be solved by a self join on the "film_category" table.
 */

select title from (select title, count(*) as num from (SELECT f2.title, category.name
FROM film f
JOIN film_category fact1 ON (f.film_id = fact1.film_id)
join category on (fact1.category_id=category.category_id)
join film_category fact2 on (category.category_id=fact2.category_id)
JOIN film f2 ON (f2.film_id = fact2.film_id)
where f.title = 'AMERICAN CIRCUS') as t group by title) as w
where num >= 2
order by title;
