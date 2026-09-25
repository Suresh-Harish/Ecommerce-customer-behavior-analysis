-- E-Commerce Customer Behavior Analysis
-- Q11-Q13: Product, Discount & Operational Performance

-- Q11. Revenue and return rate by category
SELECT
    category_name,
    SUM(total_amount_usd) AS revenue,
    COUNT(*) AS orders,
    ROUND(100.0 * SUM(CASE WHEN returned = 1 THEN 1 ELSE 0 END) / COUNT(*), 2)
        AS return_rate_pct
FROM orders
GROUP BY category_name
ORDER BY revenue DESC;

-- Q12. Discount bands vs ratings and returns
SELECT
    CASE
        WHEN discount_pct = 0 THEN 'No Discount'
        WHEN discount_pct < 10 THEN 'Low Discount'
        WHEN discount_pct < 30 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_band,
    COUNT(*) AS orders,
    ROUND(AVG(customer_rating), 2) AS avg_rating,
    ROUND(100.0 * AVG(CASE WHEN returned = 1 THEN 1 ELSE 0 END), 2)
        AS return_rate_pct
FROM orders
GROUP BY CASE
    WHEN discount_pct = 0 THEN 'No Discount'
    WHEN discount_pct < 10 THEN 'Low Discount'
    WHEN discount_pct < 30 THEN 'Medium Discount'
    ELSE 'High Discount'
END;

-- Q13. Delivery-time bands vs ratings and returns
SELECT
    CASE
        WHEN delivery_days <= 2 THEN 'Fast (0-2 Days)'
        WHEN delivery_days <= 5 THEN 'Normal (3-5 Days)'
        WHEN delivery_days <= 8 THEN 'Delayed (6-8 Days)'
        ELSE 'Highly Delayed (9+ Days)'
    END AS delivery_band,
    COUNT(*) AS orders,
    ROUND(AVG(customer_rating), 2) AS avg_rating,
    ROUND(100.0 * AVG(CASE WHEN returned = 1 THEN 1 ELSE 0 END), 2)
        AS return_rate_pct
FROM orders
GROUP BY CASE
    WHEN delivery_days <= 2 THEN 'Fast (0-2 Days)'
    WHEN delivery_days <= 5 THEN 'Normal (3-5 Days)'
    WHEN delivery_days <= 8 THEN 'Delayed (6-8 Days)'
    ELSE 'Highly Delayed (9+ Days)'
END;
