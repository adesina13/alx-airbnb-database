-- ==============================================================
-- Project: Unleashing Advanced Querying Power
-- Task 0: Write Complex Queries with Joins
-- Author: Adesina Olagunju
-- Repository: alx-airbnb-database
-- ==============================================================

-- 1️⃣ INNER JOIN: Retrieve all bookings and the respective users who made those bookings
--    This query joins the Booking and User tables where user_id matches,
--    showing only bookings that are linked to an existing user.

SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM Booking AS b
INNER JOIN User AS u
    ON b.user_id = u.user_id
ORDER BY b.start_date DESC;



-- 2️⃣ LEFT JOIN: Retrieve all properties and their reviews,
--    including properties that have no reviews.

SELECT
    p.property_id,
    p.title AS property_name,
    p.city,
    r.review_id,
    r.user_id AS reviewer_id,
    r.rating,
    r.comment
FROM Property AS p
LEFT JOIN Review AS r
    ON p.property_id = r.property_id
ORDER BY p.property_id;



-- 3️⃣ FULL OUTER JOIN: Retrieve all users and all bookings,
--    even if a user has no booking or a booking is not linked to a user.

-- ⚠️ Note: Some SQL engines (like MySQL) do not directly support FULL OUTER JOIN.
-- In that case, we can simulate it using UNION of LEFT and RIGHT JOINs.

-- ✅ Generic FULL OUTER JOIN (PostgreSQL-compatible)
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM User AS u
FULL OUTER JOIN Booking AS b
    ON u.user_id = b.user_id
ORDER BY u.user_id;


-- ✅ MySQL-compatible alternative:
-- SELECT
--     u.user_id,
--     u.first_name,
--     u.last_name,
--     b.booking_id,
--     b.property_id,
--     b.start_date,
--     b.end_date
-- FROM User AS u
-- LEFT JOIN Booking AS b ON u.user_id = b.user_id
-- UNION
-- SELECT
--     u.user_id,
--     u.first_name,
--     u.last_name,
--     b.booking_id,
--     b.property_id,
--     b.start_date,
--     b.end_date
-- FROM User AS u
-- RIGHT JOIN Booking AS b ON u.user_id = b.user_id
-- ORDER BY user_id;
