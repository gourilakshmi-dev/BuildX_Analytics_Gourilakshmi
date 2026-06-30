-- ==================================
-- PART B2: SQL - BUSINESS ANALYSIS
-- ==================================

-- QUERY 1: WHERE Filter
-- Purpose: Filter down to high-value Private Equity deals based out of Bengaluru.
SELECT  c3 AS startup_name, c8 AS investment_type, c9 AS amount_in_usd FROM cleaned_dataset 
WHERE c6 = 'Bengaluru' AND c8 = 'Private Equity';

-- QUERY 2: GROUP BY + COUNT/SUM/AVG Aggregations
-- Purpose: Group and aggregate total transaction activity and average ticket sizing per industry vertical.
SELECT c4 AS industry_vertical, COUNT(*) as deal_volume, SUM(CAST(c9 as INT)) AS aggregate_capital_usd, 
AVG(CAST(c9 AS INT)) as average_deal_amount FROM cleaned_dataset GROUP BY c4;

-- QUERY 3: ORDER BY DESC Sequence
-- Purpose: Identify top 10 single largest investment deals recorded in the system.
SELECT c1 as sr_no, c3 as startup_name, c6 as city_location, CAST(c9 as INT) AS amount_in_usd, c11 as year
FROM cleaned_dataset ORDER BY CAST(c9 as INT) DESC LIMIT 10;


-- QUERY 4: HAVING Aggregate Filter
-- Purpose: Isolate geographic hub locations that hosted more than 20 individual deals.
SELECT c6 as city_location, COUNT(*) as active_deals FROM cleaned_dataset GROUP BY c6 HAVING COUNT(*) > 20;

-- QUERY 5: LIKE/BETWEEN Pattern Range Matcher
-- Purpose: Find mid-market growth deals between $1M and $25M USD backed by 'Tiger Global' entities.
SELECT c3 as startup_name, c7 as investors_name, CAST(c9 as INT) AS amount_in_usd FROM cleaned_dataset WHERE 
CAST(c9 as INT) BETWEEN 1000000 AND 25000000 AND c7 LIKE '%Tiger Global%';

-- QUERY 6: Advanced Multi-Concept Analytical Summary
-- Purpose: Evaluate market distribution metrics across our custom calculated funding tiers.
SELECT c12 as funding_tier, COUNT(*) as total_deal_count, SUM(CAST(c9 as INT)) AS total_capital_injected,
ROUND(AVG(CAST(c9 as INT)), 2) AS average_ticket_size FROM cleaned_dataset WHERE c12 != 'Undisclosed' AND c12
IS NOT NULL GROUP BY c12 HAVING SUM(CAST(c9 AS INT)) > 1000000 ORDER BY total_capital_injected DESC;