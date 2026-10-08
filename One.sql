CREATE TABLE CUSTOMER (
	cust_id VARCHAR(5) PRIMARY KEY,
	f_name VARCHAR(50),
	l_name VARCHAR(50),
	area VARCHAR(10),
	phone_no VARCHAR(10)
);

INSERT INTO CUSTOMER (cust_id, f_name, l_name, area, phone_no)
VALUES
('CU001','Kunal','Publicitywala','Yavatmal','9878769767'),
('CU002','Aniket','Dighoriwala','Nagpur','7658769767'),
('CU003','Chetan','Pachpavli','Nagpur','8758769767'),
('CU004','Ayush','Zhumzhum','Wardha','9858769767'),
('CU005','Aditya','Khapkhap','Wardha','8948769767'),
('CU006','Atharv','Bichara','Amravati','9878769767');

SELECT * FROM CUSTOMER;

SELECT cust_id FROM customer;

CREATE TABLE CATEGORY (
category_id VARCHAR(5) PRIMARY KEY,
category_name VARCHAR(30)
);

INSERT INTO CATEGORY (category_id, category_name) VALUES
('C001', 'Electronics'),
('C002', 'Clothing'),
('C003', 'Books'),
('C004', 'Furniture'),
('C005', 'Sports'),
('C006', 'Groceries');

SELECT * FROM CATEGORY;

CREATE TABLE product (
product_id VARCHAR(5) PRIMARY KEY,
product_name VARCHAR(50),
category_id VARCHAR(5),
price DECIMAL(8,2),
stock INT,
FOREIGN KEY (category_id) REFERENCES category(category_id)
);

INSERT INTO product (product_id, product_name, category_id, price, stock) VALUES
('P001', 'Laptop', 'C001', 65000.00, 15),
('P002', 'T-Shirt', 'C002', 799.00, 50),
('P003', 'Data Structures Book', 'C003', 599.00, 30),
('P004', 'Office Chair', 'C004', 4500.00, 10),
('P005', 'Football', 'C005', 999.00, 25),
('P006', 'Rice 5kg', 'C006', 350.00, 40);

SELECT * FROM CATEGORY;

CREATE TABLE ORDERS (
order_id VARCHAR(5) PRIMARY KEY,
cust_id VARCHAR(5),
order_date DATE,
total_amount DECIMAL(10,2),
FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);

 
INSERT INTO ORDERS (order_id, cust_id, order_date, total_amount) VALUES
('O001', 'CU001', '2026-10-01', 65000.00),
('O002', 'CU002', '2026-10-02', 799.00),
('O003', 'CU003', '2026-10-03', 1198.00),
('O004', 'CU004', '2026-10-04', 4500.00),
('O005', 'CU005', '2026-10-05', 1998.00),
('O006', 'CU006', '2026-10-06', 350.00);

SELECT * FROM ORDERS;

CREATE TABLE ORDER_ITEMS (
order_item_id SERIAL PRIMARY KEY,
order_id VARCHAR(5),
product_id VARCHAR(5),
quantity INT,
price DECIMAL(8,2),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES product(product_id)
);


INSERT INTO ORDER_ITEMS (order_id, product_id, quantity, price) VALUES
('O001', 'P001', 1, 65000.00),
('O002', 'P002', 2, 799.00),
('O003', 'P003', 2, 599.00),
('O004', 'P004', 1, 4500.00),
('O005', 'P005', 2, 999.00),
('O006', 'P006', 1, 350.00);

SELECT * FROM ORDER_ITEMS;

CREATE TABLE INVOICE (
inv_no VARCHAR(5) PRIMARY KEY,
order_id VARCHAR(5),
inv_date DATE,
amount DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO INVOICE (inv_no, order_id, inv_date, amount) VALUES
('I001', 'O001', '2026-10-02', 65000.00),
('I002', 'O002', '2026-10-03', 799.00),
('I003', 'O003', '2026-10-04', 1198.00),
('I004', 'O004', '2026-10-05', 4500.00),
('I005', 'O005', '2026-10-06', 1998.00),
('I006', 'O006', '2026-10-07', 350.00);

SELECT * FROM INVOICE;

CREATE TABLE PAYMENT (
payment_id VARCHAR(5) PRIMARY KEY,
inv_no VARCHAR(5),
payment_date DATE,
payment_mode VARCHAR(20),
payment_status VARCHAR(15),
FOREIGN KEY (inv_no) REFERENCES invoice(inv_no)
);

INSERT INTO PAYMENT (payment_id, inv_no, payment_date, payment_mode, payment_status) VALUES
('PAY01', 'I001', '2026-10-02', 'UPI', 'Completed'),
('PAY02', 'I002', '2026-10-03', 'Card', 'Completed'),
('PAY03', 'I003', '2026-10-04', 'Net Banking', 'Completed'),
('PAY04', 'I004', '2026-10-05', 'Cash', 'Completed'),
('PAY05', 'I005', '2026-10-06', 'UPI', 'Pending'),
('PAY06', 'I006', '2026-10-07', 'Card', 'Completed');

SELECT * FROM PAYMENT;

--Find the first name and area of customer with cust_id = 'C03'.
SELECT f_name, area
FROM customer
WHERE cust_id = 'CU003';

--List names and phone numbers of all customers
SELECT f_name, phone_no
FROM customer;

--Count the total number of customers.
SELECT COUNT(*) AS total_customers
FROM CUSTOMER;

--Find customers whose first name starts with the letter 'C'
SELECT *
FROM CUSTOMER
WHERE f_name LIKE 'C%';

--Update the phone number of customer 'Kunal' to 567889.
UPDATE CUSTOMER
SET phone_no = '978567889'
WHERE f_name = 'Kunal';


--List all products with price greater than 150
SELECT *
FROM product
WHERE price > 150;

--Find products priced between 100 and 180
SELECT *
FROM product
WHERE price BETWEEN 700 AND 1000;

--Display product name and price of all products.
SELECT product_name, price
FROM product;

--Find the maximum and minimum product price
SELECT MAX(price) AS maximum_price,
MIN(price) AS minimum_price
FROM product;

--Increase the price of product 'Laptop' to 90000
UPDATE product
SET price = 90000
WHERE product_name = 'Laptop';

--Display all orders placed by customer 'CU002'
SELECT *
FROM orders
WHERE cust_id = 'CU002'; 

--Count total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

--Calculate total price per order using order_items table.
SELECT order_id,
SUM(quantity * price) AS total_price
FROM order_items
GROUP BY order_id;

--Find products that were never ordered.
SELECT product_id, product_name
FROM product
WHERE product_id NOT IN (
SELECT product_id
FROM order_items
);

--Find invoice details for order_id 'O003'
SELECT *
FROM invoice
WHERE order_id = 'O003';

--DELETE FROM invoice
DELETE FROM invoice
WHERE inv_no = 'I006';

--Change invoice date of inv_no 'I07' to 16-08-2023.
UPDATE invoice
SET inv_date = '2023-08-16'
WHERE inv_no = 'I007';

--Find invoices generated between two given dates.
SELECT * FROM invoice
WHERE inv_date BETWEEN '2026-10-03' AND '2026-10-06';

--Count number of successful payments.
SELECT COUNT(*) AS successful_payments
FROM PAYMENT
WHERE payment_status = 'Completed';

--Find payments made using 'UPI'
SELECT *FROM PAYMENT
WHERE payment_mode = 'UPI';

--Display customer names along with their order IDs
SELECT c.f_name, c.l_name, o.order_id
FROM customer c
JOIN orders o
ON c.cust_id = o.cust_id;

--List product names and quantities ordered by each customer
SELECT c.f_name,
p.product_name,
oi.quantity
FROM customer c
JOIN orders o
ON c.cust_id = o.cust_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN product p
ON oi.product_id = p.product_id;

--Find total amount spent by each customer.
SELECT c.cust_id,
       c.f_name,
       SUM(o.total_amount) AS total_spent
FROM customer c
JOIN orders o
ON c.cust_id = o.cust_id
GROUP BY c.cust_id, c.f_name;

--Display invoice number and customer name
SELECT i.inv_no,
       c.f_name,
       c.l_name
FROM invoice i
JOIN orders o
ON i.order_id = o.order_id
JOIN customer c
ON o.cust_id = c.cust_id;

--Find customers who have placed at least one order.
SELECT DISTINCT c.cust_id, c.f_name, c.l_name
FROM customer c
JOIN orders o
ON c.cust_id = o.cust_id;

--Find customers who have not placed any orders
SELECT *
FROM customer
WHERE cust_id NOT IN (
    SELECT cust_id
    FROM orders
);

--Display product name and category name for all products
SELECT p.product_name,
       c.category_name
FROM product p
JOIN category c
ON p.category_id = c.category_id;

--Find total sales amount for each category
SELECT c.category_name,
       SUM(oi.quantity * oi.price) AS total_sales
FROM category c
JOIN product p
ON c.category_id = p.category_id
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY c.category_name;

--Find the customer who has spent the maximum amount.
SELECT c.cust_id,
       c.f_name,
       c.l_name,
       SUM(o.total_amount) AS total_spent
FROM customer c
JOIN orders o
ON c.cust_id = o.cust_id
GROUP BY c.cust_id, c.f_name, c.l_name
ORDER BY total_spent DESC
LIMIT 1;

--





