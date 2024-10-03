CREATING TABLES
**************************
-- Cars Table
CREATE TABLE Cars (
  car_id NUMBER PRIMARY KEY,
  model VARCHAR2(100),
  brand VARCHAR2(50),
  year NUMBER,
  price_per_day NUMBER
);

-- Customers Table
CREATE TABLE Customers (
  customer_id NUMBER PRIMARY KEY,
  name VARCHAR2(100),
  phone_number VARCHAR2(20),
  email VARCHAR2(100)
);

-- Rentals Table
CREATE TABLE Rentals (
  rental_id NUMBER PRIMARY KEY,
  customer_id NUMBER,
  car_id NUMBER,
  rental_start_date DATE,
  rental_end_date DATE,
  total_price NUMBER,
  CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
  CONSTRAINT fk_car FOREIGN KEY (car_id) REFERENCES Cars(car_id)
);

-- Payments Table
CREATE TABLE Payments (
  payment_id NUMBER PRIMARY KEY,
  rental_id NUMBER,
  payment_date DATE,
  amount_paid NUMBER,
  CONSTRAINT fk_rental FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id)
);



INSERTING DATA
*************************************
-- Insert Cars
INSERT INTO Cars (car_id, model, brand, year, price_per_day) 
VALUES (1, 'Model S', 'Tesla', 2022, 150);
INSERT INTO Cars (car_id, model, brand, year, price_per_day) 
VALUES (2, 'Civic', 'Honda', 2020, 60);

-- Insert Customers
INSERT INTO Customers (customer_id, name, phone_number, email)
VALUES (1, 'Alice Johnson', '123-456-7890', 'alice@example.com');
INSERT INTO Customers (customer_id, name, phone_number, email)
VALUES (2, 'Bob Smith', '987-654-3210', 'bob@example.com');

-- Insert Rentals
INSERT INTO Rentals (rental_id, customer_id, car_id, rental_start_date, rental_end_date, total_price)
VALUES (1, 1, 1, TO_DATE('2023-09-10', 'YYYY-MM-DD'), TO_DATE('2023-09-12', 'YYYY-MM-DD'), 300);

-- Insert Payments
INSERT INTO Payments (payment_id, rental_id, payment_date, amount_paid)
VALUES (1, 1, TO_DATE('2023-09-12', 'YYYY-MM-DD'), 300);


UPDATING DATA
********************

-- Update rental details
UPDATE Rentals 
SET rental_end_date = TO_DATE('2023-09-15', 'YYYY-MM-DD'), total_price = 450
WHERE rental_id = 1;

DELETING DATA
******************
-- Delete a rental record
DELETE FROM Rentals WHERE rental_id = 1;

PERFORM JOINS
***************
-- Join to get details of cars rented by a customer
SELECT Customers.name, Cars.model, Cars.brand, Rentals.rental_start_date, Rentals.rental_end_date 
FROM Customers
JOIN Rentals ON Customers.customer_id = Rentals.customer_id
JOIN Cars ON Cars.car_id = Rentals.car_id;

DDL OPERATIONS
*****************
-- Alter table to add new column for car status
ALTER TABLE Cars ADD status VARCHAR2(20) DEFAULT 'available';

DCL OPERATIONS
***************
-- Grant privileges
GRANT SELECT ON Cars TO another_user;

-- Revoke privilege
REVOKE SELECT ON Cars FROM another_user;

TCL OPERATIONS
********************
-- Transaction handling
BEGIN
  UPDATE Rentals SET total_price = total_price + 50 WHERE rental_id = 1;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;

