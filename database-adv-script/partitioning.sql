-- ==============================================================
-- Project: Unleashing Advanced Querying Power
-- Task 5: Partitioning Large Tables
-- Author: Adesina Olagunju
-- Repository: alx-airbnb-database
-- ==============================================================

-- =========================
-- ⚙️ 1. Drop existing partitioned table if it exists
-- =========================
DROP TABLE IF EXISTS Booking_Partitioned;

-- =========================
-- 🧩 2. Recreate Booking table with partitioning by start_date
-- =========================
CREATE TABLE Booking_Partitioned (
    booking_id      UUID PRIMARY KEY,
    user_id         UUID NOT NULL,
    property_id     UUID NOT NULL,
    start_date      DATE NOT NULL,
    end_date        DATE NOT NULL,
    total_amount    DECIMAL(10,2),
    status          VARCHAR(50),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax  VALUES LESS THAN MAXVALUE
);

-- =========================
-- 📊 3. Insert sample data (optional test)
-- =========================
INSERT INTO Booking_Partitioned (booking_id, user_id, property_id, start_date, end_date, total_amount, status)
VALUES 
('b001', 'u001', 'p001', '2022-09-15', '2022-09-20', 250.00, 'confirmed'),
('b002', 'u002', 'p002', '2023-02-11', '2023-02-16', 300.00, 'confirmed'),
('b003', 'u003', 'p003', '2024-07-05', '2024-07-12', 200.00, 'cancelled'),
('b004', 'u004', 'p004', '2025-03-10', '2025-03-18', 400.00, 'completed');

-- =========================
-- 🔍 4. Compare performance (Before vs After)
-- =========================

-- BEFORE partitioning (on original Booking table)
EXPLAIN ANALYZE 
SELECT * FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- AFTER partitioning (on Booking_Partitioned)
EXPLAIN ANALYZE 
SELECT * FROM Booking_Partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- ✅ Expected improvement:
--   - MySQL/PostgreSQL will scan only the relevant partition (p2024)
--   - Reduces I/O and execution time significantly

-- =========================
-- 🧾 5. Check partition info
-- =========================
-- SHOW CREATE TABLE Booking_Partitioned;
-- SELECT PARTITION_NAME, TABLE_ROWS
-- FROM INFORMATION_SCHEMA.PARTITIONS
-- WHERE TABLE_NAME = 'Booking_Partitioned';
