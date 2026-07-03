CREATE DATABASE fedex_logistics;

USE fedex_logistics;

CREATE TABLE Orders (
    Order_ID VARCHAR(10) PRIMARY KEY,
    Customer_ID VARCHAR(10),
    Order_Date DATETIME,
    Route_ID VARCHAR(10),
    Warehouse_ID VARCHAR(10),
    Order_Amount DECIMAL(10,2),
    Delivery_Type VARCHAR(20),
    Payment_Mode VARCHAR(30)
);

CREATE TABLE Routes (
    Route_ID VARCHAR(10) PRIMARY KEY,
    Source_City VARCHAR(50),
    Source_Country VARCHAR(50),
    Destination_City VARCHAR(50),
    Destination_Country VARCHAR(50),
    Distance_KM DECIMAL(10,2),
    Avg_Transit_Time_Hours DECIMAL(10,2)
);

CREATE TABLE Warehouses (
    Warehouse_ID VARCHAR(10) PRIMARY KEY,
    City VARCHAR(50),
    Country VARCHAR(50),
    Capacity_per_day INT,
    Manager_Name VARCHAR(100)
);

CREATE TABLE Delivery_Agents (
    Agent_ID VARCHAR(10) PRIMARY KEY,
    Agent_Name VARCHAR(100),
    Zone VARCHAR(50),
    Zone_Country VARCHAR(50),
    Experience_Years INT,
    Avg_Rating DECIMAL(3,2)
);

CREATE TABLE Shipments (
    Shipment_ID VARCHAR(10) PRIMARY KEY,
    Order_ID VARCHAR(10),
    Agent_ID VARCHAR(10),
    Route_ID VARCHAR(10),
    Warehouse_ID VARCHAR(10),
    Pickup_Date DATETIME,
    Delivery_Date DATETIME,
    Delivery_Status VARCHAR(30),
    Delay_Hours DECIMAL(10,2),
    Delivery_Feedback VARCHAR(255)
);

SELECT COUNT(*) AS Orders FROM Orders;

SELECT COUNT(*) AS Routes FROM Routes;

SELECT COUNT(*) AS Warehouses FROM Warehouses;

SELECT COUNT(*) AS Delivery_Agents FROM Delivery_Agents;

SELECT COUNT(*) AS Shipments FROM Shipments;