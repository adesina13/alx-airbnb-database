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
