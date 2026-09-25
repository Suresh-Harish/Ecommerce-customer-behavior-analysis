-- E-Commerce Customer Behavior Analysis
-- Q1: Data Validation & KPI Reconciliation
-- Business Analyst Portfolio Project

-- Purpose:
-- Reconcile order/revenue definitions before using KPIs in reporting.
-- Update table/column names if your source schema differs.

-- 1. Raw order count
SELECT COUNT(*) AS total_orders
FROM orders;

-- 2. Delivered-order revenue
SELECT
    COUNT(*) AS delivered_orders,
    SUM(total_amount_usd) AS delivered_revenue
FROM orders
WHERE order_status = 'Delivered';

-- 3. Non-cancelled order count and revenue
SELECT
    COUNT(*) AS non_cancelled_orders,
    SUM(total_amount_usd) AS non_cancelled_revenue
FROM orders
WHERE order_status <> 'Cancelled';

-- 4. Compare status distribution
SELECT
    order_status,
    COUNT(*) AS orders,
    SUM(total_amount_usd) AS revenue
FROM orders
GROUP BY order_status
ORDER BY orders DESC;

-- Business note:
-- Standardize one governed KPI definition for each metric
-- and document it in a data dictionary.
