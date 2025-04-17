# SQL Data Cleaning Project

## Overview
This project showcases a complete data cleaning process using SQL in MySQL Workbench on a layoff dataset from global companies.

## Tools Used
- MySQL Workbench  
- SQL (CTEs, Joins, Row Number, and more)

## Dataset
The dataset contains 2000+ layoff records from global companies. It was used to demonstrate practical data cleaning techniques.

## Objectives
- Remove duplicates  
- Standardize the Data 
- Fix Null values or blank values
- Prepare clean data for analysis

## Key Steps

### 1. Viewing Raw Data  
![Raw Data](https://github.com/Akwardhan/SQL-Data-Cleaning-Project/blob/main/SQL-Data-Cleaning/Screenshots/1_Raw%20Data_Screenshot.png)

### 2. Removing Duplicates
![Duplicates Removed](https://github.com/Akwardhan/SQL-Data-Cleaning-Project/blob/main/SQL-Data-Cleaning/Screenshots/2_Removed%20Duplicates.png)

### 3. Identifying and Standardizing Cryptocurrency Values 
BEFORE:
![BEFORE](https://github.com/Akwardhan/SQL-Data-Cleaning-Project/blob/main/SQL-Data-Cleaning/Screenshots/3_Before%20handling%20the%20error%20Crypto.png)

AFTER:
![After](https://github.com/Akwardhan/SQL-Data-Cleaning-Project/blob/main/SQL-Data-Cleaning/Screenshots/4_After%20handling%20the%20error%20crypto.png)

### 4. Final Cleaned Data
![After Cleaning](https://github.com/Akwardhan/SQL-Data-Cleaning-Project/blob/main/SQL-Data-Cleaning/Screenshots/5_Final_Cleaned%20Dataset.png)

Note: Some null values (e.g., total_laid_off, percentage_laid_off) were retained intentionally, as these rows represent important company records. The missing values couldn’t be imputed reliably without additional external data.

## SQL Script
Find the complete SQL code in [SQL_Script.sql](https://github.com/Akwardhan/SQL-Data-Cleaning-Project/blob/main/SQL-Data-Cleaning/Data%20cleaning%20using%20SQL.sql)

## Learnings
- Writing clean and structured SQL queries
- Using CTEs and other essential SQL techniques
- Applying Real-world data cleaning methods

## Author
**Anmol Kirtiwardhan**  

• [LinkedIn](https://www.linkedin.com) 
• [Portfolio](https://your-portfolio.com)
