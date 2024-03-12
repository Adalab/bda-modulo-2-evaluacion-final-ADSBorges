-- EVALUACION MODULO 2

-- #1 Selecciona todos los nombres de las películas sin que aparezcan duplicados

/* En el caso que los titulos de las pelis sean una PK con listar la columna que contiene los nombres de pelis 
seria suficiente, tambien podemos aseguramos que no aparezcan duplicados usando un Distinct */
 
SELECT title
	FROM film;

SELECT DISTINCT title
	FROM film;

-- en este caso el resultado de ambas consultas es el mismo



-- #2 Muestra los nombres de todas las películas que tengan una clasificación de "PG-13"

/* Para conseguir la columna con el nombre de las pelis(title) y 
las filas de la columna con la clasificacion(rating)  que sean igual a "PG-13" 
se puede pedir que muestre esas dos columnas con la restriccion del "PG-13" */
 
SELECT title, rating
FROM film
	WHERE rating = "PG-13";

-- Si solo se pide el nombre de las pelis no es necesario mostrar la columna de clasificacion   
 
SELECT title
FROM film
	WHERE rating = "PG-13";


-- #3 Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción

/* Se pide que muestre la columna con el nombre de las pelis(title) y las filas de la columna con la descripcion(description)
 que contengan la palabra amazing con cualquier caracter delante o detras  */

SELECT title, description
FROM film
WHERE description LIKE "%amazing%";


-- #4 Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos

-- realizo la consulta con las dos columnas para comprobar que sean mayores a 120

SELECT title, length
	FROM film
	WHERE length > 120;


-- dejo la query que responde a la consulta de mostrar solo el titulo de las pelis

SELECT title
	FROM film
	WHERE length > 120;
    
    
 #5 Recupera los nombres de todos los actores
 
 -- compruebo cuantas filas hay con nombres de actores
 
  SELECT *
	FROM actor;
 
 -- pido que muestre solo los nombres de todos los actores
 
 SELECT first_name
	FROM actor;
 
 
 #6 Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido
 
  /* pido que muestre los nombres y apellidos de los actores 
  donde las filas de apellidos tengan la palabra "Gibson" con cualquier caracter delante o detras */
  
   SELECT first_name, last_name
		FROM actor
		WHERE last_name LIKE "%Gibson%";
  
-- o solo la palabra "Gibson", segun se interprete la pregunta, en este caso devuelven el mismo resultado
  
 SELECT first_name, last_name
		FROM actor
		WHERE last_name LIKE "Gibson";
        
        
-- #7 Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

 /* pido que muestre los nombres de los actores y los actor_id
  donde las filas de id se encuentren dentro del rango indicado */
  
SELECT actor_id, first_name
	FROM actor
	WHERE actor_id BETWEEN 10 AND 20;     
 
 
 -- muestro solo los nombres de los actores que es lo que se pide
 
  SELECT first_name
	FROM actor
	WHERE actor_id BETWEEN 10 AND 20;  
    
    
    
-- #8 Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación

-- con el output de las dos columnas compruebo que se cumplen las dos restricciones y no hay "R" ni "PG-13" en el rating

SELECT title, rating 
	FROM film
    WHERE rating NOT IN ("R", "PG-13");


 -- muestro solo los nombres de las pelis que es lo que se pide 

SELECT title 
	FROM film
    WHERE rating NOT IN ("R", "PG-13");
    


-- #9 Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento

-- utilizo un GROUP BY para agrupar filas y poder realizar la operacion COUNT sobre ese grupo

SELECT rating, COUNT(*) AS Count
	FROM film
	GROUP BY rating;
    
    
-- #10 Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, 
--     su nombre y apellido junto con la cantidad de películas alquiladas

-- quiero saber cuantas filas tiene la tabla customer
SELECT *
	FROM customer;
    
 -- consigo las pelis alquiladas por cada cliente identificado con su customer_id
 
SELECT customer_id, COUNT(rental_id) AS total_rentals
	FROM rental
	GROUP BY customer_id;  
    
 /* hay que unir estos datos a los nombres y apellidos de cada cliente, 
    con un LEFT JOIN entre la tabla customer y la tabla rental utilizando el customer_id como columna de unión
    y utilizando alias para que el nombre de la columna customer_id no sea ambiguo*/
    

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
	FROM customer c
	LEFT JOIN rental r ON c.customer_id = r.customer_id
	GROUP BY c.customer_id, c.first_name, c.last_name; 
    
    
-- #11 Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

-- para conseguir los datos que se piden hay que unir las tablas category, film_category, film e inventory, y a la tabla rental
-- luego con un GROUP BY se agrupan los resultados por category_id y name de la tabla category, mostrando el nombre de la categoría junto con el recuento de alquileres 
-- para asegurarse de obtener el output que solicitan
 
SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
	FROM category c
	INNER JOIN film_category fc ON c.category_id = fc.category_id
	INNER JOIN film f ON fc.film_id = f.film_id
	INNER JOIN inventory i ON f.film_id = i.film_id
	INNER JOIN rental r ON i.inventory_id = r.inventory_id
	GROUP BY c.category_id, c.name;


-- #12 Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración

-- compruebo cuantas clasificaciones distintas hay en la tabla film

SELECT DISTINCT rating
	FROM film;

-- uso un GROUP BY junto con la función de agregación AVG() para calcular el promedio de duración de las pelis y mostrar las columnas solicitadas

SELECT rating, AVG(length) AS average_duration
	FROM film
	GROUP BY rating;
    
    
-- #13 Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love"

-- uno las tablas actor, film, y film_actor, utilizando como relacion las columnas actor_id, film_id y el título "Indian Love"

SELECT actor.first_name, actor.last_name, film.title
	FROM actor
	INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
	INNER JOIN film ON film_actor.film_id = film.film_id
		WHERE film.title = "Indian Love";
        
-- dejo solo los output que piden 

SELECT actor.first_name, actor.last_name
	FROM actor
	INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
	INNER JOIN film ON film_actor.film_id = film.film_id
		WHERE film.title = "Indian Love";
        
        
-- #14 Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción

 /* pido que muestre los titulos de las pelis que coincidan con las filas de las columna description donde esten las palabras  
  donde las filas de apellidos tengan la palabra "Gibson" con cualquier caracter delante o detras */
  
SELECT title, description
	FROM film
	WHERE description LIKE "%dog%" OR description LIKE "%cat%";
    
-- -- dejo solo los output que piden

SELECT title
	FROM film
	WHERE description LIKE "%dog%" OR description LIKE "%cat%";
    
    
-- #15 Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor

SELECT actor_id, first_name, last_name
	FROM actor
	WHERE actor_id NOT IN (SELECT DISTINCT actor_id FROM film_actor);

-- da como resultado una fila vacia, porque no hay ningun actor que no haya participado en ninguna peli


-- #16 Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010

-- uso el WHERE con el operador BETWEEN para seleccionar las pelis en la tabla film cuyo lanzamiento (release_year) esté entre 2005 y 2010, incluyendo ambos años

SELECT title, release_year
	FROM film
	WHERE release_year BETWEEN 2005 AND 2010;

-- dejo solo el output que piden

SELECT title
	FROM film
	WHERE release_year BETWEEN 2005 AND 2010;


-- #17 Encuentra el título de todas las películas que son de la misma categoría que "Family".

-- necesitamos obtener el category_id de la categoría "Family", luego encontrar todas las películas que tienen el mismo category_id en la tabla film_category, 
-- y finalmente obtener los títulos de esas películas

SELECT f.title, c.name AS category_name
	FROM film f
	INNER JOIN film_category fc ON f.film_id = fc.film_id
	INNER JOIN category c ON fc.category_id = c.category_id
		WHERE c.name = "Family";
        
-- dejo solo el output que piden

SELECT f.title
	FROM film f
	INNER JOIN film_category fc ON f.film_id = fc.film_id
	INNER JOIN category c ON fc.category_id = c.category_id
		WHERE c.name = "Family";


-- #18 Muestra el nombre y apellido de los actores que aparecen en más de 10 películas

-- Uno las tablas actor y film_actor con JOIN igualando las columnas actor_id
SELECT *
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id;

-- con un COUNT() cuento el número de filas resultantes para cada actor
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS peliculas_aparece
	FROM actor a
	INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
		GROUP BY a.actor_id;
        
-- con HAVING se aplica la condición a los resultados agrupados
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS film_participation
	FROM actor a
	INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
		GROUP BY a.actor_id
		HAVING COUNT(fa.film_id) > 10;

-- dejo solo el output que piden

SELECT a.first_name, a.last_name
	FROM actor a
	INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
		GROUP BY a.actor_id
		HAVING COUNT(fa.film_id) > 10;


-- #19 Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film

-- uso el WHERE y el AND para filtrar las filas que cumplan ambas condiciones
SELECT title, rating, length
	FROM film
	WHERE rating = 'R' AND length > 120;

-- dejo solo el output que piden

SELECT title
	FROM film
	WHERE rating = 'R' AND length > 120;
    
    
-- #20 Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre 
    -- de la categoría junto con el promedio de duración 
 
 -- se necesita unir las tablas film, film_category y category, y luego agrupar por categoría calculando el promedio de duración
 
SELECT c.name AS category_name, AVG(f.length) AS average_duration
	FROM category c
	INNER JOIN film_category fc ON c.category_id = fc.category_id
	INNER JOIN film f ON fc.film_id = f.film_id
		GROUP BY c.category_id, c.name
		HAVING AVG(f.length) > 120;
 
 
-- #21 Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor 
    -- junto con la cantidad de películas en las que han actuado    

-- con la CTE actors_films se cuenta el número de películas para cada actor y luego se filtra aquellos que han hecho
-- al menos 5 películas, luego en la consulta principal, se une la CTE para mostrar el nombre y apellido
-- del actor junto con la cantidad de películas en las que ha actuado, limitado por la condición establecida en la CTE 
       
WITH actors_films AS (
    SELECT actor_id, COUNT(film_id) AS count_films
    FROM film_actor
    GROUP BY actor_id
    HAVING COUNT(film_id) >= 5
)
SELECT actor.first_name, actor.last_name, af.count_films
	FROM actor
	INNER JOIN actors_films af ON actor.actor_id = af.actor_id;


-- #22 Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
    -- Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes
    
SELECT title
FROM film
WHERE film_id IN (
    SELECT inventory.film_id
    FROM rental
	INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
    WHERE DATEDIFF(return_date, rental_date) > 5
);


-- #23 Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
    -- Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" 
    -- y luego exclúyelos de la lista de actores
    
    
-- se busca el category_id de la categoría "Horror"

SELECT category_id
	FROM category
	WHERE name = 'Horror';

-- luego se busca todos los film_id que pertenecen a la categoría "Horror"

SELECT film_id
	FROM film_category
	WHERE category_id = (SELECT category_id 
							FROM category 
                            WHERE name = 'Horror');

-- se encuentran todos los actor_id que han actuado en películas de la categoría "Horror"

SELECT DISTINCT actor_id
	FROM film_actor
	WHERE film_id IN (SELECT film_id 
						FROM film_category 
						WHERE category_id = (SELECT category_id 
												FROM category 
                                                WHERE name = 'Horror'));

-- se selecciona los nombres y apellidos de los actores que no están en la lista de actores de la categoría "Horror"

SELECT first_name, last_name
	FROM actor
	WHERE actor_id NOT IN (
		SELECT DISTINCT actor_id
		FROM film_actor
		WHERE film_id IN (
			SELECT film_id
			FROM film_category
			WHERE category_id = (
				SELECT category_id
				FROM category
				WHERE name = 'Horror'
			)
	  )
);


-- Bonus
-- #24 Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film

/* con la subconsulta interna se obtiene el category_id de la categoría "Comedy"
 se utiliza este category_id para filtrar los film_id en la tabla film_category 
 despues se seleccionan los títulos de las películas de la tabla film que tienen una duracion mayor a 180 minutos
 y pertenecen a la categoría de comedia */

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id
        FROM category
        WHERE name = 'Comedy'
    )
)
AND length > 180;


        
    