CREATE VIEW sales_revenue_by_category_qtr AS
SELECT fc.category_id AS kategoriya, SUM(p.amount) AS umumiy_daromad
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
WHERE EXTRACT(QUARTER FROM p.payment_date) = EXTRACT(QUARTER FROM CURRENT_DATE)
GROUP BY fc.category_id;