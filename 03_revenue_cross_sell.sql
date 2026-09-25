-- E-Commerce Customer Behavior Analysis
-- Q6-Q10: Revenue Growth & Cross-Sell

-- Q6. Number of categories purchased per customer
WITH customer_categories AS (
    SELECT customer_id, COUNT(DISTINCT category_name) AS category_count
    FROM orders
    GROUP BY customer_id
)
SELECT
    CASE WHEN category_count >= 5 THEN '5+' ELSE CAST(category_count AS CHAR) END
        AS categories_purchased,
    COUNT(*) AS customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS contribution_pct
FROM customer_categories
GROUP BY CASE WHEN category_count >= 5 THEN '5+' ELSE CAST(category_count AS CHAR) END;

-- Q7. Highest-value single-category customers
WITH customer_category AS (
    SELECT
        customer_id,
        COUNT(DISTINCT category_name) AS category_count,
        SUM(total_amount_usd) AS customer_value
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, customer_value
FROM customer_category
WHERE category_count = 1
ORDER BY customer_value DESC
LIMIT 20;

-- Q8. Category affinity pairs
WITH customer_categories AS (
    SELECT DISTINCT customer_id, category_name
    FROM orders
),
category_pairs AS (
    SELECT
        a.category_name AS category_1,
        b.category_name AS category_2,
        COUNT(DISTINCT a.customer_id) AS customers
    FROM customer_categories a
    JOIN customer_categories b
      ON a.customer_id = b.customer_id
     AND a.category_name < b.category_name
    GROUP BY a.category_name, b.category_name
)
SELECT category_1, category_2, customers
FROM category_pairs
ORDER BY customers DESC;

-- Q9. New vs existing customer revenue
WITH first_purchase AS (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT
    CASE WHEN o.order_date = f.first_order_date
         THEN 'New Customer' ELSE 'Existing Customer' END AS customer_type,
    COUNT(*) AS orders,
    SUM(o.total_amount_usd) AS revenue,
    ROUND(100.0 * SUM(o.total_amount_usd) /
          SUM(SUM(o.total_amount_usd)) OVER (), 2) AS revenue_share_pct
FROM orders o
JOIN first_purchase f ON o.customer_id = f.customer_id
GROUP BY CASE WHEN o.order_date = f.first_order_date
              THEN 'New Customer' ELSE 'Existing Customer' END;

-- Q10. Retain / Grow / Develop segmentation
WITH customer_metrics AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(total_amount_usd) AS revenue
    FROM orders
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN revenue >= 1000 AND order_count >= 5 THEN 'Retain'
        WHEN revenue >= 500 AND order_count >= 3 THEN 'Grow'
        ELSE 'Develop'
    END AS segment,
    COUNT(*) AS customers,
    SUM(revenue) AS revenue
FROM customer_metrics
GROUP BY CASE
    WHEN revenue >= 1000 AND order_count >= 5 THEN 'Retain'
    WHEN revenue >= 500 AND order_count >= 3 THEN 'Grow'
    ELSE 'Develop'
END
ORDER BY revenue DESC;
