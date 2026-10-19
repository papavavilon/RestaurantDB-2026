USE restaurantdb_denys_2026;

-- 1. All tables in the restaurant, including their restaurant and capacity.
SELECT rt.tableID, rt.tableNumber, rt.capacity, r.name AS restaurantName
FROM RestaurantTable AS rt
JOIN Restaurant AS r ON r.restaurantID = rt.restaurantID
ORDER BY r.name, rt.tableNumber;

-- 2. Bookings for one customer in chronological order. Change 1 to another customerID.
SET @customer_id = 1;
SELECT b.bookingID, b.startAt, b.endAt, b.guestCount,
       rt.tableNumber, r.name AS restaurantName
FROM Booking AS b
JOIN RestaurantTable AS rt ON rt.tableID = b.tableID
JOIN Restaurant AS r ON r.restaurantID = rt.restaurantID
WHERE b.customerID = @customer_id
ORDER BY b.startAt;

-- 3. Bookings for one table on a given date, including customer details.
-- For demonstration, table 2 has two bookings on 2026-10-23.
SET @table_id = 2;
SET @booking_date = '2026-10-23';
SELECT b.bookingID, rt.tableNumber, b.startAt, b.endAt,
       b.guestCount, c.customerID, c.firstName, c.lastName, c.phone
FROM Booking AS b
JOIN RestaurantTable AS rt ON rt.tableID = b.tableID
JOIN Customer AS c ON c.customerID = b.customerID
WHERE b.tableID = @table_id
  AND b.startAt >= @booking_date
  AND b.startAt < DATE_ADD(@booking_date, INTERVAL 1 DAY)
ORDER BY b.startAt;
