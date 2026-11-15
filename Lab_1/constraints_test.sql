-- уникальность
BEGIN;

INSERT INTO airports (country, city, airport_code)
VALUES ('Russia', 'Moscow', 'SVO');

ROLLBACK;

-- пустое добав
BEGIN;

INSERT INTO passengers (
    passport_number,
    first_name,
    last_name,
    email
) VALUES (
    '9999 000111',
    'Test',
    'NoPhone',
    'nophone@example.com'
);

ROLLBACK;

-- пров чек время
BEGIN;

INSERT INTO flights (
    flight_number,
    departure_airport_id,
    arrival_airport_id,
    departure_time,
    arrival_time,
    total_seats
) VALUES (
    'SU999',
    1,
    2,
    '2026-10-10 12:00:00',
    '2026-10-10 11:00:00',
    100
);

ROLLBACK;

-- чек цены
BEGIN;

INSERT INTO bookings (
    passenger_id,
    flight_id,
    tariff_id,
    seat_number,
    price
) VALUES (
    1,
    1,
    1,
    '99F',
    -100.00
);

ROLLBACK;

-- наруш юник
BEGIN;

INSERT INTO bookings (
    passenger_id,
    flight_id,
    tariff_id,
    seat_number,
    price
) VALUES (
    2,
    1,
    1,
    '12A',
    5000.00
);

ROLLBACK;

-- наруш ключа
BEGIN;

INSERT INTO bookings (
    passenger_id,
    flight_id,
    tariff_id,
    seat_number,
    price
) VALUES (
    1,
    999,
    1,
    '10A',
    5000.00
);

ROLLBACK;