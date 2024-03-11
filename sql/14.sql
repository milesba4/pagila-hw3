/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

select r.name, r.title, r.count as "total rentals"
from category categ
join lateral (
    select count(rental_id) as count, title, name
    from rental
    join inventory using (inventory_id)
    join film using (film_id)
    join film_category using (film_id)
    join category cg using (category_id)
    where category_id = categ.category_id
    group by title, name
    order by count(rental_id) desc, title desc
    limit 5

) r on true
order by name, count desc, title;
