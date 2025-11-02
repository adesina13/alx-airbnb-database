# 3. Implement Indexes for Optimization

## 🎯 Objective
Identify frequently accessed (high-usage) columns and create **indexes** to improve query performance for the Airbnb database.

Indexes help the database quickly locate data without scanning entire tables, especially in queries with **WHERE**, **JOIN**, and **ORDER BY** clauses.

---

## 🧩 Step 1: Identify High-Usage Columns

Based on common query patterns and relationships in the Airbnb schema:

| Table     | High-Usage Columns       | Usage Context                               |
|------------|--------------------------|---------------------------------------------|
| **User**      | `email`, `user_id`         | Used in login lookups and joins with Booking |
| **Booking**   | `user_id`, `property_id`, `start_date`, `end_date` | Used in joins, filters, and date range queries |
| **Property**  | `city`, `host_id`, `property_id` | Used in searches and joins with Booking/Review |

---

## ⚙️ Step 2: Create Indexes

```sql
-- ==============================================================
-- Project: Unleashing Advanced Querying Power
-- Task 3: Implement Indexes for Optimization
-- Author: Adesina Olagunju
-- Repository: alx-airbnb-database
-- ==============================================================

-- USER table indexes
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_id ON User(user_id);

-- BOOKING table indexes
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- PROPERTY table indexes
CREATE INDEX idx_property_city ON Property(city);
CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_id ON Property(property_id);



🧮 Step 3: Measure Performance (Before & After Indexing)

Use EXPLAIN or EXPLAIN ANALYZE to compare query execution plans and times.

🕒 Before Indexing
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE user_id = 'USR123';


Result (example):

Seq Scan on Booking  (cost=0.00..1350.00 rows=500 width=80)
Execution time: 120.45 ms

⚡ After Indexing
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE user_id = 'USR123';


Result (example):

Index Scan using idx_booking_user_id on Booking  (cost=0.42..12.85 rows=5 width=80)
Execution time: 2.17 ms


✅ Improvement: Query speed improved from ~120 ms → 2 ms by replacing a sequential scan with an index scan.

📊 Step 4: Evaluate and Monitor

Use tools like:

SHOW INDEX FROM Booking;
SHOW INDEX FROM Property;


and monitor with:

SHOW PROFILE;
EXPLAIN ANALYZE <query>;


Remove unnecessary indexes if:

They are never used (check via SHOW INDEX statistics).

They slow down INSERT or UPDATE performance due to maintenance overhead.

🧾 Summary
Table	Index Name	Purpose
User	idx_user_email	Speed up login lookups
Booking	idx_booking_user_id	Optimize joins and user queries
Booking	idx_booking_dates	Improve date range searches
Property	idx_property_city	Speed up property searches by city
📘 Notes

Indexing is a trade-off: faster reads but slower writes.

Always test index effectiveness using EXPLAIN ANALYZE.

Periodically review and adjust indexes based on query frequency.

🧑‍💻 Author

Adesina Olagunju