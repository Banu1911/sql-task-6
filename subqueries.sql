//Assuming the two tables:
  
Create table customers(id, name, city)
Create table orders(id, customer_id, amount)

  //Subquery in SELECT (Scalar Subquery)

SELECT name, (SELECT COUNT(*) FROM orders WHERE customer_id = customers.id) AS order_count
FROM customers;

 // Subquery in WHERE clause (IN)

SELECT name 
FROM customers 
WHERE id IN (
    SELECT customer_id 
    FROM orders 
    WHERE amount > 1000
);

 // Subquery in WHERE clause (EXISTS)

SELECT name 
FROM customers c 
WHERE EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.id AND o.amount > 500
);

 // Correlated Subquery

SELECT name 
FROM customers c 
WHERE (
    SELECT MAX(amount) 
    FROM orders o 
    WHERE o.customer_id = c.id
) > 2000;

 // Subquery in FROM (Derived Table)

SELECT customer_id, total_orders 
FROM (
    SELECT customer_id, COUNT(*) AS total_orders 
    FROM orders 
    GROUP BY customer_id
) AS order_summary 
WHERE total_orders > 5;

 // Subquery with = (Single Value)

SELECT name 
FROM customers 
WHERE id = (
    SELECT customer_id 
    FROM orders 
    ORDER BY amount DESC 
    LIMIT 1
);

