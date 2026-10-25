----------------META Ads Performance Analysis----------------

---------------------------------------Total Impressions For Both Platforms-----------------
SELECT ad_platform, COUNT(event_type) AS impressions
FROM ad_events
JOIN ads 
ON ad_events.ad_id=ads.ad_id
WHERE event_type = 'Impression'
GROUP BY ad_platform
ORDER BY COUNT(event_type) DESC;

---------------------------------------Total Clicks For Both Platfroms----------------------
SELECT ad_platform, COUNT(event_type) AS Clicks
FROM ad_events
JOIN ads 
ON ad_events.ad_id=ads.ad_id
WHERE event_type = 'Click'
GROUP BY ad_platform
ORDER BY COUNT(event_type) DESC;

--------------------------------------Total Shares For Both Platforms------------------------
SELECT ad_platform, COUNT(event_type) AS Shares
FROM ad_events
JOIN ads 
ON ad_events.ad_id=ads.ad_id
WHERE event_type = 'Share'
GROUP BY ad_platform
ORDER BY COUNT(event_type) DESC;

-------------------------------------Total Comments For Both Platforms----------------------
SELECT ad_platform, COUNT(event_type) AS Comments
FROM ad_events
JOIN ads 
ON ad_events.ad_id=ads.ad_id
WHERE event_type = 'Comment'
GROUP BY ad_platform
ORDER BY COUNT(event_type) DESC;

------------------------------------Total Purchases For Both Platforms-------------------
SELECT ad_platform, COUNT(event_type) AS Purchases
FROM ad_events
JOIN ads 
ON ad_events.ad_id=ads.ad_id
WHERE event_type = 'Purchase'
GROUP BY ad_platform
ORDER BY COUNT(event_type) DESC;

-------------------------------Total Engagement for Both Platforms---------------------------
SELECT ad_platform, 
COUNT(CASE WHEN event_type = 'Click' OR event_type = 'Share' OR event_type = 'Comment' THEN event_type END) AS Engagemnets
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
GROUP BY ad_platform

--------------------------------Click Through Rate( % of Impressions that resluted in Clicks)----------------------
SELECT ad_platform, CAST(COUNT(CASE WHEN event_type = 'Click' THEN event_type END) *100.0
       / COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS DECIMAL(10,2)) AS Click_Through_Rate_Percentage
FROM ad_events
JOIN ads
ON ad_events.ad_id=ads.ad_id
GROUP BY ad_platform;

---------------------------------Engagement Rate (% of impressions that resulted in engagements)-----------------------
SELECT ad_platform, CAST(COUNT(CASE WHEN event_type = 'Click' OR event_type = 'Share' OR event_type = 'Comment' THEN event_type END) *100.0
                    / COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS DECIMAL(10,2)) AS Engagement_Rate_Percentage
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
GROUP BY ad_platform

---------------------------------Conversion Rate(% of Clicks that resulted in Purchases)---------------------------
SELECT ad_platform, CAST(COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) *100.0
                    / COUNT(CASE WHEN event_type = 'Click' THEN event_type END) AS DECIMAL(10,2)) AS Conversion_Rate_Percentage
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
GROUP BY ad_platform

-----------------------------------Purchase Rate(% of Impressions that resulted in Purchases)------------------
SELECT ad_platform, CAST(COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) *100.0
                    / COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS DECIMAL(10,2)) AS Purchase_Rate_Percentage
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
GROUP BY ad_platform

----------------------------------Total Budget (Total Spend Allocated To Campaigns)--------------
SELECT SUM(total_budget) AS Total_Budget_For_Both_Platforms
FROM campaigns;
-----------------------

SELECT ad_platform, SUM(total_budget) AS Total_Budget_For_Each
FROM campaigns
JOIN ads
ON campaigns.campaign_id=ads.campaign_id
GROUP BY ad_platform;

---------------------------------Average Budget Per Campaign-----------------------------
SELECT ad_platform, CAST(SUM(total_budget)
      / COUNT(campaigns.campaign_id) AS DECIMAL(10,2)) AS Average_Budget_Per_Campaign
FROM campaigns
JOIN ads
ON campaigns.campaign_id=ads.campaign_id
GROUP BY ad_platform;

---------------------------------------Performance By Target Gender------------------------
SELECT ad_platform, 
target_gender,
COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS Impressions,
COUNT(CASE WHEN event_type = 'Click' OR event_type = 'Share' OR event_type = 'Comment' THEN event_type END) AS Engagements,
COUNT(CASE WHEN event_type = 'Click' THEN event_type END) AS Clicks,
COUNT(CASE WHEN event_type = 'Share' THEN event_type END) AS Shares,
COUNT(CASE WHEN event_type = 'Comment' THEN event_type END) AS Comments,
COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) AS Purchases
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
GROUP BY ad_platform, target_gender
ORDER BY ad_platform;

-------------------------------------------Performance By Target Age Group-------------------------------
SELECT ad_platform, 
target_age_group,
COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS Impressions,
COUNT(CASE WHEN event_type = 'Click' OR event_type = 'Share' OR event_type = 'Comment' THEN event_type END) AS Engagements,
COUNT(CASE WHEN event_type = 'Click' THEN event_type END) AS Clicks,
COUNT(CASE WHEN event_type = 'Share' THEN event_type END) AS Shares,
COUNT(CASE WHEN event_type = 'Comment' THEN event_type END) AS Comments,
COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) AS Purchases
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
GROUP BY ad_platform, target_age_group
ORDER BY ad_platform;

-------------------------------------------Performance By Country----------------------------------
SELECT ad_platform, 
country,
COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS Impressions,
COUNT(CASE WHEN event_type = 'Click' OR event_type = 'Share' OR event_type = 'Comment' THEN event_type END) AS Engagements,
COUNT(CASE WHEN event_type = 'Click' THEN event_type END) AS Clicks,
COUNT(CASE WHEN event_type = 'Share' THEN event_type END) AS Shares,
COUNT(CASE WHEN event_type = 'Comment' THEN event_type END) AS Comments,
COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) AS Purchases
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
JOIN users
ON ad_events.user_id=users.user_id
GROUP BY ad_platform, country
ORDER BY ad_platform, Purchases DESC;

--------------------------------------------Performance By Month--------------------------------
SELECT MONTH(timestamp) AS Month_Number,
ad_platform, 
DATENAME(MONTH,timestamp) AS Month_Name,
COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS Impressions,
COUNT(CASE WHEN event_type = 'Click' OR event_type = 'Share' OR event_type = 'Comment' THEN event_type END) AS Engagements,
COUNT(CASE WHEN event_type = 'Click' THEN event_type END) AS Clicks,
COUNT(CASE WHEN event_type = 'Share' THEN event_type END) AS Shares,
COUNT(CASE WHEN event_type = 'Comment' THEN event_type END) AS Comments,
COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) AS Purchases
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
GROUP BY ad_platform, DATENAME(MONTH,timestamp), MONTH(timestamp)
ORDER BY ad_platform, MONTH(timestamp);

--------------------------------------- Weekly Performance By Ad Type-------------------------
SELECT
ad_platform,
ad_type,
DATEPART(WEEK,timestamp) AS Week_Number,
COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS Impressions,
COUNT(CASE WHEN event_type = 'Click' OR event_type = 'Share' OR event_type = 'Comment' THEN event_type END) AS Engagements,
COUNT(CASE WHEN event_type = 'Click' THEN event_type END) AS Clicks,
COUNT(CASE WHEN event_type = 'Share' THEN event_type END) AS Shares,
COUNT(CASE WHEN event_type = 'Comment' THEN event_type END) AS Comments,
COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) AS Purchases
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
GROUP BY ad_platform, ad_type, DATEPART(WEEK,timestamp)
ORDER BY ad_platform, DATEPART(WEEK,timestamp),COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) DESC;

---------------------------------------Performance By Hour------------------------------
SELECT
ad_platform, 
DATEPART(HOUR,timestamp) AS Hour,
COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS Impressions,
COUNT(CASE WHEN event_type = 'Click' OR event_type = 'Share' OR event_type = 'Comment' THEN event_type END) AS Engagements,
COUNT(CASE WHEN event_type = 'Click' THEN event_type END) AS Clicks,
COUNT(CASE WHEN event_type = 'Share' THEN event_type END) AS Shares,
COUNT(CASE WHEN event_type = 'Comment' THEN event_type END) AS Comments,
COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) AS Purchases
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
GROUP BY ad_platform, DATEPART(HOUR,timestamp)
ORDER BY ad_platform, DATEPART(HOUR,timestamp);

----------------------------------------Performmance By Ad Type Matrix Grid-----------------------------------
SELECT
ad_platform,
ad_type,
COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS Impressions,
COUNT(CASE WHEN event_type = 'Click' THEN event_type END) AS Clicks,
CAST(COUNT(CASE WHEN event_type = 'Click' THEN event_type END) *100.0
       / COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS DECIMAL(10,2)) AS Click_Through_Rate_Percentage,
CAST(COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) *100.0
                    / COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS DECIMAL(10,2)) AS Purchase_Rate_Percentage,
CAST(COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) *100.0
                    / COUNT(CASE WHEN event_type = 'Click' THEN event_type END) AS DECIMAL(10,2)) AS Conversion_Rate_Percentage,
CAST(COUNT(CASE WHEN event_type = 'Click' OR event_type = 'Share' OR event_type = 'Comment' THEN event_type END) *100.0
                    / COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS DECIMAL(10,2)) AS Engagement_Rate_Percentage
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
GROUP BY ad_platform, ad_type
ORDER BY ad_platform;

--------------------------Country By Conversion Rate------------------
SELECT ad_platform,
       country, 
       CAST(COUNT(CASE WHEN event_type = 'Purchase' THEN event_type END) *100.0
                    / COUNT(CASE WHEN event_type = 'Click' THEN event_type END) AS DECIMAL(10,2)) AS Conversion_Rate_Percentage
FROM ads
JOIN
ad_events
ON ads.ad_id=ad_events.ad_id
JOIN users
ON ad_events.user_id=users.user_id
GROUP BY ad_platform, country
ORDER BY ad_platform, Conversion_Rate_Percentage DESC;

----------------------------------Target Gender By Engagement_Rate--------------------
SELECT ad_platform, 
       target_gender, 
       CAST(COUNT(CASE WHEN event_type = 'Click' OR event_type = 'Share' OR event_type = 'Comment' THEN event_type END) *100.0
                    / COUNT(CASE WHEN event_type = 'Impression' THEN event_type END) AS DECIMAL(10,2)) AS Engagement_Rate_Percentage
FROM ads
JOIN ad_events
ON ads.ad_id=ad_events.ad_id
GROUP BY ad_platform,
         target_gender
ORDER BY ad_platform, Engagement_Rate_Percentage DESC;



      
