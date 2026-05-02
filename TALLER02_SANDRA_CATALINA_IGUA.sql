# TALLER 2 SQL PRACTICO 

USE sakila; 

# Parte 1 – SELECT y WHERE

# 1. Mostrar nombre y apellido de todos los clientes
# Para consultar las columnas específicas de una tabla use SELECT. 

SELECT first_name,last_name FROM customer;

# 2. Películas con duración mayor a 120 minutos
# Para poder cumplir con la condición se empledo WHERE. 

SELECT * FROM film
WHERE length > 120; 

# Parte 2 – ORDER BY

#3. Ordenar clientes por apellido --> Por orden alfabetico de la A a la Z
#ORDER BY organiza los resultados y ASC los muestra de manera ascendente.

SELECT last_name FROM customer
ORDER BY last_name ASC;

# 4. Top 5 películas más largas
# DESC muestra primero los valores más altos y LIMIT restringe la cantidad de resultados.

SELECT length FROM film
ORDER BY length DESC
LIMIT 5;

# Parte 3 – INNER JOIN

# 5. Cantidad pagada y fecha del pago con nombre y apellido del cliente
# INNER JOIN relaciona las tablas customer y payment mediante customer_id.

SELECT customer.first_name, customer.last_name, payment.amount, payment.payment_date FROM customer
JOIN payment ON customer.customer_id = payment.customer_id;

#6. Películas alquiladas
# Se relacionan las tablas inventory, rental y film para mostrar las películas rentadas.

SELECT * FROM inventory
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN film ON inventory. film_id = film. film_id;

# Parte 4 – LEFT JOIN

# 7.  Nombre y apellido de clientes sin pagos 
# LEFT JOIN permite mostrar todos los clientes incluso si no tienen pagos registrados.

SELECT customer.first_name, customer.last_name FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
WHERE payment.customer_id IS NULL;

# 8. Listar los nombres de las peliculas y su duracion de aquellos titulos que no tienen actores
#Se identifican las películas sin actores asociados usando LEFT JOIN y valores NULL.

SELECT film.title, film.length FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id IS NULL;

# Parte 5 – INSERT, UPDATE, DELETE 

# 9. Insertar actor temporal
#INSERT agrega un nuevo registro a la tabla actor.

SELECT * FROM actor;
INSERT INTO actor (first_name,last_name) 
VALUES ('CATALINA','IGUA');

# 10. Actualizar actor
#UPDATE modifica información existente dentro de la tabla.


SELECT * FROM actor;
UPDATE actor  
SET last_name = 'VILLAVECES'
WHERE first_name = 'CATALINA' AND last_name = 'IGUA';

# 11. Eliminar actor
#DELETE elimina registros y COMMIT confirma los cambios realizados.

SELECT * FROM actor;
START TRANSACTION;
DELETE FROM actor
WHERE actor_id = 202;
COMMIT;

#  El actor_id de CATALINA es 202 y no 201, ya que durante la clase se realizó previamente el mismo ejercicio. Por esta razón,
# el registro con ID 201 fue eliminado, y en esta ocasión el número asignado corresponde al 202.

# 12. Top 5 clientes con mayor cantidad de dinero pagado al servicio de rentas
# SUM calcula el total pagado por cliente y GROUP BY agrupa la información.

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(payment.amount) FROM customer 
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id 
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

# 13. Top 5 Películas más alquiladas (JOIN entre Rental - Inventory - Film)
#COUNT cuenta cuántas veces fue alquilada cada película.

SELECT film.film_id, title, COUNT(rental_id) FROM rental
JOIN Inventory ON  rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.film_id, title
ORDER BY COUNT(rental_id) DESC
LIMIT 5; 




