USE sakila;

/*  Selecciona el nombre y apellido de todos los clientes que hayan alquilado una película:  */
SELECT first_name, last_name, email
FROM customer
WHERE customer_id IN (SELECT DISTINCT customer_id FROM rental);
  
/* ¿Cuál es el pago promedio realizado por cada cliente (mostrar el ID del cliente, 
el nombre del cliente concatenado y el pago promedio realizado)? */  
SELECT 
    p.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    AVG(p.amount) AS average_payment
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY p.customer_id, customer_name;

/* Selecciona el nombre y correo electrónico de todos los clientes 
que hayan alquilado películas de "Acción" (usando subquerys)   */  
SELECT 
    first_name,
    last_name,
    email
FROM customer
WHERE customer_id IN (
    SELECT DISTINCT r.customer_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category cat ON fc.category_id = cat.category_id
    WHERE cat.name = 'Action'
);

/* Selecciona el nombre y correo electrónico de todos los clientes que hayan alquilado películas de 
"Acción" (usando subconsultas y la condición IN):   */  
SELECT 
    first_name,
    last_name,
    email
FROM customer
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM rental
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM inventory
        WHERE film_id IN (
            SELECT film_id
            FROM film_category
            WHERE category_id IN (
                SELECT category_id
                FROM category
                WHERE name = 'Action'
            )
        )
    )
);

