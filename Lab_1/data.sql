INSERT INTO airports (airport_id, country, city, airport_code) VALUES
(1, 'Russia', 'Moscow', 'SVO'),
(2, 'Russia', 'Saint Petersburg', 'LED'),
(3, 'Kazakhstan','Almaty', 'ALA'),
(4, 'China', 'Shanghai', 'SHA'),
(5, 'Turkey', 'Istanbul', 'IST');

INSERT INTO passengers (
    passenger_id,
    passport_number,
    first_name,
    last_name,
    email,
    phone
) VALUES
(1, '4500 111111', 'Ivan', 'Ivanov', 'ivanov@gmail.com', '+79001111111'),
(2, '4501 222222', 'Maria', 'Petrova', 'petrova@gmail.com', '+78005553535'),
(3, '4502 333333', 'Petr', 'Sidorov', 'sidorov@gmail.com', '+79999999999'),
(4, '4503 444444', 'Anna', 'Kuznetsova', 'kuznetsova@gmail.com', '+79111223232'),
(5, '4504 555555', 'Dmitry', 'Sokolov', 'sokolov@gmail.com', '+76767676767');

INSERT INTO tariffs (tariff_id, tariff_name, is_international) VALUES
(1, 'Economy', FALSE),
(2, 'Economy', TRUE),
(3, 'Business', FALSE),
(4, 'Business', TRUE);

INSERT INTO flights (
    flight_id,
    flight_number,
    departure_airport_id,
    arrival_airport_id,
    departure_time,
    arrival_time,
    total_seats
) VALUES
(
    1,
    'SU100',
    1,
    2,
    '2026-10-01 09:00:00',
    '2026-10-01 10:30:00',
    150
),
(
    2,
    'SU200',
    1,
    3,
    '2026-10-02 14:00:00',
    '2026-10-02 22:00:00',
    200
),
(
    3,
    'TK120',
    5,
    1,
    '2026-10-03 18:00:00',
    '2026-10-03 23:59:00',
    180
),
(
    4,
    'CZ300',
    4,
    5,
    '2026-10-05 08:00:00',
    '2026-10-05 15:30:00',
    220
),
(
    5,
    'SU300',
    2,
    1,
    '2026-10-06 07:00:00',
    '2026-10-06 08:30:00',
    150
);

INSERT INTO bookings (
    booking_id,
    passenger_id,
    flight_id,
    tariff_id,
    seat_number,
    price,
    booking_date
) VALUES
(1, 1, 1, 1, '12A', 4500.00, '2026-09-20 12:10:00'),
(2, 2, 1, 1, '12B', 4500.00, '2026-09-20 12:15:00'),
(3, 3, 2, 2, '05C', 21000.00, '2026-09-21 09:30:00'),
(4, 4, 3, 4, '01A', 55000.00, '2026-09-22 18:45:00'),
(5, 5, 4, 2, '22D', 32000.00, '2026-09-23 10:05:00'),
(6, 1, 5, 3, '03B', 7800.00, '2026-09-24 14:20:00'),
(7, 2, 2, 2, '18F', 19500.00, '2026-09-25 16:40:00'),
(8, 3, 3, 4, '02B', 60000.00, '2026-09-25 17:00:00'),
(9, 4, 4, 2, '30A', 29000.00, '2026-09-26 08:50:00'),
(10, 5, 5, 1, '20C', 6000.00, '2026-09-26 09:10:00');


SELECT setval('airports_airport_id_seq', (SELECT MAX(airport_id) FROM airports));
SELECT setval('passengers_passenger_id_seq', (SELECT MAX(passenger_id) FROM passengers));
SELECT setval('tariffs_tariff_id_seq', (SELECT MAX(tariff_id) FROM tariffs));
SELECT setval('flights_flight_id_seq', (SELECT MAX(flight_id) FROM flights));
SELECT setval('bookings_booking_id_seq', (SELECT MAX(booking_id) FROM bookings));