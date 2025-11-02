# 0. Write Complex Queries with Joins

## Objective
Demonstrate mastery of SQL joins by writing complex queries to extract meaningful relationships from multiple tables.

## Tasks
1. **INNER JOIN:** Retrieve all bookings and the users who made those bookings.  
2. **LEFT JOIN:** Retrieve all properties and their reviews, including properties with no reviews.  
3. **FULL OUTER JOIN:** Retrieve all users and bookings, even if a user has no booking or a booking has no user.



# 1. Practice Subqueries

## Objective
Enhance SQL skills by writing both **non-correlated** and **correlated** subqueries to perform advanced data analysis.

## Tasks
1. **Non-Correlated Subquery:**  
   Retrieve all properties where the average rating is greater than 4.0.  

2. **Correlated Subquery:**  
   Retrieve all users who have made more than 3 bookings.

## How It Works
- The **non-correlated subquery** runs independently to calculate property averages and filter by rating.
- The **correlated subquery** runs once per row in the outer query, dynamically checking each user’s total bookings.





# 2. Apply Aggregations and Window Functions

## Objective
Enhance analytical SQL skills by using aggregation and window functions to analyze Airbnb data.

## Tasks
1. **Aggregation (COUNT + GROUP BY):**  
   Retrieve the total number of bookings made by each user.

2. **Window Function (RANK / ROW_NUMBER):**  
   Rank all properties based on the total number of bookings they have received.

## Explanation
- The **COUNT()** function aggregates bookings per user or property.
- The **GROUP BY** clause groups results by entity (user or property).
- The **RANK()** window function assigns ranks to properties, allowing ties for equal counts.
- Alternatively, **ROW_NUMBER()** assigns a unique rank to each property regardless of ties.


