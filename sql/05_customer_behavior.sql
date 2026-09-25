-- E-Commerce Customer Behavior Analysis
-- Q14-Q15: Customer Behavior Analytics

-- Q14. Engagement vs order value
SELECT
    CASE
        WHEN session_duration_minutes < 5 THEN 'Low'
        WHEN session_duration_minutes < 15 THEN 'Medium'
        ELSE 'High'
    END AS engagement_level,
    COUNT(*) AS orders,
    ROUND(AVG(session_duration_minutes), 2) AS avg_session_minutes,
    ROUND(AVG(total_amount_usd), 2) AS avg_order_value,
    SUM(total_amount_usd) AS total_revenue
FROM orders
GROUP BY CASE
    WHEN session_duration_minutes < 5 THEN 'Low'
    WHEN session_duration_minutes < 15 THEN 'Medium'
    ELSE 'High'
END;

-- Q15. Payment method vs return rate
SELECT
    payment_method,
    COUNT(*) AS orders,
    ROUND(100.0 * AVG(CASE WHEN returned = 1 THEN 1 ELSE 0 END), 2)
        AS return_rate_pct
FROM orders
GROUP BY payment_method
ORDER BY return_rate_pct DESC;
