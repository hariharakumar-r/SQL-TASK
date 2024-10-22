USE ecommerce;
CREATE TABLE customers (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    address VARCHAR(200)
);
CREATE TABLE orders (
	id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
SHOW TABLES;
CREATE TABLE products (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	price DECIMAL(10,2) NOT NULL,
    description TEXT
);
INSERT INTO customers (name, email, address)
VALUES 
('Jane Smith', 'jane.smith@example.com', '456 Oak St, Springfield'),
('Alice Johnson', 'alice.johnson@example.com', '789 Pine St, Springfield'),
('Bob Brown', 'bob.brown@example.com',  '321 Maple Ave, Springfield'),
('Kamal Haasan', 'kamal.haasan@example.com', '56 Oakers St, Springfield'),
('Rajinikanth S', 'rajini@example.com', '46 Oak St, Brookfield')
;
SELECT * FROM customers;
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES 
(1, '2024-10-01', 150.75),
(2, '2024-10-05', 89.50), 
(3, '2024-10-07', 45.30),
(1, '2024-10-10', 200.00),
(4, '2024-10-10', 123.00),
(5, '2024-12-10', 155.00)
;
INSERT INTO products (name,price,description)
VALUES
('Batman shirt',150.75,'Batman dress to show off at halloween and on comicon'),
('Shakthimaan shirt',89.50,'Shakthimaan dress to show off at halloween and on comicon'),
('Spiderman shirt',45.30,'Spiderman dress to show off at halloween and on comicon'),
('He-man shirt',200.00,'He-man dress to show off at halloween and on comicon')
;
SELECT * FROM products;
--
-- To Retrieve all customers who have placed an order in the last 30 days.
SELECT DISTINCT customers.*
FROM customers
JOIN orders ON customers.id = orders.customer_id
WHERE orders.order_date >= CURDATE() - INTERVAL 30 DAY;

-- To Get the total amount of all orders placed by each customer
SELECT customers.id, customers.name ,SUM(orders.total_amount) AS total_spent
 FROM customers
 JOIN orders ON customers.id = orders.customer_id
 GROUP BY customers.id, customers.name;
 
 -- To Update the price of Product C to 45.00
 UPDATE products 
 SET price = 45.00
WHERE id = 3;

-- To Add a new column discount to the products table
ALTER TABLE products
ADD COLUMN discount DECIMAL(5,2) DEFAULT 0.00;

-- To Retrieve the top 3 products with the highest price
SELECT name,price 
FROM products 
ORDER BY price DESC
LIMIT 3;

-- To get the names of the customers who have ordered Product A (PRODUCT A is "Batman shirt") 
SELECT DISTINCT customers.name
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN order_items ON orders.id
WHERE products.name = 'Batman shirt';

-- Join the orders and customers tables to retrieve the customer's name and order date for each order. 
SELECT customers.name, orders.oreder_date
FROM customers
JOIN orders ON customers.id = orders.customer_id;

-- Retrieve the orders with a total amount greater than 150.00.
SELECT * FROM orders
WHERE total_amount > 150.00;

-- Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table.
CREATE TABLE order_items (
id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
price DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES orders(id),
FOREIGN KEY (product_id) REFERENCES products(id)
);

-- To display the new table
SELECT * FROM order_items;

-- Retrieve the average total of all orders.
SELECT ROUND(AVG(total_amount),1) AS average_order_total
FROM orders;

