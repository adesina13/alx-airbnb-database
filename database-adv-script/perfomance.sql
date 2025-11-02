-- ==============================================================
-- Project: Unleashing Advanced Querying Power
-- Task 4: Optimize Complex Queries
-- Author: Adesina Olagunju
-- Repository: alx-airbnb-database
-- ==============================================================

-- ==============================================================
-- 1️⃣ INITIAL (UNOPTIMIZED) QUERY
-- ==============================================================
-- Objective: Retrieve all bookings with user details, property details, and payment info.

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.title AS property_name,
    p.city,
    pay.payment_id,
    pay.amount,
    pay.status
FROM Booking AS b
JOIN User AS u
    ON b.user_id = u.user_id
JOIN Property AS p
    ON b.property_id = p.property_id
LEFT JOIN Payment AS pay
    ON b.booking_id = pay.booking_id
WHERE b.start_date IS NOT NULL
AND p.city IS NOT NULL
ORDER BY b.start_date DESC;

-- 🕒 Expected Performance Issue:
-- - Still returns all data (minimal filtering)
-- - No proper indexes, leading to full table scans
-- - ORDER BY on large data sets without index


-- ==============================================================
-- 2️⃣ OPTIMIZED QUERY
-- ==============================================================

-- Add indexes to improve performance
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_start_date ON Booking(start_date);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON Payment(booking_id);

-- Refactored optimized query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    p.title AS property_name,
    p.city,
    pay.amount,
    pay.status
FROM Booking AS b
JOIN User AS u
    ON b.user_id = u.user_id
JOIN Property AS p
    ON b.property_id = p.property_id
LEFT JOIN Payment AS pay
    ON b.booking_id = pay.booking_id
WHERE b.start_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
AND pay.status = 'completed'
ORDER BY b.start_date DESC
LIMIT 100;

-- ✅ Improvements:
-- - Uses WHERE filters to reduce data volume
-- - AND condition ensures logical filtering
-- - Indexes allow faster joins and sorting
