-- Revenue and Profit Analysis

-- a. Total Revenue and Profit Margins for Each Product Category and Sub-Category
SELECT
    pc.category_name,
    SUM(pr.revenue) AS total_revenue,
    AVG(pr.profit_margin) AS avg_profit_margin
FROM
    ProductCategories pc
JOIN Products p ON p.hierarchy1_id = pc.category_id
JOIN ProductRevenue pr ON pr.product_id = p.product_id
GROUP BY
    pc.category_name;

-- b. Revenue and Profit Evolution Over the Past Year
SELECT
    DATE_FORMAT(pr.date, '%Y-%m') AS month,
    SUM(pr.revenue) AS total_revenue,
    AVG(pr.profit_margin) AS avg_profit_margin
FROM
    ProductRevenue pr
WHERE
    pr.date BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE()
GROUP BY
    month
ORDER BY
    month;

-- c. Product Categories Contributing the Most to Overall Revenue and Profit
SELECT
    pc.category_name,
    SUM(pr.revenue) AS total_revenue,
    SUM(pr.revenue * pr.profit_margin / 100) AS total_profit
FROM
    ProductCategories pc
JOIN Products p ON p.hierarchy1_id = pc.category_id
JOIN ProductRevenue pr ON pr.product_id = p.product_id
GROUP BY
    pc.category_name
ORDER BY
    total_revenue DESC;

-- d. Average Profit Margin Across Different Product Categories
SELECT
    pc.category_name,
    AVG(pr.profit_margin) AS avg_profit_margin
FROM
    ProductCategories pc
JOIN Products p ON p.hierarchy1_id = pc.category_id
JOIN ProductRevenue pr ON pr.product_id = p.product_id
GROUP BY
    pc.category_name;

-- Customer Segmentation

-- a. Segment Customers Based on Purchasing Behavior
SELECT
    CASE
        WHEN total_spent >= 1000 THEN 'High Spenders'
        WHEN total_spent BETWEEN 500 AND 999 THEN 'Mid Spenders'
        ELSE 'Low Spenders'
    END AS customer_segment,
    COUNT(DISTINCT customer_id) AS number_of_customers
FROM
    CustomerActivity
GROUP BY
    customer_segment;

-- b. Characteristics of High-Value vs Low-Value Customers
SELECT
    CASE
        WHEN total_spent >= 1000 THEN 'High-Value Customers'
        ELSE 'Low-Value Customers'
    END AS customer_value,
    AVG(total_orders) AS avg_orders,
    AVG(total_spent) AS avg_spent
FROM
    CustomerActivity
GROUP BY
    customer_value;

-- c. Variation in Average Order Value and Purchase Frequency
SELECT
    CASE
        WHEN total_spent >= 1000 THEN 'High Spenders'
        ELSE 'Low Spenders'
    END AS customer_segment,
    AVG(total_amount) AS avg_order_value,
    COUNT(DISTINCT purchase_date) AS purchase_frequency
FROM
    CustomerPurchases cp
JOIN CustomerActivity ca ON cp.customer_id = ca.customer_id
GROUP BY
    customer_segment;

-- Store Performance Analysis

-- a. Performance of Different Stores or Store Locations
SELECT
    s.store_id,
    s.store_size,
    SUM(ss.total_sales) AS total_sales,
    SUM(ss.total_revenue) AS total_revenue,
    SUM(ss.total_profit) AS total_profit
FROM
    Stores s
JOIN StoreSales ss ON s.store_id = ss.store_id
GROUP BY
    s.store_id, s.store_size;

-- b. Geographical Patterns in Sales Performance
SELECT
    sl.latitude,
    sl.longitude,
    SUM(ss.total_sales) AS total_sales
FROM
    StoreLocations sl
JOIN StoreSales ss ON sl.store_id = ss.store_id
GROUP BY
    sl.latitude, sl.longitude;

-- c. Stores with Highest Growth in Sales Over Past Quarters
SELECT
    store_id,
    SUM(total_sales) AS total_sales,
    (SUM(total_sales) - LAG(SUM(total_sales)) OVER (PARTITION BY store_id ORDER BY DATE_FORMAT(date, '%Y-%m'))) AS sales_growth
FROM
    StoreSales
GROUP BY
    store_id, DATE_FORMAT(date, '%Y-%m')
ORDER BY
    sales_growth DESC
LIMIT 10;

-- d. Impact of Store-Specific Promotions
SELECT
    ss.store_id,
    SUM(ss.total_sales) AS total_sales,
    COUNT(DISTINCT sc.campaign_id) AS total_promotions
FROM
    StoreSales ss
LEFT JOIN MarketingCampaigns sc ON sc.campaign_id = ss.store_id
GROUP BY
    ss.store_id;

-- Product Performance and Inventory Analysis

-- a. Top Sellers in Terms of Quantity Sold and Revenue
SELECT
    p.product_id,
    SUM(cp.quantity) AS total_quantity_sold,
    SUM(cp.total_amount) AS total_revenue
FROM
    Products p
JOIN CustomerPurchases cp ON p.product_id = cp.product_id
GROUP BY
    p.product_id
ORDER BY
    total_revenue DESC, total_quantity_sold DESC;

-- b. Inventory Turnover Rate for Each Product Category
SELECT
    pc.category_name,
    AVG(stock / NULLIF(SUM(cp.quantity), 0)) AS inventory_turnover_rate
FROM
    ProductCategories pc
JOIN Products p ON p.hierarchy1_id = pc.category_id
JOIN ProductInventory pi ON pi.product_id = p.product_id
JOIN CustomerPurchases cp ON cp.product_id = p.product_id
GROUP BY
    pc.category_name;

-- c. Products with Consistently High or Low Demand
SELECT
    p.product_id,
    AVG(pd.demand) AS avg_demand
FROM
    Products p
JOIN ProductDemand pd ON pd.product_id = p.product_id
GROUP BY
    p.product_id
HAVING
    avg_demand > (SELECT AVG(demand) FROM ProductDemand) -- High demand
    OR avg_demand < (SELECT AVG(demand) FROM ProductDemand); -- Low demand

-- d. Stock Availability and Sales Impact
SELECT
    pi.product_id,
    SUM(cp.total_amount) AS total_sales,
    AVG(pi.stock) AS avg_stock
FROM
    ProductInventory pi
JOIN CustomerPurchases cp ON pi.product_id = cp.product_id
GROUP BY
    pi.product_id;

-- Marketing and Promotion Effectiveness

-- a. Effectiveness of Marketing Campaigns
SELECT
    mc.campaign_name,
    SUM(cr.total_revenue) AS total_revenue,
    SUM(cr.conversions) AS total_conversions
FROM
    MarketingCampaigns mc
JOIN CampaignResults cr ON mc.campaign_id = cr.campaign_id
GROUP BY
    mc.campaign_name;

-- b. ROI of Recent Marketing Initiatives
SELECT
    mc.campaign_name,
    (SUM(cr.total_revenue) - mc.budget) / mc.budget AS roi
FROM
    MarketingCampaigns mc
JOIN CampaignResults cr ON mc.campaign_id = cr.campaign_id
GROUP BY
    mc.campaign_name;

-- c. Promotional Tactics Impact on Sales
SELECT
    promo_type_1 AS promo_type,
    AVG(price) AS avg_price,
    SUM(sales) AS total_sales
FROM
    SalesData
GROUP BY
    promo_type_1
ORDER BY
    total_sales DESC;

-- d. Seasonal Trends in Consumer Behavior
SELECT
    DATE_FORMAT(purchase_date, '%Y-%m') AS month,
    SUM(total_amount) AS total_sales
FROM
    CustomerPurchases
GROUP BY
    month
ORDER BY
    month;

-- Customer Retention and Churn Analysis

-- a. Customer Retention Rate
SELECT
    DATE_FORMAT(registration_date, '%Y-%m') AS month,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(CASE WHEN last_purchase_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND CURDATE() THEN 1 ELSE 0 END) AS retained_customers
FROM
    CustomerActivity
GROUP BY
    month;

-- b. Return Rates or Churn Rates Across Product Categories
SELECT
    p.hierarchy1_id AS category_id,
    COUNT(DISTINCT ca.customer_id) AS returning_customers,
    COUNT(DISTINCT cp.customer_id) AS total_customers,
    (COUNT(DISTINCT cp.customer_id) - COUNT(DISTINCT ca.customer_id)) / COUNT(DISTINCT cp.customer_id) AS churn_rate
FROM
    Products p
JOIN CustomerPurchases cp ON p.product_id = cp.product_id
LEFT JOIN CustomerActivity ca ON cp.customer_id = ca.customer_id AND ca.last_purchase_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE()
GROUP BY
    p.hierarchy1_id;

-- c. Correlation Between Customer Satisfaction and Repeat Purchases
SELECT
    AVG(ca.total_spent) AS avg_spent,
    AVG(cf.rating) AS avg_rating
FROM
    CustomerActivity ca
JOIN CustomerFeedback cf ON ca.customer_id = cf.customer_id
GROUP BY
    cf.customer_id;

-- d. Strategies to Improve Customer Retention and Reduce Churn

-- Start

-- 1. Identify High-Risk Customers
SELECT
    customer_id,
    last_purchase_date,
    DATEDIFF(CURDATE(), last_purchase_date) AS days_since_last_purchase
FROM
    CustomerActivity
WHERE
    last_purchase_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY
    days_since_last_purchase DESC;

-- 2. Analyze Customer Lifetime Value (CLV)
SELECT
    customer_id,
    SUM(total_spent) AS lifetime_value
FROM
    CustomerPurchases
GROUP BY
    customer_id
ORDER BY
    lifetime_value DESC;

-- 3. Assess Customer Feedback and Satisfaction
SELECT
    cf.customer_id,
    AVG(cf.rating) AS avg_rating,
    COUNT(cp.transaction_id) AS number_of_purchases
FROM
    CustomerFeedback cf
JOIN
    CustomerPurchases cp ON cf.customer_id = cp.customer_id
GROUP BY
    cf.customer_id
HAVING
    AVG(cf.rating) >= 4; -- Adjust rating threshold as needed

-- 4. Evaluate Loyalty Program Effectiveness
SELECT
    lp.customer_id,
    SUM(lp.points_earned) AS total_points,
    COUNT(DISTINCT cp.transaction_id) AS number_of_purchases
FROM
    LoyaltyProgram lp
JOIN
    CustomerPurchases cp ON lp.customer_id = cp.customer_id
GROUP BY
    lp.customer_id
HAVING
    total_points > 0;

-- 5. Monitor Customer Support Cases
SELECT
    ca.customer_id,
    COUNT(cs.case_id) AS number_of_support_cases,
    MAX(cs.case_resolved_date) AS last_support_case_date
FROM
    CustomerActivity ca
JOIN
    CustomerSupport cs ON ca.customer_id = cs.customer_id
GROUP BY
    ca.customer_id
HAVING
    last_support_case_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 6 MONTH) AND CURDATE();

-- 6. Track Churn Rates by Product Category
SELECT
    p.hierarchy1_id AS category_id,
    COUNT(DISTINCT cp.customer_id) AS total_customers,
    COUNT(DISTINCT ca.customer_id) AS retained_customers,
    ((COUNT(DISTINCT cp.customer_id) - COUNT(DISTINCT ca.customer_id)) / COUNT(DISTINCT cp.customer_id)) * 100 AS churn_rate
FROM
    Products p
JOIN
    CustomerPurchases cp ON p.product_id = cp.product_id
LEFT JOIN
    CustomerActivity ca ON cp.customer_id = ca.customer_id AND ca.last_purchase_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE()
GROUP BY
    p.hierarchy1_id;

-- 7. Design Win-Back Campaigns
SELECT
    customer_id,
    last_purchase_date
FROM
    CustomerActivity
WHERE
    last_purchase_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
ORDER BY
    last_purchase_date;

-- 8. Analyze Effectiveness of Marketing Campaigns
SELECT
    campaign_id,
    SUM(revenue_generated) AS total_revenue,
    SUM(cost) AS total_cost,
    (SUM(revenue_generated) - SUM(cost)) / SUM(cost) * 100 AS roi_percentage
FROM
    MarketingCampaigns
GROUP BY
    campaign_id;
    
-- End