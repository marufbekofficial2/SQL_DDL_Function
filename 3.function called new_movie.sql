CREATE OR REPLACE FUNCTION new_movie(p_title VARCHAR)
RETURNS VOID AS $$
DECLARE
  v_new_film_id INTEGER;
  v_current_year INTEGER;
  v_language_id INTEGER;
BEGIN
  -- Generate a new unique film ID
  SELECT MAX(film_id) + 1 INTO v_new_film_id FROM film;
  
  -- Get the current year
  SELECT EXTRACT(YEAR FROM CURRENT_DATE) INTO v_current_year;
  
  -- Get the language ID for Klingon
  SELECT language_id INTO v_language_id FROM language WHERE name = 'Klingon';
  
  -- Insert the new movie into the film table
  INSERT INTO film (film_id, title, rental_rate, rental_duration, replacement_cost, release_year, language_id)
  VALUES (v_new_film_id, p_title, 4.99, 3, 19.99, v_current_year, v_language_id);
  
  -- Verify that the language exists in the language table
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Language not found.';
  END IF;
END;