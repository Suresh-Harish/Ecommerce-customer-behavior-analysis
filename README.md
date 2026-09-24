# 🛒 E-Commerce Customer Behavior Analysis

**Role:** Business/Data Analyst | **Tool:** SQL | **Scope:** Customer retention, revenue growth, product & operational performance

A SQL-driven analysis of an e-commerce customer base covering **churn, customer lifetime value, cross-sell opportunity, and operational drivers of returns/ratings** — translated into business-ready findings and recommendations.

---

## 📌 Executive Summary

| Metric | Value |
|---|---|
| Customers analyzed | 8,000 |
| Overall churn rate | **8.94%** |
| Average CLV | **$409.29** |
| Revenue from existing customers | **69.77%** ($2.19M) |
| Revenue from new customers | **30.23%** ($0.95M) |
| Customers buying from 1 category only | **17.04%** (1,306) |

**Top-line takeaways:**
- Growth is **retention-led**, not acquisition-led — existing customers drive ~70% of revenue.
- Churn risk is concentrated in **long-inactive customers (181+ days)**: 43% churn rate vs. 8.94% average.
- **No single operational factor** (discount, delivery time, rating, returns) explains churn — the driver is likely behavioral/tenure-based, not operational.
- **Electronics** is both the biggest cross-sell lever and the biggest return-rate concern.

---

## 🎯 Analysis Themes

| Theme | Focus |
|---|---|
| 1️⃣ Customer Retention & Churn | Churn drivers, early-warning KPIs, root cause, CLV |
| 2️⃣ Revenue Growth & Cross-Sell | Category penetration, cross-sell targets, segmentation |
| 3️⃣ Product, Discount & Operations | Returns, discount impact, delivery impact |
| 4️⃣ Customer Behavior Analytics | Engagement, payment method vs. returns |

---

## 1️⃣ Customer Retention & Churn

**Q1 — Data Governance:** Three different KPI definitions exist across tables for "orders" and "revenue" (raw / delivered-only / non-cancelled). ⚠️ *A single source-of-truth metric definition is needed before reporting company-wide.*

**Q2 — Churn by Tier / Channel / Category:** Overall churn is 8.94%. Retention is weakest for customers who prefer **Books (11.38%)** and **Automotive (11.30%)**. Among tiers, **Gold has the highest churn (9.86%)**; among acquisition channels, **Referral has the highest churn (9.94%)**.

**Q3 — Early-Warning Churn KPI:** Customers inactive **181+ days churn at 43.04%** — nearly 5× the overall rate — but represent only **4.78% of revenue**. → High churn risk, limited revenue exposure. Recommend using 181+ days inactivity as an automated reactivation trigger.

**Q4 — Root Cause of Churn (Books category / Ergonomic Chair):** Tested discount %, delivery time, rating, and return rate as churn drivers — **none showed a meaningful relationship**. Root cause is not operational; recommend deeper analysis on tenure, purchase frequency, and category engagement.

**Q5 — CLV & Churn Risk:** Average CLV is $409.29. High-value customers (>$549.89) churn at **9.66%**, slightly above average, and represent **185 churned customers worth $157.5K (5.02% of total value)**. Order frequency alone does **not** consistently predict churn.

---

## 2️⃣ Revenue Growth & Cross-Sell

**Q6 — Single-Category Customers:** **17.04%** of customers (1,306) buy from only one category — a clear cross-sell target. 70% already buy across 2–4 categories.

**Q7 — Highest-Value Cross-Sell Opportunity:** The top 20 single-category customers are **100% Electronics-only buyers**, worth a combined **$25,021.60**. Prime candidates for cross-category campaigns.

**Q8 — Category Affinity:** Strongest cross-category pair is **Clothing & Apparel + Electronics** (1,342 customers), followed by **Electronics + Home & Kitchen** (1,080).

**Q9 — Growth Driver:** **69.77%** of revenue ($2.19M) comes from existing customers vs. 30.23% ($0.95M) from new customers — growth is retention-led.

**Q10 — Segmentation (Retain / Grow / Develop):**

| Segment | Customers | Revenue |
|---|---|---|
| Develop | 5,841 | $1.73M |
| Grow | 1,530 | $1.02M |
| Retain | 292 | $0.39M |

→ **Grow** is the priority segment — sizeable revenue contribution and the clearest path to graduate into Retain.

---

## 3️⃣ Product, Discount & Operational Performance

**Q11 — High-Revenue, High-Return Categories:** **Electronics** ($1.15M revenue, 8.04% returns) and **Home & Kitchen** ($434K, 8.80% returns) combine scale with meaningful return activity — top priority for return-reduction efforts.

**Q12 — Discount Impact:** Ratings are flat (1.46–1.50) across all discount bands. Medium discounts have the highest return rate (8.38%); high discounts have the lowest (7.32%) — no evidence that discounting drives returns.

**Q13 — Delivery Delay Impact:** No strong linear trend, but **highly delayed orders (9+ days)** show both the lowest rating (1.45) and highest return rate (8.20%) — extreme delays are the risk zone, not moderate ones.

---

## 4️⃣ Customer Behavior Analytics

**Q14 — Engagement vs. Order Value:** Session duration rises sharply across engagement tiers (3.5 → 9.5 → 29.6 min), but average order value barely moves ($125.00 → $126.39). Higher engagement is strongly associated with longer session duration, but shows only a weak relationship with basket size.

**Q15 — Payment Method vs. Returns:** **Cryptocurrency** has the highest return rate (9.84%, low volume); **Bank Transfer** has the lowest (6.38%). Credit Card, the highest-volume method, sits at 8.24%.

---

## ✅ Business Recommendations

1. **Standardize KPI definitions** (orders, revenue) into one governed source before company-wide reporting.
2. **Flag and target 181+ day inactive customers** with automated reactivation campaigns.
3. **Prioritize the Grow segment** (1,530 customers) for upsell/loyalty programs to migrate them into Retain.
4. **Cross-sell Electronics-only high-value customers** into Clothing & Apparel / Home & Kitchen bundles.
5. **Audit Electronics and Home & Kitchen** for return-rate root causes (sizing, quality, listing accuracy).
6. **Investigate churn drivers beyond operations** — tenure, engagement depth, and category breadth — since discount/delivery/rating/returns show no meaningful link.
7. **Set an SLA alert for 9+ day deliveries**, the clearest operational risk zone for ratings and returns.

---

## 🛠️ Methodology

- **Tool:** SQL (aggregation, joins, window functions, CTEs) over customer, order, and product tables.
- **Approach:** Metric reconciliation → churn/CLV modeling → segmentation → cross-sell analysis → operational driver testing.
- **Deliverable:** Business-analyst style findings with quantified evidence and action-oriented recommendations for each question.

---

*Full source analysis (with detailed breakdown tables) available in the accompanying Word document.*

