SELECT
    Shipment_ID,
    Order_ID,
    Pickup_Date,
    Delivery_Date,
    ROUND(TIMESTAMPDIFF(SECOND, Pickup_Date, Delivery_Date) / 3600, 2) AS Delivery_Delay_Hours
FROM Shipments;

SELECT
    Route_ID,
    ROUND(AVG(Delay_Hours),2) AS Average_Delay_Hours
FROM Shipments
GROUP BY Route_ID
ORDER BY Average_Delay_Hours DESC
LIMIT 10;

SELECT
    Shipment_ID,
    Warehouse_ID,
    Delay_Hours,
    RANK() OVER(
        PARTITION BY Warehouse_ID
        ORDER BY Delay_Hours DESC
    ) AS Delay_Rank
FROM Shipments;

SELECT
    o.Delivery_Type,
    ROUND(AVG(s.Delay_Hours),2) AS Average_Delay_Hours
FROM Orders o
JOIN Shipments s
ON o.Order_ID = s.Order_ID
GROUP BY o.Delivery_Type;