-- E-Commerce Customer Behavior Analysis
-- Q2-Q5: Customer Retention & Churn

-- Q2. Overall churn rate
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) / COUNT(*), 2)
        AS churn_rate_pct
FROM customers;

-- Q2. Churn by membership tier
SELECT
    membership_tier,
    COUNT(*) AS customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) / COUNT(*), 2)
        AS churn_rate_pct
FROM customers
GROUP BY membership_tier
ORDER BY churn_rate_pct DESC;

-- Q2. Churn by acquisition channel
SELECT
    acquisition_channel,
    COUNT(*) AS customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) / COUNT(*), 2)
        AS churn_rate_pct
FROM customers
GROUP BY acquisition_channel
ORDER BY churn_rate_pct DESC;

-- Q2. Churn by preferred category
SELECT
    preferred_category,
    COUNT(*) AS customers,
    SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) / COUNT(*), 2)
        AS churn_rate_pct
FROM customers
GROUP BY preferred_category
ORDER BY churn_rate_pct DESC;

-- Q3. Early-warning churn by inactivity
WITH customer_activity AS (
    SELECT
        c.customer_id,
        c.churned,
        c.customer_lifetime_value,
        DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS days_since_last_purchase
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.churned, c.customer_lifetime_value
),
bucketed AS (
    SELECT *,
        CASE
            WHEN days_since_last_purchase <= 30 THEN '0-30 Days'
            WHEN days_since_last_purchase <= 60 THEN '31-60 Days'
            WHEN days_since_last_purchase <= 90 THEN '61-90 Days'
            WHEN days_since_last_purchase <= 180 THEN '91-180 Days'
            ELSE '181+ Days'
        END AS inactivity_band
    FROM customer_activity
)
SELECT
    inactivity_band,
    COUNT(*) AS customers,
    ROUND(100.0 * SUM(CASE WHEN churned = 1 THEN 1 ELSE 0 END) / COUNT(*), 2)
        AS churn_rate_pct,
    ROUND(100.0 * SUM(customer_lifetime_value) / SUM(SUM(customer_lifetime_value)) OVER (), 2)
        AS revenue_contribution_pct
FROM bucketed
GROUP BY inactivity_band;

-- Q4. Operational factors vs churn: Books
SELECT
    AVG(discount_pct) AS avg_discount_pct,
    AVG(delivery_days) AS avg_delivery_days,
    AVG(customer_rating) AS avg_rating,
    100.0 * AVG(CASE WHEN returned = 1 THEN 1 ELSE 0 END) AS return_rate_pct,
    100.0 * AVG(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churn_rate_pct
FROM orders
WHERE category_name = 'Books';

-- Q4. Flagged product: Ergonomic Chair
SELECT
    product_name,
    COUNT(*) AS orders,
    100.0 * AVG(CASE WHEN churned = 1 THEN 1 ELSE 0 END) AS churn_rate_pct,
    100.0 * AVG(CASE WHEN returned = 1 THEN 1 ELSE 0 END) AS return_rate_pct,
    AVG(delivery_days) AS avg_delivery_days,
    AVG(customer_rating) AS avg_rating
FROM orders
WHERE product_name = 'Ergonomic Chair'
GROUP BY product_name;

-- Q5. Average, median and high-value CLV threshold
SELECT
    AVG(customer_lifetime_value) AS avg_clv,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY customer_lifetime_value) AS median_clv,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY customer_lifetime_value) AS high_value_threshold
FROM customers;

-- Q5. High-value customer churn
WITH clv_threshold AS (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP
        (ORDER BY customer_lifetime_value) AS threshold
    FROM customers
)
SELECT
    COUNT(*) AS high_value_customers,
    SUM(CASE WHEN c.churned = 1 THEN 1 ELSE 0 END) AS churned_high_value_customers,
    ROUND(100.0 * SUM(CASE WHEN c.churned = 1 THEN 1 ELSE 0 END) / COUNT(*), 2)
        AS high_value_churn_rate,
    SUM(CASE WHEN c.churned = 1 THEN c.customer_lifetime_value ELSE 0 END)
        AS churned_high_value_value
FROM customers c
CROSS JOIN clv_threshold t
WHERE c.customer_lifetime_value > t.threshold;
