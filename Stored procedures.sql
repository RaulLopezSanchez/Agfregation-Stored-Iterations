USE sakila;
/*Create a stored procedure to find customers who rented movies of a specific category:    */  
DELIMITER //

CREATE PROCEDURE GetCustomersByCategory(IN categoryName VARCHAR(255))
BEGIN
  SELECT
    first_name,
    last_name,
    email
  FROM customer
  JOIN rental ON customer.customer_id = rental.customer_id
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film ON film.film_id = inventory.film_id
  JOIN film_category ON film_category.film_id = film.film_id
  JOIN category ON category.category_id = film_category.category_id
  WHERE category.name = categoryName
  GROUP BY first_name, last_name, email;
END //

DELIMITER ;

/* Create a stored procedure to find movie categories with movies released greater than a certain number:   */  
DELIMITER //

CREATE PROCEDURE GetCategoriesWithMovieCount(IN minMovieCount INT)
BEGIN
  SELECT
    category.name,
    COUNT(film_category.film_id) AS movie_count
  FROM category
  JOIN film_category ON category.category_id = film_category.category_id
  GROUP BY category.name
  HAVING movie_count > minMovieCount;
END //

DELIMITER ;

/* Call the first stored procedure to get customers who rented "Action" movies:*/  
CALL GetCustomersByCategory('Action');

/*Call the second stored procedure to get movie categories with movies released greater than a certain number (e.g., 10):  */  
CALL GetCategoriesWithMovieCount(10);

/*    */  
/*    */  
/*    */  
/*    */  
/*    */  
