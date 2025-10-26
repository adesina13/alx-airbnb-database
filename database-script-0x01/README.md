# 🧩 AirBnB Database Schema – DDL

## 📘 Overview
This directory contains the SQL scripts defining the structure of the **AirBnB database**.  
The design follows normalization up to **Third Normal Form (3NF)** and includes all entities, attributes, constraints, and indexes.

---

## 📂 Files
- **schema.sql** → Defines all tables, constraints, and indexes.  
- **README.md** → This file (project overview).

---

## 🧱 Entities Created
1. **users**
2. **properties**
3. **bookings**
4. **payments**
5. **reviews**
6. **messages**

---

## 🧠 Key Design Details
- UUIDs used as primary keys (for scalability and uniqueness).
- Foreign key constraints ensure referential integrity.
- ENUM-like behavior implemented using `CHECK` constraints.
- Indexed columns for optimized queries:
  - `email` in `users`
  - `host_id` in `properties`
  - `property_id`, `user_id` in `bookings`
  - `booking_id` in `payments`
  - `property_id`, `user_id` in `reviews`
  - `sender_id`, `recipient_id` in `messages`

---

## ⚙️ Usage
Run the schema using PostgreSQL:
```bash
psql -U <username> -d airbnb_db -f schema.sql
