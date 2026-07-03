SELECT
    Agent_ID,
    Route_ID,

    ROUND((SUM(Delivery_Status='Delivered')*100)/COUNT(*),2)
    AS On_Time_Percentage,

    RANK() OVER(
        PARTITION BY Route_ID
        ORDER BY (SUM(Delivery_Status='Delivered')*100)/COUNT(*) DESC
    ) AS Agent_Rank

FROM Shipments

GROUP BY Agent_ID, Route_ID;



SELECT
    Agent_ID,

    ROUND((SUM(Delivery_Status='Delivered')*100)/COUNT(*),2)
    AS On_Time_Percentage

FROM Shipments

GROUP BY Agent_ID

HAVING On_Time_Percentage < 85;


SELECT
AVG(Avg_Rating) AS Average_Rating,
AVG(Experience_Years) AS Average_Experience
FROM
(
SELECT *
FROM Delivery_Agents
ORDER BY Avg_Rating DESC
LIMIT 5
) AS Top5;


SELECT
AVG(Avg_Rating) AS Average_Rating,
AVG(Experience_Years) AS Average_Experience
FROM
(
SELECT *
FROM Delivery_Agents
ORDER BY Avg_Rating ASC
LIMIT 5
) AS Bottom5;