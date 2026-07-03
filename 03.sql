SELECT
    Route_ID,
    ROUND(AVG(TIMESTAMPDIFF(SECOND, Pickup_Date, Delivery_Date) / 3600),2) AS Average_Transit_Time_Hours
FROM Shipments
GROUP BY Route_ID
ORDER BY Average_Transit_Time_Hours DESC;

SELECT
    Route_ID,
    ROUND(AVG(Delay_Hours),2) AS Average_Delay_Hours
FROM Shipments
GROUP BY Route_ID
ORDER BY Average_Delay_Hours DESC;

SELECT
    Route_ID,
    Distance_KM,
    Avg_Transit_Time_Hours,
    ROUND(Distance_KM / Avg_Transit_Time_Hours,2) AS Efficiency_Ratio
FROM Routes
ORDER BY Efficiency_Ratio DESC;


SELECT
    Route_ID,
    Distance_KM,
    Avg_Transit_Time_Hours,
    ROUND(Distance_KM / Avg_Transit_Time_Hours,2) AS Efficiency_Ratio
FROM Routes
ORDER BY Efficiency_Ratio ASC
LIMIT 3;


SELECT
    s.Route_ID,
    COUNT(*) AS Total_Shipments,

    SUM(
        CASE
            WHEN TIMESTAMPDIFF(HOUR, Pickup_Date, Delivery_Date) >
                 r.Avg_Transit_Time_Hours
            THEN 1
            ELSE 0
        END
    ) AS Delayed_Shipments,

    ROUND(
        SUM(
            CASE
                WHEN TIMESTAMPDIFF(HOUR, Pickup_Date, Delivery_Date) >
                     r.Avg_Transit_Time_Hours
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Delay_Percentage

FROM Shipments s
JOIN Routes r
ON s.Route_ID = r.Route_ID

GROUP BY s.Route_ID

HAVING Delay_Percentage > 20;