/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

select name, film_title as title, total_rentals as "total rentals" from (
select name, film_id, film_title, total_rentals, rwn from (select
        name,
        film_id,
        film_title,
        total_rentals,
        row_number() over (partition by q.name) as rwn from
        (
select
        c.name,
        f.film_id,
        f.title as film_title,
        count(r.rental_id) AS total_rentals,
        row_number() over (partition by c.category_id order by count(r.rental_id) desc) as rn
    from
        category c
    join
        film_category fc ON c.category_id = fc.category_id
    join
        film f ON fc.film_id = f.film_id
    join
        inventory i ON f.film_id = i.film_id
    join
        rental r ON i.inventory_id = r.inventory_id
    group by
        c.category_id, f.film_id, f.title
    order by name, total_rentals desc, film_id desc) as q) as z) as fin
where rwn <= 5
order by name, "total rentals" desc, title;
