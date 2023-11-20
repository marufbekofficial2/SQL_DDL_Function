CREATE FUNCTION get_sales_revenue_by_category_qtr(p_current_quarter INTEGER)
RETURNS TABLE (category VARCHAR, total_revenue DECIMAL) AS $$
BEGIN
  RETURN QUERY
  SELECT film_category.name AS category, SUM(payment.amount) AS total_revenue
  FROM film
  JOIN inventory ON film.film_id = inventory.film_id
  JOIN rental ON inventory.inventory_id = rental.inventory_id
  JOIN payment ON rental.rental_id = payment.rental_id
  WHERE EXTRACT(QUARTER FROM payment.payment_date) = p_current_quarter
  GROUP BY film_category.name;
END;
$$ LANGUAGE plpgsql;