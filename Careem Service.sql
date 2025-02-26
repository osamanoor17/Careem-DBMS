-- Create a database named 'Careem'
CREATE DATABASE Careem;

-- Create 'customer' table to store customer details
CREATE TABLE customer(
    cust_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- Unique ID for each customer
    cust_Name VARCHAR(50), -- Name of the customer
    cust_ContactNo VARCHAR(50), -- Contact number of the customer
    Location VARCHAR(50) -- Location of the customer
);

-- Create 'rides' table to store ride details
CREATE TABLE rides(
    ride_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- Unique ride ID
    ride_No VARCHAR(50), -- Ride number
    cust_ID INT, -- Customer ID who booked the ride
    FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID) -- Link ride to customer
);

-- Create 'captain' table to store driver details
CREATE TABLE captain(
    capt_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- Unique ID for each captain
    capt_Name VARCHAR(50), -- Name of the captain
    capt_ContactNo VARCHAR(50), -- Contact number of the captain
    capt_lisenceNo VARCHAR(50), -- License number of the captain
    cust_ID INT, -- Link to customer (incorrect relation, ideally should link to rides or bookings)
    FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID)
);

-- Create 'booking' table to store ride bookings
CREATE TABLE booking(
    booking_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- Unique booking ID
    booking_Type ENUM('Now Booking','Later Booking'), -- Booking type (instant or scheduled)
    capt_ID INT, -- Captain assigned to the booking
    FOREIGN KEY (capt_ID) REFERENCES captain(capt_ID), -- Link to captain
    cust_ID INT, -- Customer who made the booking
    FOREIGN KEY (cust_ID) REFERENCES customer(cust_ID), -- Link to customer
    ride_ID INT, -- Ride associated with the booking
    FOREIGN KEY (ride_ID) REFERENCES rides(ride_ID) -- Link to rides
);

-- Create 'trip' table to store trip details
CREATE TABLE trip(
    trip_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- Unique trip ID
    fare_Detail VARCHAR(50), -- Fare details
    estimated_Time VARCHAR(50), -- Estimated time for the trip
    destination VARCHAR(50), -- Destination of the trip
    booking_ID INT, -- Link to booking
    FOREIGN KEY (booking_ID) REFERENCES booking(booking_ID) -- Associate trip with a booking
);

-- Create 'vehicles' table to store vehicle details
CREATE TABLE vehicles(
    vehicle_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- Unique vehicle ID
    vehicle_Model VARCHAR(50), -- Model of the vehicle
    vehicle_Type ENUM('Go Mini', 'Go+', 'Business Class', 'Rikshaw', 'Bike'), -- Type of vehicle
    booking_ID INT, -- Link to booking
    FOREIGN KEY (booking_ID) REFERENCES booking(booking_ID) -- Associate vehicle with a booking
);

-- Create 'payment' table to store payment details
CREATE TABLE payment(
    payment_ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, -- Unique payment ID
    payment_Type ENUM('Card', 'Cash'), -- Payment method
    payment_Time VARCHAR(50), -- Time of payment
    trip_ID INT, -- Link to trip
    FOREIGN KEY (trip_ID) REFERENCES trip(trip_ID) -- Associate payment with a trip
);

-- Insert sample data into 'customer' table
INSERT INTO customer(cust_ID, cust_Name, cust_ContactNo, Location)
VALUES(1, 'Zain Khan', '03002666114', "Gulshan-e-Iqbal"),
      (2, 'Syed Hamza', '03215557746', "FB Area"),
      (3, 'Osama', '03302543168', "Jahur"),
      (4, 'Taha', '03218887710', "Malir");

-- Insert sample data into 'captain' table
INSERT INTO captain(capt_ID, capt_Name, capt_ContactNo, capt_lisenceNo, cust_ID)
VALUES(1, 'Uzair', '03216543279', '2999EX1210', 1),
      (2, 'Abdullah', '03216543279', '2779YS5674', 2),
      (3, 'Malik', '03245543731', '2765TZ1223', 3),
      (4, 'Faizan', '03216543279', '1219CZ1098', 4);

-- Insert sample data into 'rides' table
INSERT INTO rides(ride_ID, ride_No, cust_ID)
VALUES(1, '1', 1),
      (2, '2', 2),
      (3, '3', 3),
      (4, '4', 4);

-- Insert sample data into 'booking' table
INSERT INTO booking(booking_ID, booking_Type, capt_ID, cust_ID, ride_ID)
VALUES(1, 'Now Booking', 1, 1, 1),
      (2, 'Now Booking', 2, 2, 2),
      (3, 'Later Booking', 3, 3, 3),
      (4, 'Now Booking', 4, 4, 4);

-- Insert sample data into 'vehicles' table
INSERT INTO vehicles(vehicle_ID, vehicle_Model, vehicle_Type, booking_ID)
VALUES(1, '2016', 'Business Class', 1),
      (2, '2013', 'Go Mini', 2),
      (3, '2020', 'Bike', 3),
      (4, '2022', 'Rikshaw', 4);

-- Insert sample data into 'trip' table
INSERT INTO trip(trip_ID, fare_Detail, estimated_Time, destination, booking_ID)
VALUES(1, 'Maximum Fare AED15','05:00 pm','Iqra University', 1),
      (2, 'Minimum Fare FED14','09:05 am','Gulberg town', 2),
      (3, 'Minimum Fare VTD13','02:10 pm','Saddar', 3),
      (4, 'Maximum Fare AX05','04:30 pm','Power House', 4);

-- Insert sample data into 'payment' table
INSERT INTO payment(payment_ID, payment_Type, payment_Time, trip_ID)
VALUES(1, 'Card', '07:00 pm', 1),
      (2, 'Card', '11:00 am', 2),
      (3, 'Cash', '03:00 pm', 3),
      (4, 'Cash', '06:00 pm', 4);

-- Retrieve customer and trip details
SELECT c.*, t.* FROM customer c, trip t WHERE c.cust_ID = t.trip_ID;

-- Retrieve customer, trip, and payment details
SELECT c.*, t.fare_Detail, t.estimated_Time, p.payment_ID, p.payment_Type, p.payment_time
FROM customer c, trip t, payment p
WHERE c.cust_ID = t.trip_ID AND t.trip_ID = p.trip_ID;

-- Update vehicle model for a specific vehicle
UPDATE vehicles SET vehicle_Model = '2018' WHERE vehicle_ID = 1;

-- Update captain details
UPDATE captain SET capt_Name = 'Ahmed', capt_ContactNo = '0321953530' WHERE capt_ID = 3;

-- Retrieve second highest contact number in captain table
SELECT MAX(capt_ContactNo) FROM captain
WHERE capt_ContactNo < (SELECT MAX(capt_ContactNo) FROM captain);

-- Get length of customer names
SELECT CHAR_LENGTH(cust_Name) AS LengthOfName FROM customer;

-- Find position of a word in a string
SELECT INSTR("Gulshan-e-Iqbal", "Iqbal") AS MatchPosition FROM customer;

-- Convert booking type to uppercase
SELECT UCASE(booking_type) AS booking_type, UCASE(booking_ID) AS booking_ID FROM booking;

-- Retrieve customers from FB Area
SELECT cust_ID, cust_Name, cust_ContactNo FROM customer WHERE location = "FB Area";
