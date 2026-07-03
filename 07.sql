SELECT
    r.Source_Country,
    ROUND(AVG(s.Delay_Hours),2) AS Average_Delay
FROM Routes r
JOIN Shipments s
ON r.Route_ID = s.Route_ID
GROUP BY r.Source_Country;


SELECT
ROUND(
(SUM(CASE WHEN Delivery_Status='Delivered' THEN 1 ELSE 0 END)*100)
/COUNT(*),2
) AS On_Time_Delivery_Percentage
FROM Shipments;


SELECT
    Route_ID,
    ROUND(AVG(Delay_Hours),2) AS Average_Delay
FROM Shipments
GROUP BY Route_ID;


SELECT
    w.Warehouse_ID,
    COUNT(s.Shipment_ID) AS Shipments_Handled,
    w.Capacity_per_day,

    ROUND(
    (COUNT(s.Shipment_ID)*100)/w.Capacity_per_day,
    2
    ) AS Warehouse_Utilization

FROM Warehouses w

JOIN Shipments s
ON w.Warehouse_ID=s.Warehouse_ID

GROUP BY
w.Warehouse_ID,
w.Capacity_per_day;



SELECT
COUNT(*) AS Total_Shipments,
ROUND(AVG(Delay_Hours),2) AS Average_Delay,
ROUND((SUM(Delivery_Status='Delivered')*100)/COUNT(*),2) AS On_Time_Percentage
FROM Shipments;