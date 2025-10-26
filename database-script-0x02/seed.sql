-- ==========================================================
--  AirBnB Database Seed Script
--  Author: Adesina Olagunju
--  Description: Inserts sample data into the AirBnB database
-- ==========================================================

-- NOTE: Run this script after schema.sql has been executed.

-- ==========================================================
-- USERS
-- ==========================================================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (uuid_generate_v4(), 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', '+2348011111111', 'guest'),
    (uuid_generate_v4(), 'Mary', 'Smith', 'mary.smith@example.com', 'hashed_password_2', '+2348022222222', 'host'),
    (uuid_generate_v4(), 'James', 'Brown', 'james.brown@example.com', 'hashed_password_3', '+2348033333333', 'guest'),
    (uuid_generate_v4(), 'Lucy', 'Adams', 'lucy.adams@example.com', 'hashed_password_4', '+2348044444444', 'host'),
    (uuid_generate_v4(), 'Admin', 'User', 'admin@example.com', 'hashed_password_5', NULL, 'admin');

-- ==========================================================
-- PROPERTIES
-- ==========================================================
-- Fetch host IDs dynamically (assuming the database supports subqueries)
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight)
VALUES
    (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'mary.smith@example.com'), 
     'Ocean View Apartment', 'A beautiful apartment overlooking the sea.', 'Lagos, Nigeria', 250.00),
    (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'lucy.adams@example.com'), 
     'Downtown Studio', 'Cozy studio apartment in the heart of the city.', 'Abuja, Nigeria', 150.00),
    (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'lucy.adams@example.com'), 
     'Luxury Villa', 'Spacious villa with private pool and garden.', 'Ibadan, Nigeria', 400.00);

-- ==========================================================
-- BOOKINGS
-- ==========================================================
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
    (uuid_generate_v4(), 
        (SELECT property_id FROM properties WHERE name = 'Ocean View Apartment'),
        (SELECT user_id FROM users WHERE email = 'john.doe@example.com'),
        '2025-10-10', '2025-10-15', 1250.00, 'confirmed'),

    (uuid_generate_v4(), 
        (SELECT property_id FROM properties WHERE name = 'Downtown Studio'),
        (SELECT user_id FROM users WHERE email = 'james.brown@example.com'),
        '2025-11-01', '2025-11-03', 300.00, 'pending');

-- ==========================================================
-- PAYMENTS
-- ==========================================================
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
    (uuid_generate_v4(),
        (SELECT booking_id FROM bookings WHERE status = 'confirmed'),
        1250.00, 'credit_card');

-- ==========================================================
-- REVIEWS
-- ==========================================================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
    (uuid_generate_v4(),
        (SELECT property_id FROM properties WHERE name = 'Ocean View Apartment'),
        (SELECT user_id FROM users WHERE email = 'john.doe@example.com'),
        5, 'Absolutely loved this place! Great view and clean environment.'),

    (uuid_generate_v4(),
        (SELECT property_id FROM properties WHERE name = 'Downtown Studio'),
        (SELECT user_id FROM users WHERE email = 'james.brown@example.com'),
        4, 'Nice spot for a short stay. Very central.');

-- ==========================================================
-- MESSAGES
-- ==========================================================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
    (uuid_generate_v4(),
        (SELECT user_id FROM users WHERE email = 'john.doe@example.com'),
        (SELECT user_id FROM users WHERE email = 'mary.smith@example.com'),
        'Hi Mary, is the Ocean View Apartment available next month?'),

    (uuid_generate_v4(),
        (SELECT user_id FROM users WHERE email = 'mary.smith@example.com'),
        (SELECT user_id FROM users WHERE email = 'john.doe@example.com'),
        'Hi John, yes it’s available for your selected dates!');

-- ==========================================================
-- END OF SEED SCRIPT
-- ==========================================================
