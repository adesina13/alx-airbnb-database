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
-- This version uses multiple joins without optimization or filtering.

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
ORDER BY b.start_date DESC;

-- 🕒 Expected Performance Issue:
-- - Full table scans on Booking and Property tables.
-- - Costly sorting due to ORDER BY on large unindexed columns.
-- - No WHERE clause filters (returns all data unnecessarily).



-- ==============================================================
-- 2️⃣ OPTIMIZED QUERY
-- ==============================================================
-- Strategy:
-- - Add indexes on join/filter columns: user_id, property_id, booking_id, start_date.
-- - Limit results to recent bookings using a WHERE clause.
-- - Use SELECT with only necessary columns (avoid SELECT *).

CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_start_date ON Booking(start_date);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON Payment(booking_id);

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
ORDER BY b.start_date DESC
LIMIT 100;

-- ✅ Expected Improvements:
-- - Reduced dataset due to WHERE filter.
-- - Index scans replace sequential scans on large tables.
-- - ORDER BY uses idx_booking_start_date for faster sorting.
-- - Only relevant columns are retrieved, reducing I/O load.
