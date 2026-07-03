# 🚚 FedEx Logistics Optimization for Delivery Routes using SQL

([Fedex_Logo](https://github.com/the-arjun-thakur/Fedex_Logistics_Project/blob/main/images.png)

## 📌 Project Title

**FedEx Logistics Optimization for Delivery Routes using SQL**

---

# 📖 Introduction

This project focuses on analyzing FedEx logistics data using SQL to improve delivery performance and operational efficiency. FedEx manages millions of shipments across different countries every day. Delays caused by traffic, customs clearance, weather conditions, warehouse congestion, and delivery issues can affect customer satisfaction and increase operational costs.

The objective of this project is to analyze shipment data, identify delay patterns, evaluate warehouse and delivery agent performance, optimize delivery routes, and generate business KPIs using SQL.

---

# 🎯 Problem Statement

FedEx operates a global logistics network where maintaining on-time deliveries is a major challenge.

The company wants to:

- Identify shipment delay patterns.
- Optimize delivery routes.
- Improve warehouse efficiency.
- Evaluate delivery agent performance.
- Track shipment status.
- Generate business KPIs for better decision making.

Using SQL, this project analyzes logistics data and provides actionable insights to improve delivery efficiency and reduce operational delays.

---

# 🗂 Dataset Information

The project uses five datasets.

| Table | Description |
|--------|-------------|
| Orders | Contains customer orders and payment details |
| Routes | Contains source, destination and route information |
| Warehouses | Contains warehouse capacity and location details |
| Delivery Agents | Contains delivery agent ratings and experience |
| Shipments | Contains shipment tracking, delays and delivery status |

---

# 🛠 Tools & Technologies Used

- MySQL Workbench 8.0
- SQL
- Microsoft Excel
- CSV Files
- GitHub

---

# 📚 SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- HAVING
- JOINS
- Aggregate Functions
- Window Functions
- CASE Statement
- Common Table Expressions (CTE)
- Subqueries
- TIMESTAMPDIFF()

---

# 📋 Project Tasks and SQL Solutions

---

# ✅ Task 1 : Data Cleaning & Preparation

## Objective

Prepare the dataset for analysis by removing inconsistencies and validating data.

### Questions

### 1. Identify duplicate Order_ID or Shipment_ID records.

```sql
SELECT Order_ID,COUNT(*)
FROM Orders
GROUP BY Order_ID
HAVING COUNT(*)>1;

SELECT Shipment_ID,COUNT(*)
FROM Shipments
GROUP BY Shipment_ID
HAVING COUNT(*)>1;
```

---

### 2. Replace NULL Delay_Hours values with average delay.

```sql
UPDATE Shipments s
JOIN
(
SELECT Route_ID,
AVG(Delay_Hours) AvgDelay
FROM Shipments
GROUP BY Route_ID
) a
ON s.Route_ID=a.Route_ID
SET s.Delay_Hours=a.AvgDelay
WHERE s.Delay_Hours IS NULL;
```

---

### 3. Validate Delivery Date

```sql
SELECT *
FROM Shipments
WHERE Delivery_Date<Pickup_Date;
```

---

### 4. Validate Referential Integrity

```sql
SELECT s.Order_ID
FROM Shipments s
LEFT JOIN Orders o
ON s.Order_ID=o.Order_ID
WHERE o.Order_ID IS NULL;
```

---

# ✅ Task 2 : Delivery Delay Analysis

## Objective

Analyze shipment delays and identify inefficient delivery routes.

### 1. Calculate Delivery Delay

```sql
SELECT
Shipment_ID,
TIMESTAMPDIFF(HOUR,Pickup_Date,Delivery_Date) AS Delivery_Delay
FROM Shipments;
```

---

### 2. Top 10 Delayed Routes

```sql
SELECT
Route_ID,
AVG(Delay_Hours) Average_Delay
FROM Shipments
GROUP BY Route_ID
ORDER BY Average_Delay DESC
LIMIT 10;
```

---

### 3. Rank Shipments by Delay

```sql
SELECT
Shipment_ID,
Warehouse_ID,
Delay_Hours,
RANK() OVER(PARTITION BY Warehouse_ID
ORDER BY Delay_Hours DESC) Rank_No
FROM Shipments;
```

---

### 4. Average Delay per Delivery Type

```sql
SELECT
Delivery_Type,
AVG(Delay_Hours)
FROM Orders
JOIN Shipments
ON Orders.Order_ID=Shipments.Order_ID
GROUP BY Delivery_Type;
```

---

# ✅ Task 3 : Route Optimization

### 1. Average Transit Time

```sql
SELECT
Route_ID,
AVG(TIMESTAMPDIFF(HOUR,Pickup_Date,Delivery_Date))
FROM Shipments
GROUP BY Route_ID;
```

---

### 2. Average Delay

```sql
SELECT
Route_ID,
AVG(Delay_Hours)
FROM Shipments
GROUP BY Route_ID;
```

---

### 3. Efficiency Ratio

```sql
SELECT
Route_ID,
Distance_KM,
Avg_Transit_Time_Hours,
Distance_KM/Avg_Transit_Time_Hours AS Efficiency
FROM Routes;
```

---

### 4. Worst Routes

```sql
SELECT
Route_ID,
Distance_KM/Avg_Transit_Time_Hours AS Efficiency
FROM Routes
ORDER BY Efficiency
LIMIT 3;
```

---

### 5. Routes with More than 20% Delay

```sql
SELECT
Route_ID,
COUNT(*)
FROM Shipments
WHERE Delay_Hours>20
GROUP BY Route_ID;
```

---

# ✅ Task 4 : Warehouse Performance

### Top Warehouses

```sql
SELECT
Warehouse_ID,
AVG(Delay_Hours)
FROM Shipments
GROUP BY Warehouse_ID
ORDER BY AVG(Delay_Hours) DESC
LIMIT 3;
```

---

### Shipment Count

```sql
SELECT
Warehouse_ID,
COUNT(*) Total_Shipments,
SUM(Delay_Hours>0) Delayed
FROM Shipments
GROUP BY Warehouse_ID;
```

---

### Warehouse Ranking

```sql
SELECT
Warehouse_ID,
ROUND((SUM(Delivery_Status='Delivered')*100)/COUNT(*),2) On_Time,
RANK() OVER(ORDER BY ROUND((SUM(Delivery_Status='Delivered')*100)/COUNT(*),2) DESC) Rank_No
FROM Shipments
GROUP BY Warehouse_ID;
```

---

# ✅ Task 5 : Delivery Agent Performance

### Agent Ranking

```sql
SELECT
Agent_ID,
Route_ID,
ROUND((SUM(Delivery_Status='Delivered')*100)/COUNT(*),2) On_Time
FROM Shipments
GROUP BY Agent_ID,Route_ID;
```

---

### Agents below 85%

```sql
SELECT
Agent_ID,
ROUND((SUM(Delivery_Status='Delivered')*100)/COUNT(*),2) On_Time
FROM Shipments
GROUP BY Agent_ID
HAVING On_Time<85;
```

---

### Top 5 Agents

```sql
SELECT
AVG(Avg_Rating),
AVG(Experience_Years)
FROM
(
SELECT *
FROM Delivery_Agents
ORDER BY Avg_Rating DESC
LIMIT 5
) A;
```

---

### Bottom 5 Agents

```sql
SELECT
AVG(Avg_Rating),
AVG(Experience_Years)
FROM
(
SELECT *
FROM Delivery_Agents
ORDER BY Avg_Rating
LIMIT 5
) A;
```

---

# ✅ Task 6 : Shipment Tracking Analytics

### Shipment Status

```sql
SELECT
Shipment_ID,
Delivery_Status,
Delivery_Date
FROM Shipments;
```

---

### Returned Shipments

```sql
SELECT
Route_ID,
Delivery_Status,
COUNT(*)
FROM Shipments
WHERE Delivery_Status IN('Returned','In Transit')
GROUP BY Route_ID,Delivery_Status;
```

---

### Delay Reasons

```sql
SELECT
Delay_Reason,
COUNT(*)
FROM Shipments
GROUP BY Delay_Reason;
```

---

### Delay Greater than 120 Hours

```sql
SELECT
Order_ID,
Delay_Hours
FROM Shipments
WHERE Delay_Hours>120;
```

---

# ✅ Task 7 : KPI Reporting

### Country Wise Delay

```sql
SELECT
Source_Country,
AVG(Delay_Hours)
FROM Routes
JOIN Shipments
ON Routes.Route_ID=Shipments.Route_ID
GROUP BY Source_Country;
```

---

### On Time Delivery %

```sql
SELECT
ROUND((SUM(Delivery_Status='Delivered')*100)/COUNT(*),2)
FROM Shipments;
```

---

### Route Delay

```sql
SELECT
Route_ID,
AVG(Delay_Hours)
FROM Shipments
GROUP BY Route_ID;
```

---

### Warehouse Utilization

```sql
SELECT
Warehouse_ID,
COUNT(*) Shipments,
ROUND((COUNT(*)*100)/Capacity_per_day,2)
FROM Warehouses
JOIN Shipments
USING(Warehouse_ID)
GROUP BY Warehouse_ID;
```

---

# 📊 Key Insights

- Clean and validated data improves the accuracy of analysis.
- Some routes consistently experience higher delivery delays.
- Certain warehouses have lower on-time delivery performance.
- Delivery agent performance varies based on experience and customer ratings.
- Delay reasons such as weather, customs, and traffic significantly affect delivery timelines.
- Warehouse utilization helps identify underutilized and overloaded warehouses.
- KPI reporting provides valuable insights for operational decision-making.

---

# 💡 Business Recommendations

- Optimize routes with consistently high delays.
- Improve warehouse operations with lower on-time delivery rates.
- Provide training to low-performing delivery agents.
- Balance delivery workload among agents.
- Monitor shipment delays regularly using KPI dashboards.
- Improve route planning to reduce operational costs.
- Increase focus on customer satisfaction through timely deliveries.

---

# ✅ Conclusion

This project demonstrates how SQL can be used to solve real-world logistics problems through data analysis. By cleaning the data, analyzing delivery performance, evaluating warehouses and delivery agents, optimizing routes, and creating business KPIs, meaningful insights were generated to support better operational decisions.

The project highlights the importance of SQL in logistics analytics and demonstrates how data-driven decision-making can improve delivery efficiency, reduce delays, and enhance customer satisfaction.

---

# 👨‍💻 Developed By

**Arjun Thakur**


Vishwakarma Institute of Technology, Pune
