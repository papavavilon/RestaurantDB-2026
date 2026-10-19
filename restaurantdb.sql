-- RestaurantDB individual assignment, 2026.
-- Creates an isolated database. It does not delete any existing database or tables.
CREATE DATABASE IF NOT EXISTS restaurantdb_denys_2026
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE restaurantdb_denys_2026;

CREATE TABLE IF NOT EXISTS Restaurant (
  restaurantID INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  address VARCHAR(255) NOT NULL,
  phone VARCHAR(30) NOT NULL,
  PRIMARY KEY (restaurantID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS RestaurantTable (
  tableID INT NOT NULL AUTO_INCREMENT,
  restaurantID INT NOT NULL,
  tableNumber INT NOT NULL,
  capacity INT NOT NULL,
  PRIMARY KEY (tableID),
  UNIQUE KEY unique_table_per_restaurant (restaurantID, tableNumber),
  CONSTRAINT fk_table_restaurant FOREIGN KEY (restaurantID)
    REFERENCES Restaurant (restaurantID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Customer (
  customerID INT NOT NULL AUTO_INCREMENT,
  firstName VARCHAR(80) NOT NULL,
  lastName VARCHAR(80) NOT NULL,
  phone VARCHAR(30) NOT NULL,
  email VARCHAR(160) NULL,
  PRIMARY KEY (customerID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Booking (
  bookingID INT NOT NULL AUTO_INCREMENT,
  tableID INT NOT NULL,
  customerID INT NOT NULL,
  startAt DATETIME NOT NULL,
  endAt DATETIME NOT NULL,
  guestCount INT NOT NULL,
  PRIMARY KEY (bookingID),
  KEY idx_table_start (tableID, startAt),
  KEY idx_customer_start (customerID, startAt),
  CONSTRAINT fk_booking_table FOREIGN KEY (tableID)
    REFERENCES RestaurantTable (tableID),
  CONSTRAINT fk_booking_customer FOREIGN KEY (customerID)
    REFERENCES Customer (customerID)
) ENGINE=InnoDB;

-- Example records use reserved IDs so re-importing does not duplicate the demonstration data.
INSERT IGNORE INTO Restaurant (restaurantID, name, address, phone) VALUES
  (1, 'Harbour Kitchen', 'Havnegade 12, 6700 Esbjerg', '+45 00 00 00 01');

INSERT IGNORE INTO RestaurantTable (tableID, restaurantID, tableNumber, capacity) VALUES
  (1, 1, 1, 2), (2, 1, 2, 4), (3, 1, 3, 4),
  (4, 1, 4, 6), (5, 1, 5, 8);

INSERT IGNORE INTO Customer (customerID, firstName, lastName, phone, email) VALUES
  (1, 'Anna', 'Jensen', '+45 00 00 10 01', 'anna@example.com'),
  (2, 'Frederik', 'Larsen', '+45 00 00 10 02', 'frederik@example.com'),
  (3, 'Petro', 'Koval', '+45 00 00 10 03', 'petro@example.com'),
  (4, 'Sofie', 'Nielsen', '+45 00 00 10 04', 'sofie@example.com');

-- No example bookings overlap on the same table. All guest counts fit capacity.
INSERT IGNORE INTO Booking
  (bookingID, tableID, customerID, startAt, endAt, guestCount) VALUES
  (1, 2, 1, '2026-10-23 18:00:00', '2026-10-23 20:00:00', 3),
  (2, 1, 2, '2026-10-23 19:00:00', '2026-10-23 21:00:00', 2),
  (3, 2, 3, '2026-10-23 20:30:00', '2026-10-23 22:00:00', 4),
  (4, 4, 4, '2026-10-24 18:30:00', '2026-10-24 20:30:00', 5),
  (5, 3, 1, '2026-10-25 17:00:00', '2026-10-25 19:00:00', 4),
  (6, 2, 2, '2026-10-24 12:00:00', '2026-10-24 14:00:00', 2);
