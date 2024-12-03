-- When Considering Average Spend from Receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, Which is Greater?
SELECT 
	rewardsReceiptStatus,
    AVG(totalSpent) AS average_spend
FROM 
    receipts
WHERE 
    rewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY 
    rewardsReceiptStatus;

-- Top 5 Brands by Receipts Scanned for Most Recent Month

SELECT 
    b.name AS brand_name,
    COUNT(r.id) AS receipts_scanned
FROM 
    Receipts r
JOIN 
    Brands b ON r.userId = b.id 
WHERE 
    r.dateScanned >= date_trunc('month', CURRENT_DATE)  -- Filters for the current month
GROUP BY 
    b.name
ORDER BY 
    receipts_scanned DESC
LIMIT 5;


-- Which Brand Has the Most Spend Among Users Who Were Created Within the Past 6 Months?

SELECT 
    b.name AS brand_name,
    SUM(r.totalSpent) AS total_spend
FROM 
    Receipts r
JOIN 
    Users u ON r.userId = u.id
JOIN 
    Brands b ON r.userId = b.id  -- Adjust this join condition as necessary
WHERE 
    u.createdDate >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY 
    b.name
ORDER BY 
    total_spend DESC
LIMIT 1;
