-- 1. Ada berapa banyak pelanggan/customers pada dataset?
SELECT COUNT(customer_id)
FROM customers;

-- 2. Ada berapa banyak order/pesanan yang dibuat oleh pelanggan?
SELECT COUNT(order_id)
FROM orders;

-- 3. Top 5 kota mana saja yang memiliki jumlah pelanggan terbanyak?
SELECT city, COUNT(customer_id) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC
LIMIT 5;

-- 4. Top 5 produk terjual terbanyak?
SELECT products.product_id, products.product_name, SUM(orders.quantity) AS total_order
FROM products
INNER JOIN orders
ON products.product_id = orders.product_id
GROUP BY product_id, product_name
LIMIT 5;


-- 5. Total revenue/pendapatan yang dihasilkan?
SELECT SUM(products.price * orders.quantity) AS final_price
FROM products
INNER JOIN orders
ON products.product_id = orders.product_id;

-- 6. Kategori produk mana yang menghasilkan pendapatan terbanyak?
SELECT products.category, SUM(products.price * orders.quantity) AS total_revenue
FROM products
INNER JOIN orders
ON products.product_id = orders.product_id
GROUP BY category
ORDER BY total_revenue DESC;

-- 7. Rata-rata jumlah order?
SELECT ROUND(AVG(quantity)) AS avg_order_quantity
FROM orders;

-- 8. Kota yang menghasilkan pendapatan terbanyak?
SELECT customers.city, SUM(products.price * orders.quantity) AS total_revenue
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN products
ON products.product_id = orders.product_id
GROUP BY city
ORDER BY total_revenue DESC;

-- 9. Top 10 pelanggan dengan kontribusi pengeluaran terbanyak?
SELECT customers.customer_id, SUM(products.price * orders.quantity) AS total_spent
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN products
ON products.product_id = orders.product_id
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- 10. Bulan dengan penjualan tertinggi?
SELECT MONTHNAME(orders.order_date) AS month, SUM(orders.quantity * products.price) AS sales
FROM orders
INNER JOIN products
ON orders.product_id = products.product_id
GROUP BY month
ORDER BY sales DESC;


-- 11. Rata-rata pengeluaran tiap pelanggan?
SELECT AVG(table5.final_price) AS avg_spent
FROM(
	SELECT customers.customer_id, SUM(products.price * orders.quantity) AS final_price
	FROM customers
	INNER JOIN orders
	ON customers.customer_id = orders.customer_id
	INNER JOIN products
	ON products.product_id = orders.product_id
    GROUP BY customer_id
) AS table5;

-- 12. Metode pembayaran yang paling umum digunakan?
SELECT payment_method, COUNT(payment_method) AS total_usage
FROM orders
GROUP BY payment_method
ORDER BY total_usage DESC;

-- 13. Kategori produk yang unitnya paling banyak terjual?
SELECT products.category, SUM(orders.quantity) AS total_unit_sold
FROM products
INNER JOIN orders
ON products.product_id = orders.product_id
GROUP BY category
ORDER BY total_unit_sold DESC;

SELECT *
FROM orders;