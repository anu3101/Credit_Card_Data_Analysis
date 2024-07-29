

CREATE TABLE credit_card (
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
);

CREATE TABLE customer_info (
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
);

--Basic Data Understanding and Querying

SELECT COUNT(*) FROM customer_info;

SELECT COUNT(*) FROM credit_card;

-- Card categories from the credit_card table
SELECT DISTINCT Card_Category FROM credit_card;

-- Calculate the average annual fees of all credit cards
SELECT Card_Category, AVG(Annual_Fees) AS avg_fees
FROM credit_card
GROUP BY Card_Category;

-- Find the highest credit limit in the credit_card table
SELECT MAX(Credit_Limit) 
FROM credit_card;

-- Find the youngest customer in the customer table
SELECT MIN(Customer_Age) FROM customer_info;

-- Count the number of customers for each education level
SELECT Education_Level, COUNT(*) AS count
FROM customer_info
GROUP BY Education_Level;

--All customers who own a house
SELECT COUNT(*) FROM customer_info
WHERE House_Owner = 'yes';

-- Calculate the average number of transactions made by each customer
SELECT AVG(total_trans_ct) AS avg_transactions_per_customer
FROM credit_card;

-- Count the number of customers for each gender
SELECT Gender, COUNT(*) AS count
FROM customer_info
GROUP BY Gender;

-- Top 5 customers with the highest credit limits
SELECT Client_Num, Credit_Limit
FROM credit_card
ORDER BY Credit_Limit DESC
LIMIT 5;

-- Retrieve all customers with more than 2 dependents
SELECT * FROM customer_info
WHERE Dependent_Count > 2;


-- Calculate the total interest earned by each customer
SELECT Client_Num, SUM(Interest_Earned) AS total_interest_earned
FROM credit_card
GROUP BY Client_Num
ORDER BY total_interest_earned DESC
LIMIT 100;

-- All single customers who have a personal loan
SELECT * FROM customer
WHERE Marital_Status = 'Single' AND Personal_loan = 'yes';

-- Calculate the average transaction amount for each quarter
SELECT Qtr, AVG(Total_Trans_Amt) AS avg_transaction_amount
FROM credit_card
GROUP BY Qtr;



-- Find customers with an average utilization ratio greater than 0.5
SELECT Client_Num, AVG(Avg_Utilization_Ratio) AS avg_utilization
FROM credit_card
GROUP BY Client_Num
HAVING avg_utilization > 0.5;

-- Find the top 10 customers by their total transaction amount
SELECT Client_Num,  SUM(Total_Trans_Amt) AS total_transaction_amount
FROM credit_card
GROUP BY Client_Num
ORDER BY total_transaction_amount DESC
LIMIT 10

-- Find the most popular card category based on the number of customers
SELECT Card_Category, COUNT(*) AS count
FROM credit_card
GROUP BY Card_Category
ORDER BY count DESC
LIMIT 1;

-- Calculate the average customer acquisition cost for each card category
SELECT Card_Category, AVG(Customer_Acq_Cost) AS avg_acq_cost
FROM credit_card
GROUP BY Card_Category;



-- Calculate the total revolving balance for each state
SELECT c.state_cd, SUM(cc.Total_Revolving_Bal) AS total_revolving_bal
FROM credit_card cc
JOIN customer_info c ON cc.Client_Num = c.Client_Num
GROUP BY c.state_cd;


-- Calculate the total annual fees collected each quarter
SELECT qtr, SUM(Annual_Fees) AS total_annual_fees
FROM credit_card
GROUP BY qtr;


-- Calculate the average customer satisfaction score for each job type
SELECT Customer_Job, AVG(Cust_Satisfaction_Score) AS avg_satisfaction
FROM customer_info
GROUP BY Customer_Job;

-- Calculate the average transaction amount for each quarter
SELECT Qtr, AVG(Total_Trans_Amt) AS avg_transaction_amount
FROM credit_card
GROUP BY Qtr;


-- Calculate the total annual fees collected each year
SELECT qtr, SUM(annual_fees) AS total_annual_fees
FROM credit_card
GROUP BY qtr;


-- Calculate the average customer satisfaction score for each job type
SELECT Customer_Job, AVG(cust_satisfaction_score) AS avg_satisfaction
FROM customer_info
GROUP BY Customer_Job;

-- Find the most common expenditure type among all transactions
SELECT Exp_Type, COUNT(*) AS count
FROM credit_card
GROUP BY Exp_Type
ORDER BY count DESC

-- Calculate the total income for each state
SELECT state_cd, SUM(Income) AS total_income
FROM customer_info
GROUP BY state_cd;

-- Retrieve all customers who own both a house and a car
SELECT Count(*) FROM customer_info
WHERE house_Owner = 'yes' AND car_owner = 'yes';


-- Calculate the total transaction amount for each week number
SELECT Week_Num, SUM(total_trans_amt) AS total_transaction_amount
FROM credit_card
GROUP BY Week_Num;



-- Calculate the total credit limit for each card category
SELECT Card_Category, SUM(Credit_Limit) AS total_credit_limit
FROM credit_card
GROUP BY Card_Category;

-- Calculate the average credit limit for each card category
SELECT Card_Category, AVG(Credit_Limit) AS avg_credit_limit
FROM credit_card
GROUP BY Card_Category;


-- Calculate the total acquisition cost for customers who own a car
SELECT SUM(Customer_Acq_Cost) AS total_acq_cost
FROM credit_card cc
JOIN customer_info c ON cc.Client_Num = c.Client_Num
WHERE c.Car_Owner = 'yes';


-- Calculate the total transaction volume for each gender
SELECT c.Gender, SUM(cc.total_trans_amt) AS total_transaction_volume
FROM credit_card cc
JOIN customer_info c ON cc.Client_Num = c.Client_Num
GROUP BY c.Gender;

-- Find the most common education level among customers with a personal loan
SELECT Education_Level, COUNT(*) AS count
FROM customer_info
WHERE Personal_loan = 'yes'
GROUP BY Education_Level
ORDER BY count DESC


-- Analyze total transaction amounts for different age groups
SELECT
  CASE
    WHEN Customer_Age < 20 THEN 'Under 20'
    WHEN Customer_Age BETWEEN 20 AND 29 THEN '20-29'
    WHEN Customer_Age BETWEEN 30 AND 39 THEN '30-39'
    WHEN Customer_Age BETWEEN 40 AND 49 THEN '40-49'
    WHEN Customer_Age BETWEEN 50 AND 59 THEN '50-59'
    ELSE '60 and above'
  END AS age_group,
  SUM(cc.total_trans_amt) AS total_transaction_amount
FROM customer_info c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY age_group
ORDER BY age_group


-- Find the gender distribution of customers with credit limits over $10,000
SELECT c.Gender, COUNT(*) AS count
FROM customer_info c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
WHERE cc.Credit_Limit > 10000
GROUP BY c.Gender;


-- Find the top 5 job types with the highest average credit limit
SELECT Customer_Job, AVG(cc.Credit_Limit) AS avg_credit_limit
FROM customer_info c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY Customer_Job
ORDER BY avg_credit_limit DESC
LIMIT 5;



