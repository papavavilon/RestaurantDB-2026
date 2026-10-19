# RestaurantDB — individual database assignment

A restaurant booking database. The booking application itself is outside the scope of this assignment.

## Deliverables

- ER diagram and RDM diagram: add `RestaurantDB_FigJam_ER.png` and `RestaurantDB_FigJam_RDM.png` to this repository.
- `restaurantdb.sql`: creates the isolated `restaurantdb_denys_2026` database and inserts sample data.
- `required_queries.sql`: the three requested SELECT queries.

## How to run in XAMPP

1. Start Apache and MySQL in XAMPP. Open `http://localhost/phpmyadmin`.
2. Select **Import**, choose `restaurantdb.sql`, and click **Import / Go**. The script creates its own database; you don't need to create one manually.
3. Select `restaurantdb_denys_2026` in the left sidebar and check that Restaurant, RestaurantTable, Customer and Booking are present.
4. Open **SQL**, paste `required_queries.sql`, and click **Go**. The first query should show five tables. The second should show Anna's two bookings. The third should show two bookings for table 2 on 2026-10-23.

## Design and normalization

- One restaurant has many tables. Each table belongs to exactly one restaurant.
- Each customer can make many bookings. Each booking belongs to one customer and one table. One booking is for one table.
- `restaurantID`, `tableID`, `customerID`, and `bookingID` are primary keys. The foreign keys enforce valid relationships. `UNIQUE (restaurantID, tableNumber)` prevents duplicate table numbers within a restaurant.
- 1NF: values are atomic; no lists of customers or table numbers in a field. 2NF: single-column primary keys mean there are no partial dependencies. 3NF: customer contact data lives only in Customer; restaurant contact data lives only in Restaurant; table attributes live only in RestaurantTable. Booking stores booking-specific facts and references, avoiding transitive dependencies.
- All tables use InnoDB so foreign keys work. Example telephone numbers and `example.com` addresses are fictional.

## Assumptions / limits

This database does not itself prevent overlapping bookings, check `guestCount <= capacity`, or enforce `endAt > startAt`. Those business rules would need application validation or additional database logic. The provided sample data satisfies them. The `INSERT IGNORE` records have fixed IDs to avoid duplicates during re-import into the same demo database; test in a fresh database to verify the schema independently.
