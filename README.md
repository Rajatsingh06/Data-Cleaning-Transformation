# SQL Data Cleaning & Transformation

## 📌 Project Overview

This project demonstrates how **SQL can be used to clean, transform, standardize, and analyze inconsistent and incomplete data**.

The project uses a deliberately messy customer and order dataset containing missing values, inconsistent names, emails, phone numbers, cities, order statuses, duplicate records, and logically inconsistent order information.

The complete project is implemented in **MySQL** and is provided as a single SQL file containing the database creation, dataset, cleaning operations, transformations, validation queries, and analysis.

---

## 🎯 Objective

The main objective of this project is to practice SQL techniques for handling real-world data-quality problems.

The project focuses on:

* Identifying missing values
* Cleaning customer information
* Standardizing text values
* Cleaning email addresses
* Cleaning phone numbers
* Detecting duplicate records
* Transforming product information
* Standardizing order statuses
* Handling inconsistent data
* Applying conditional logic
* Validating cleaned data
* Performing basic order and sales analysis

---

## 🛠️ Technologies Used

* **MySQL 8.0+**
* **SQL**
* MySQL Workbench

---

## 📊 Dataset

The project contains **1,020 deliberately messy records** representing customer orders.

The dataset contains fields such as:

| Column          | Description               |
| --------------- | ------------------------- |
| `order_id`      | Unique order identifier   |
| `customer_name` | Customer name             |
| `email`         | Customer email            |
| `phone`         | Customer phone number     |
| `city`          | Customer city             |
| `product`       | Product name and category |
| `quantity`      | Quantity ordered          |
| `order_status`  | Current order status      |
| `order_date`    | Order date                |
| `order_total`   | Order value               |

The dataset intentionally includes inconsistent and incomplete values so that SQL cleaning techniques can be demonstrated.

---

## 🧹 Data Cleaning Tasks

### 1. Missing Value Handling

The project identifies missing values in:

* Customer names
* Email addresses
* Phone numbers
* Cities
* Quantities
* Order statuses

SQL functions such as:

```sql
COALESCE()
```

are used to handle missing information.

---

### 2. Customer Name Cleaning

Customer names are standardized using string functions such as:

```sql
TRIM()
UPPER()
LOWER()
LEFT()
SUBSTRING()
CONCAT()
```

Example:

```text
  RAJAT SINGH
```

is transformed into:

```text
Rajat Singh
```

---

### 3. Email Cleaning

The project:

* Removes unnecessary spaces
* Converts emails to lowercase
* Detects invalid email formats
* Handles missing email addresses

Example:

```text
 RAJAT123@GMAIL.COM
```

becomes:

```text
rajat123@gmail.com
```

---

### 4. Phone Number Cleaning

Unnecessary characters are removed from phone numbers using:

```sql
REGEXP_REPLACE()
```

Examples of messy values:

```text
+91-98765-43210
(987) 654-3210
+91 9876543210
```

are transformed into standardized 10-digit phone values where possible.

---

### 5. City Standardization

Different representations of the same city are standardized.

For example:

```text
Bangalore
Bengaluru
```

are standardized as:

```text
Bengaluru
```

Similarly:

```text
Delhi
New Delhi
```

are standardized as:

```text
Delhi
```

---

### 6. Product Transformation

The original product field contains both product name and category.

Example:

```text
Laptop - Electronics
```

is transformed into:

```text
Product Name: Laptop
Category: Electronics
```

This uses:

```sql
SUBSTRING_INDEX()
TRIM()
```

---

### 7. Order Status Standardization

Different versions of order statuses are standardized.

Examples:

```text
completed
COMPLETE
Completed
```

become:

```text
Completed
```

Other standardized statuses include:

* Completed
* Pending
* Cancelled
* Shipped
* Returned
* Unknown

---

## 🔍 Duplicate Detection

The project identifies duplicate records using combinations such as:

```sql
customer_name
email
product_name
order_date
```

Example query:

```sql
SELECT
    clean_customer_name,
    clean_email,
    product_name,
    order_date,
    COUNT(*) AS duplicate_count
FROM orders_clean
GROUP BY
    clean_customer_name,
    clean_email,
    product_name,
    order_date
HAVING COUNT(*) > 1;
```

---

## ⚠️ Data Inconsistency Detection

Conditional logic is used to identify suspicious records.

For example:

```text
Completed Order With Zero Quantity
```

or:

```text
Invalid/Missing Email
```

or:

```text
Unknown Status
```

A `data_quality_flag` column is created to classify records.

Possible values include:

```text
OK
Invalid/Missing Email
Invalid/Missing Phone
Completed Order With Zero Quantity
Check Cancelled Order
Unknown Status
Unknown City
Unknown Status
```

---

## 📈 Data Analysis

After cleaning the data, SQL is used to analyze:

### Order Status

```sql
SELECT
    clean_status,
    COUNT(*) AS total_orders,
    SUM(calculated_total) AS total_value
FROM orders_clean
GROUP BY clean_status;
```

### Product Category

The project calculates:

* Number of orders
* Units sold
* Sales value

for each product category.

### City Analysis

Orders and sales are analyzed by standardized city.

### Product Analysis

The project identifies:

* Most ordered products
* Units sold
* Revenue generated

---

## 🗃️ Database Structure

The project creates the following objects:

```text
mini_project_03
│
├── orders_raw
│   └── Original messy dataset
│
├── orders_clean
│   └── Cleaned and transformed dataset
│
└── vw_clean_orders
    └── Cleaned data view
```

---

## 🚀 How to Run the Project

### Step 1 — Install MySQL

Install:

**MySQL 8.0+**

You can use MySQL Workbench to execute the project.

---

### Step 2 — Clone the Repository

```bash
git clone https://github.com/your-username/sql-data-cleaning-mini-project.git
```

Move into the project folder:

```bash
cd sql-data-cleaning-mini-project
```

---

### Step 3 — Open the SQL File

Open:

```text
mini_project_3_data_cleaning_transformation.sql
```

in MySQL Workbench.

---

### Step 4 — Execute the SQL File

Run the complete SQL script.

The script automatically creates:

```text
mini_project_03
```

and the required tables and view.

---

### Step 5 — Select the Database

```sql
USE mini_project_03;
```

---

### Step 6 — View the Raw Dataset

```sql
SELECT *
FROM orders_raw
LIMIT 100;
```

---

### Step 7 — View the Cleaned Dataset

```sql
SELECT *
FROM orders_clean
LIMIT 100;
```

or:

```sql
SELECT *
FROM vw_clean_orders
LIMIT 100;
```

---

## 📁 Project Structure

```text
sql-data-cleaning-mini-project/
│
├── mini_project_3_data_cleaning_transformation.sql
│
└── README.md
```

---

## 💡 SQL Concepts Demonstrated

This project covers the following SQL concepts:

* `CREATE DATABASE`
* `CREATE TABLE`
* `INSERT`
* `SELECT`
* `UPDATE`
* `CASE`
* `WHERE`
* `GROUP BY`
* `HAVING`
* `ORDER BY`
* `COUNT()`
* `SUM()`
* `COALESCE()`
* `TRIM()`
* `LOWER()`
* `UPPER()`
* `LEFT()`
* `SUBSTRING()`
* `CONCAT()`
* `SUBSTRING_INDEX()`
* `REGEXP_REPLACE()`
* `REGEXP`
* `NULL` handling
* Duplicate detection
* Views
* Data validation
* Conditional logic
* Data standardization

---

## 📋 Project Workflow

```text
Raw Data
   ↓
Data Profiling
   ↓
Missing Value Detection
   ↓
Name Cleaning
   ↓
Email Cleaning
   ↓
Phone Cleaning
   ↓
City Standardization
   ↓
Product Transformation
   ↓
Status Standardization
   ↓
Duplicate Detection
   ↓
Data Inconsistency Detection
   ↓
Data Validation
   ↓
Clean Dataset
   ↓
Order & Sales Analysis
```

---

## ✅ Project Submission Checklist

* [x] Database created
* [x] Large dataset included
* [x] Missing values handled
* [x] Customer names standardized
* [x] Emails cleaned
* [x] Phone numbers cleaned
* [x] Duplicate records identified
* [x] Product fields transformed
* [x] Order statuses standardized
* [x] Data inconsistencies identified
* [x] Conditional logic implemented
* [x] Cleaned data view created
* [x] Final validation queries included
* [x] Order analysis included
* [x] Product analysis included
* [x] City analysis included

---

## 🎓 Learning Outcomes

After completing this project, you will have practical experience in using SQL to prepare messy data for analysis.

You will understand how to:

1. Profile raw data
2. Identify data-quality issues
3. Handle NULL values
4. Standardize inconsistent text
5. Clean contact information
6. Detect duplicate records
7. Transform existing columns
8. Apply conditional logic
9. Validate cleaned data
10. Prepare data for further analysis

---

## 👨‍💻 Author

**Rajat Singh**

Data Analyst | Business Analyst | Data & Business Analytics

Skills demonstrated in this project:

**SQL • Data Cleaning • Data Transformation • Data Validation • Data Analysis • MySQL**
