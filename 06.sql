SELECT
    Shipment_ID,
    Delivery_Status,
    Delivery_Date
FROM Shipments;


SELECT
    Route_ID,
    Delivery_Status,
    COUNT(*) AS Total_Shipments
FROM Shipments
WHERE Delivery_Status IN ('In Transit','Returned')
GROUP BY Route_ID, Delivery_Status
ORDER BY Total_Shipments DESC;


SELECT
    Delay_Reason,
    COUNT(*) AS Total_Count
FROM Shipments
GROUP BY Delay_Reason
ORDER BY Total_Count DESC;


SELECT
    Order_ID,
    Shipment_ID,
    Delay_Hours
FROM Shipments
WHERE Delay_Hours > 120;