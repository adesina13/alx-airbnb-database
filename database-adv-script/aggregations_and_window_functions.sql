-- ==============================================================
-- Project: Unleashing Advanced Querying Power
-- Task 2: Apply Aggregations and Window Functions
-- Author: Adesina Olagunju
-- Repository: alx-airbnb-database
-- ==============================================================


-- 1️⃣ Aggregation Query:
-- Find the total number of bookings made by each user.
-- This query groups all bookings by user_id and counts how many each user has made.

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM User AS u
LEFT JOIN Booking AS b
    ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;



-- 2️⃣ Window Function Query:
-- Rank properties based on the total number of bookings they have received.
-- Uses RANK() to assign ranking positions to properties.

SELECT
    p.property_id,
    p.title AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM Property AS p
LEFT JOIN Booking AS b
    ON p.property_id = b.property_id
GROUP BY p.property_id, p.title
ORDER BY booking_rank;



-- 💡 Alternative using ROW_NUMBER() if unique ranking is preferred:
-- SELECT
--     p.property_id,
--     p.title AS property_name,
--     COUNT(b.booking_id) AS total_bookings,
--     ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
-- FROM Property AS p
-- LEFT JOIN Booking AS b
--     ON p.property_id = b.property_id
-- GROUP BY p.property_id, p.title
-- ORDER BY booking_rank;
