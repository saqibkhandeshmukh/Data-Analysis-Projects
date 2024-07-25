-- SQL query to create and import data from csv files ---

--- create a database ---
	create database "credit card financial report"

--- create credit_card table ---
	create table credit_card
	(
    Client_Num INT,
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date DATE,
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Ct INT,
    Avg_Utilization_Ratio DECIMAL(10,3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10,3),
    Delinquent_Acc VARCHAR(5)
	)

--- create customer table ---
	create table customer
	(
    Client_Num INT,
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),
    Income INT,
    Cust_Satisfaction_Score INT
	)

--- copy csv data into SQL ---

	-- copy credit_card table --
	COPY credit_card
	FROM 'D:\SKD\Data Analyst\4. Power BI\3. Power BI Project\6. Credit Card Financial Report\credit_card.csv' 
	DELIMITER ',' 
	CSV HEADER;
	
	-- copy custoemer table --
	COPY customer
	FROM 'D:\SKD\Data Analyst\4. Power BI\3. Power BI Project\6. Credit Card Financial Report\customer.csv' 
	DELIMITER ',' 
	CSV HEADER;

--- inserting additional data into SQL & created tables ---

	-- copy additional data (week-53) in credit_card table --
	COPY credit_card
	FROM 'D:\SKD\Data Analyst\4. Power BI\3. Power BI Project\6. Credit Card Financial Report\cc_add.csv' 
	DELIMITER ',' 
	CSV HEADER;
	
	-- copy additional data (week-53) in customer table --
	COPY customer
	FROM 'D:\SKD\Data Analyst\4. Power BI\3. Power BI Project\6. Credit Card Financial Report\cust_add.csv' 
	DELIMITER ','
	CSV HEADER;