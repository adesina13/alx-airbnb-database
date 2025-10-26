🧩 STEP 1: Identify the Entities

From your specification, we have six main entities:

User

Property

Booking

Payment

Review

Message

Each will be represented as a rectangle in the ER diagram.

🧱 STEP 2: List Attributes per Entity
🧑‍💻 User

user_id (PK)

first_name

last_name

email (Unique)

password_hash

phone_number

role (guest / host / admin)

created_at

🏡 Property

property_id (PK)

host_id (FK → User.user_id)

name

description

location

pricepernight

created_at

updated_at

📅 Booking

booking_id (PK)

property_id (FK → Property.property_id)

user_id (FK → User.user_id)

start_date

end_date

total_price

status (pending / confirmed / canceled)

created_at

💳 Payment

payment_id (PK)

booking_id (FK → Booking.booking_id)

amount

payment_date

payment_method (credit_card / paypal / stripe)

⭐ Review

review_id (PK)

property_id (FK → Property.property_id)

user_id (FK → User.user_id)

rating (1–5)

comment

created_at

💬 Message

message_id (PK)

sender_id (FK → User.user_id)

recipient_id (FK → User.user_id)

message_body

sent_at

🔗 STEP 3: Define Relationships

Now define how entities relate to each other.

Relationship	Type	Explanation
User → Property	1 : N	A host (User) can have many Properties.
User → Booking	1 : N	A guest (User) can make many Bookings.
Property → Booking	1 : N	A Property can have many Bookings.
Booking → Payment	1 : 1	Each Booking has one Payment record.
User → Review	1 : N	A User can write many Reviews.
Property → Review	1 : N	A Property can have many Reviews.
User → Message (sender)	1 : N	A User can send many Messages.
User → Message (recipient)	1 : N	A User can receive many Messages.
🧮 STEP 4: Define Cardinalities (Crow’s Foot Notation)

In your ER diagram tool:

“1” near the parent entity

“∞” near the child entity

Example:

User (1) ──────< Property (∞)


Other examples:

Property (1) ──────< Booking (∞)
Booking (1) ──────< Payment (1)
User (1) ──────< Review (∞)
Property (1) ──────< Review (∞)

🧠 STEP 5: Apply Constraints (Optionally Annotate)

You can annotate special constraints in small text boxes or notes:

User.email → Unique

Review.rating → CHECK (1–5)

Booking.status → ENUM (pending, confirmed, canceled)

🧭 STEP 6: Create the ERD Visually (Draw.io Example Layout)

Here’s a recommended layout for your ER diagram:

     ┌──────────┐
     │   User   │
     └──────────┘
         │ 1
         │
         │
       ┌─┴────────────────────────────────────────────┐
       │                                              │
   (host_id)                                      (user_id)
   ┌────────────┐                               ┌────────────┐
   │  Property  │ 1 ───────< Booking >─────────  │  Booking  │
   └────────────┘                               └────────────┘
        │ 1                                          │ 1
        │                                             │
        │                                             │
   ┌────────────┐                                ┌────────────┐
   │   Review   │                                │  Payment   │
   └────────────┘                                └────────────┘


And separately:

User (sender) ─────< Message >───── User (recipient)