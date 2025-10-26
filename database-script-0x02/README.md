# 🌱 AirBnB Database Seed Script

## 📋 Overview
This directory contains SQL statements to **populate the AirBnB database** with sample data for testing and demonstration purposes.

---

## 📂 Files
- **seed.sql** → Inserts sample data into all tables.  
- **README.md** → Documentation for the seed script.

---

## 🧱 Tables Populated
1. `users` – 5 sample users (guests, hosts, admin)
2. `properties` – 3 sample properties (owned by hosts)
3. `bookings` – 2 bookings (one confirmed, one pending)
4. `payments` – 1 sample payment linked to a booking
5. `reviews` – 2 reviews (ratings and comments)
6. `messages` – 2 messages (guest ↔ host communication)

---

## ⚙️ How to Run
Make sure the schema has been created first (`schema.sql`).

Then execute the seed file in PostgreSQL:
```bash
psql -U <username> -d airbnb_db -f seed.sql
