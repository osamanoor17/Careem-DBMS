# Careem Database Project

This project represents the database schema and queries for a ride-hailing service similar to Careem. The database is structured to manage customers, captains, rides, bookings, trips, vehicles, and payments efficiently.

## Database Creation
```sql
CREATE DATABASE Careem;
```
This command creates the database `Careem` where all tables and data will be stored.

## Tables
### 1. Customer Table
```sql
CREATE TABLE customer(
  cust_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  cust_Name VARCHAR(50),
  cust_ContactNo VARCHAR(50),
  Location VARCHAR(50)
);
```
- Stores customer details.
- `cust_ID` is the primary key with auto-increment.
- Contains customer name, contact number, and location.

### 2. Rides Table
```sql
CREATE TABLE rides(
  ride_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ride_No VARCHAR(50),
  cust_ID INT,
  FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID)
);
```
- Stores ride details.
- `cust_ID` is a foreign key referencing `customer`.

### 3. Captain Table
```sql
CREATE TABLE captain(
  capt_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  capt_Name VARCHAR(50),
  capt_ContactNo VARCHAR(50),
  capt_lisenceNo VARCHAR(50),
  cust_ID INT,
  FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID)
);
```
- Stores captain details.
- `cust_ID` is a foreign key referencing `customer`.

### 4. Booking Table
```sql
CREATE TABLE booking(
  booking_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  booking_Type ENUM('Now Booking','Later Booking'),
  capt_ID INT,
  FOREIGN KEY (capt_ID) REFERENCES captain(capt_ID),
  cust_ID INT,
  FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID),
  ride_ID INT,
  FOREIGN KEY (ride_ID) REFERENCES rides(ride_ID)
);
```
- Stores booking details, including type and references to customer, captain, and ride.

### 5. Trip Table
```sql
CREATE TABLE trip(
  trip_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  fare_Detail VARCHAR(50),
  estimated_Time VARCHAR(50),
  destination VARCHAR(50),
  booking_ID INT,
  FOREIGN KEY (booking_ID) REFERENCES booking(booking_ID)
);
```
- Stores trip-related information.
- `booking_ID` references the `booking` table.

### 6. Vehicles Table
```sql
CREATE TABLE vehicles(
  vehicle_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  vehicle_Model VARCHAR(50),
  vehicle_Type ENUM('Go Mini', 'Go+', 'Business Class', 'Rikshaw', 'Bike'),
  booking_ID INT,
  FOREIGN KEY (booking_ID) REFERENCES booking(booking_ID)
);
```
- Stores vehicle details.
- `booking_ID` references `booking`.

### 7. Payment Table
```sql
CREATE TABLE payment(
  payment_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  payment_Type ENUM('Card', 'Cash'),
  payment_Time VARCHAR(50),
  trip_ID INT,
  FOREIGN KEY (trip_ID) REFERENCES trip(trip_ID)
);
```
- Stores payment details.
- `trip_ID` references `trip`.

## Data Insertion
- Sample data is inserted into `customer`, `captain`, `rides`, `booking`, `vehicles`, `trip`, and `payment` tables.

## Queries
### Select Queries
- Retrieve all customer and trip details:
```sql
SELECT c.*, t.* FROM customer c, trip t WHERE c.cust_ID = t.trip_ID;
```
- Retrieve customer, trip, and payment details:
```sql
SELECT c.*, t.fare_Detail, t.estimated_Time, p.payment_ID, p.payment_Type, p.payment_time
FROM customer c, trip t, payment p
WHERE c.cust_ID = t.trip_ID AND t.trip_ID = p.trip_ID;
```
### Update Queries
- Update vehicle model:
```sql
UPDATE vehicles SET vehicle_Model = 2018 WHERE vehicle_ID = 1;
```
- Update captain details:
```sql
UPDATE captain SET capt_Name = 'Ahmed', capt_ContactNo = '0321953530' WHERE capt_ID = 3;
```
### Other Queries
- Find second highest contact number:
```sql
SELECT MAX(capt_ContactNo) FROM captain
WHERE capt_ContactNo < (SELECT MAX(capt_ContactNo) FROM captain);
```
- Get character length of customer name:
```sql
SELECT CHAR_LENGTH(cust_name) AS LengthOfName FROM customer;
```
- Find a substring position:
```sql
SELECT INSTR('Gulshan-e-Iqbal', 'Iqbal') AS MatchPosition FROM customer;
```
- Alter customer table:
```sql
ALTER TABLE customer ADD COLUMN city VARCHAR(50);
ALTER TABLE customer DROP COLUMN city;
```
- Convert booking type to uppercase:
```sql
SELECT UCASE(booking_type) AS booking_type, UCASE(booking_ID) AS booking_ID FROM booking;
```
- Get customers from a specific location:
```sql
SELECT cust_ID, cust_Name, cust_ContactNo FROM customer WHERE location='FB Area';
```
## License
This project is open-source and available for educational purposes.
