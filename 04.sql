SELECT
    Warehouse_ID,
    ROUND(AVG(Delay_Hours),2) AS Average_Delay_Hours
FROM Shipments
GROUP BY Warehouse_ID
ORDER BY Average_Delay_Hours DESC
LIMIT 3;

SELECT
    Warehouse_ID,
    COUNT(*) AS Total_Shipments,
    COUNT(CASE WHEN Delay_Hours > 0 THEN 1 END) AS Delayed_Shipments
FROM Shipments
GROUP BY Warehouse_ID;

SELECT
    Warehouse_ID,
    AVG(Delay_Hours) AS Average_Delay
FROM Shipments
GROUP BY Warehouse_ID
HAVING AVG(Delay_Hours) >
(
    SELECT AVG(Delay_Hours)
    FROM Shipments
);



WITH Avg_Delay AS
(
    SELECT AVG(Delay_Hours) AS Global_Avg
    FROM Shipments
)

SELECT
    Warehouse_ID,
    AVG(Delay_Hours) AS Average_Delay
FROM Shipments
GROUP BY Warehouse_ID
HAVING AVG(Delay_Hours) >
(
    SELECT Global_Avg
    FROM Avg_Delay
);



SELECT
    Warehouse_ID,

    ROUND(
        (SUM(Delay_Hours = 0) * 100) / COUNT(*),
        2
    ) AS On_Time_Percentage,

    RANK() OVER (
        ORDER BY
        (SUM(Delay_Hours = 0) * 100) / COUNT(*) DESC
    ) AS Warehouse_Rank

FROM Shipments
GROUP BY Warehouse_ID;






