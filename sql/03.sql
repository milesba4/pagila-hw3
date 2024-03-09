/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */


SELECT country,SUM(payment.amount) as total_payments
from country
inner join city on city.country_id=country.country_id
inner join address on address.city_id=city.city_id
inner join customer on customer.address_id=address.address_id
inner join payment on payment.customer_id=customer.customer_id
group by country
order by total_payments DESC, country;
