# 5. Partitioning Large Tables

## Objective
Improve query performance on large datasets by partitioning the `Booking` table based on the `start_date` column.

## Approach
- Created a new table `Booking_Partitioned` using **RANGE partitioning** by `YEAR(start_date)`.
- Defined partitions for years 2022–2025, plus a `MAXVALUE` partition for future years.
- Tested queries filtering bookings by specific date ranges before and after partitioning.

## Performance Test

### Query Tested
```sql
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
