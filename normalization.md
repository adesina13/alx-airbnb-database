# 🧾 Normalization – AirBnB Database Design

## 🎯 Objective
To ensure the AirBnB database schema adheres to the principles of **Third Normal Form (3NF)** — eliminating redundancy, ensuring data integrity, and maintaining scalability.

---

## 🧩 Step 1: Identify the Entities

The database consists of the following entities:

1. **User**
2. **Property**
3. **Booking**
4. **Payment**
5. **Review**
6. **Message**

---

## 🧱 Step 2: Check Normalization by Normal Form

We will verify normalization **progressively** — from 1NF → 2NF → 3NF.

---

### **1️⃣ First Normal Form (1NF)**

**Rule:**  
- Each table has a **primary key**.  
- Each field contains **atomic (indivisible)** values.  
- There are **no repeating groups or arrays**.

**Verification:**
- All tables have primary keys (`*_id`).
- All attributes store atomic values (no multiple emails, lists, or arrays).
- No repeating groups exist.

✅ **All tables satisfy 1NF.**

---

### **2️⃣ Second Normal Form (2NF)**

**Rule:**  
- The database must already be in 1NF.  
- All **non-key attributes** must depend on the **whole primary key**, not a part of it (applies mainly when a composite key is used).

**Verification:**
- Every table has a **single-column primary key (UUID)** — no composite keys.  
- Therefore, all non-key attributes depend on the whole key by definition.

✅ **All tables satisfy 2NF.**

---

### **3️⃣ Third Normal Form (3NF)**

**Rule:**  
- The database must be in 2NF.  
- There should be **no transitive dependency** (non-key attributes must depend only on the primary key, not on another non-key attribute).

**Check Each Table:**

| Table | Dependency Check | Normalization Decision |
|--------|------------------|------------------------|
| **User** | All attributes (name, email, password_hash, etc.) depend directly on `user_id`. | ✅ Already in 3NF |
| **Property** | Attributes depend on `property_id`. `host_id` is a valid foreign key to `User`. | ✅ Already in 3NF |
| **Booking** | Attributes (dates, total_price, status) depend only on `booking_id`. No transitive dependency. | ✅ Already in 3NF |
| **Payment** | Attributes (amount, payment_date, method) depend only on `payment_id`. `booking_id` is a foreign key. | ✅ Already in 3NF |
| **Review** | Attributes (rating, comment, created_at) depend on `review_id`. No transitive dependency. | ✅ Already in 3NF |
| **Message** | Attributes (sender_id, recipient_id, message_body, sent_at) depend on `message_id`. | ✅ Already in 3NF |

✅ **All tables satisfy 3NF.**

---

## 🔍 Step 3: Eliminate Redundancies or Violations

After review:
- No repeating or derived data is stored.
- No attribute depends on another non-key attribute.
- Foreign keys are properly normalized (linking related entities instead of embedding data).
- ENUMs (`role`, `status`, `payment_method`) are acceptable in this context since they store fixed, limited sets of values.

No modification was required — the schema is already optimized and adheres to **3NF**.

---

## ✅ Step 4: Summary of Normalization

| Normal Form | Requirement | Status |
|--------------|--------------|---------|
| 1NF | Atomic values and unique rows | ✅ Passed |
| 2NF | No partial dependency | ✅ Passed |
| 3NF | No transitive dependency | ✅ Passed |

---

## 📘 Conclusion

The AirBnB database design meets all normalization criteria up to **Third Normal Form (3NF)**.  
It ensures:
- Minimal redundancy  
- High data integrity  
- Clear relational structure  
- Ease of future scaling and maintenance

---

### 🗂️ File Structure for Submission

```
alx-airbnb-database/
│
├── ERD/
│   └── airbnb_erd.drawio
│
└── normalization.md   ✅
```