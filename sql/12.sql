/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

select distinct c.customer_id, c.first_name, c.last_name --, r.name, rental_date -- inventory.film_id --, r.rental_date, r.inventory_id
from customer c
left join lateral (
    select rental_id, rental_date, inventory_id, name
    from rental
    join inventory using (inventory_id)
    join film_category using (film_id)
    join category cg using (category_id)
    where customer_id = c.customer_id
    order by rental_date desc

) r on true
where r.name = 'Action'
group by c.customer_id --, c.first_name, c.last_name
having count(c.customer_id) >= 4
