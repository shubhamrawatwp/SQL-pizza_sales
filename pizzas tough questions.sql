/*Advanced:
Calculate the percentage contribution of each pizza type to total revenue.
Analyze the cumulative revenue generated over time.
Determine the top 3 most ordered pizza types based on revenue for each pizza category.

order_id, order_date, order_time
pizza_types.pizza_type_id, name, category, ingredients
order_details.order_details_id, order_id, pizza_id, quantity
pizzas.pizza_id, pizza_type_id, size, price

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SET sql_mode=@@global.sql_mode;*/

 SELECT pizza_types.category, (SUM( orders_details.quantity*pizzas.price ) /   ( SELECT SUM( orders_details.quantity*pizzas.price ) AS TOTAL_SALES  
 FROM pizza_types 
JOIN pizzas ON orders_details.pizza_id = pizzas.pizza_id)*100 )as REVENUE 
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id= pizzas.pizza_type_id
JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category;


SELECT orders.order_date, sum(revenue) over (order by order_date) as cum_revenue
FROM
(SELECT (orders.order_date) , round(SUM(orders_details.quantity*pizzas.price),2), 
FROM orders JOIN orders_details
ON orders.order_id= orders_details.order_id
JOIN pizzas ON pizzas.pizza_id=orders_details.pizza_id
GROUP BY orders.order_date) as sales;

SELECT name,REVENUE FROM
(SELECT category,name,REVENUE,
rank() over (partition by category order by REVENUE desc) as rn
FROM
(SELECT pizzas_types.category ,pizzas_types.name, 
SUM((orders_details.quantity)*pizzas.price) as REVENUE 
FROM pizzas_types JOIN pizzas
ON pizzas_types.pizzas_types_id= pizzas.pizzas_types_id
JOIN orders_details
ON pizzas.pizza_id=orders_details.pizza_id
GROUP BY pizzas_types.category, pizzas_types.name) AS B
WHERE rn<=3;


