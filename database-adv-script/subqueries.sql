-- ==============================================================
-- Project: Unleashing Advanced Querying Power
-- Task 1: Practice Subqueries
-- Author: Adesina Olagunju
-- Repository: alx-airbnb-database
-- ==============================================================


-- 1️⃣ Non-Correlated Subquery:
-- Find all properties where the average rating is greater than 4.0.
-- The subquery first calculates the average rating per property,
-- then the outer query retrieves properties that meet the threshold.

SELECT 
    p.property_id,
    p.title AS property_name,
    p.city,
    AVG(r.rating) AS average_rating
FROM Property AS p
JOIN Review AS r 
    ON p.property_id = r.property_id
GROUP BY p.property_id, p.title, p.city
HAVING AVG(r.rating) > 4.0
ORDER BY average_rating DESC;

-- Alternatively, using a subquery explicitly:

SELECT 
    p.property_id,
    p.title AS property_name,
    p.city
FROM Property AS p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM Review AS r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);



-- 2️⃣ Correlated Subquery:
-- Find all users who have made more than 3 bookings.
-- The subquery counts bookings for each user and compares it dynamically.

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    (
        SELECT COUNT(*) 
        FROM Booking AS b
        WHERE b.user_id = u.user_id
    ) AS total_bookings
FROM User AS u
WHERE (
    SELECT COUNT(*) 
    FROM Booking AS b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY total_bookings DESC;
