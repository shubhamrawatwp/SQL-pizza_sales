-- Intermediate:



-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT pizza_types.category, SUM(orders_details.quantity) AS TOTAL_QUANTITY
FROM pizza_types
JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category;


-- Determine the distribution of orders by hour of the day.
SELECT HOUR( order_time) ,COUNT(order_id) 
FROM orders
GROUP BY HOUR(order_time);


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT category as CATEGORY, COUNT(pizza_type_id) as "NO. OF PIZZAS"
FROM pizza_types
GROUP BY category;



-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT ROUND(AVG(quantity),0) FROM
(SELECT orders.order_date,SUM(orders_details.quantity) as QUANTITY
FROM orders join orders_details
ON orders.order_id=orders_details.order_id
GROUP BY orders.order_dat	e) as ORDER_QUANTITY;




-- Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name, 
SUM(orders_details.quantity * pizzas.price) AS REVENUE
FROM orders_details 
JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizza_types.pizza_type_id= pizzas.pizza_type_id
GROUP BY pizza_types.name
ORDER BY REVENUE DESC LIMIT 3;



pizza_types.pizza_type_id, name
order_details. order_details_id, order_id, pizza_id, quantity
pizzas.pizza_id, pizza_type_id, size, price





