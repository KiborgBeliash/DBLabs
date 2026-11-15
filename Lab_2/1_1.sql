BEGIN;

ALTER TABLE bookings
    ADD COLUMN booking_status VARCHAR(20) NOT NULL DEFAULT 'confirmed';

ALTER TABLE bookings
    ADD CONSTRAINT chk_booking_status
    CHECK (booking_status IN ('created', 'confirmed', 'completed', 'cancelled'));

ALTER TABLE passengers
    ADD COLUMN bonus_miles INT NOT NULL DEFAULT 0;

ALTER TABLE passengers
    ADD CONSTRAINT chk_bonus_miles_non_negative
    CHECK (bonus_miles >= 0);

COMMIT;

BEGIN;

INSERT INTO airports (airport_id, country, city, airport_code) VALUES
(6, 'Russia',  'Kazan',   'KZN'),
(7, 'Armenia', 'Yerevan', 'EVN'),
(8, 'Spain',   'Madrid',  'MAD');

INSERT INTO passengers
    (passenger_id, passport_number, first_name, last_name, email, phone) VALUES
(6,  '4505 111222', 'Elena',      'Smirnova',  'smirnova@example.com',  '+79006667788'),
(7,  '4506 222333', 'Alexey',     'Popov',     NULL,                    '+79007778899'),
(8,  '4507 333444', 'Olga',       'Vasilieva', 'vasilieva@example.com', '+79008889900'),
(9,  '4508 444555', 'Sergey',     'Mikhailov', 'mikhailov@example.com', '+79009990011'),
(10, '4509 555666', 'Natalia',    'Fedorova',  'fedorova@example.com',  '+79000001122'),
(11, '4510 666777', 'Dmitry',     'Alexeev',   'alexeev@example.com',   '+79001234567'),
(12, '4511 777888', 'Anna',       'Nikolaeva', NULL,                    '+79002345678'),
(13, '4512 888999', 'Pavel',      'Morozov',   'morozov@example.com',   '+79003456789'),
(14, '4513 999000', 'Ekaterina',  'Volkova',   'volkova@example.com',   '+79004567890'),
(15, '4514 101010', 'Andrey',     'Sokolov',   'sokolov.a@example.com', '+79005678901'),
(16, '4515 111213', 'Maria',      'Novikova',  'novikova@example.com',  '+79006789012'),
(17, '4516 141516', 'Ivan',       'Petrov',    'petrov.i@example.com',  '+79007890123'),
(18, '4517 171819', 'Svetlana',   'Orlova',    'orlova@example.com',    '+79008901234'),
(19, '4518 202122', 'Nikolai',    'Kozlov',    'kozlov@example.com',    '+79009012345'),
(20, '4519 232425', 'Tatiana',    'Lebedeva',  NULL,                    '+79000123456');

INSERT INTO tariffs (tariff_id, tariff_name, is_international) VALUES
(5, 'Premium Economy International', TRUE);

INSERT INTO flights
    (flight_id, flight_number, departure_airport_id, arrival_airport_id,
     departure_time, arrival_time, total_seats, status) VALUES

(6,  'SU101', 1, 2, '2026-09-03 08:00:00', '2026-09-03 09:30:00', 150, 'scheduled'),
(7,  'SU201', 1, 3, '2026-09-05 13:00:00', '2026-09-05 21:00:00', 200, 'delayed'),
(8,  'TK121', 5, 1, '2026-09-08 17:30:00', '2026-09-08 23:30:00', 180, 'scheduled'),
(9,  'SU301', 2, 1, '2026-09-10 07:30:00', '2026-09-10 09:00:00', 150, 'scheduled'),
(10, 'CZ301', 4, 5, '2026-09-12 09:00:00', '2026-09-12 16:30:00', 220, 'cancelled'),
(11, 'SU102', 1, 2, '2026-09-15 19:00:00', '2026-09-15 20:30:00', 150, 'scheduled'),

(12, 'SU103', 1, 2, '2026-10-08 09:00:00', '2026-10-08 10:30:00', 150, 'scheduled'),
(13, 'SU202', 1, 3, '2026-10-10 14:00:00', '2026-10-10 22:00:00', 200, 'scheduled'),
(14, 'TK122', 5, 1, '2026-10-12 18:00:00', '2026-10-12 23:59:00', 180, 'delayed'),
(15, 'SU302', 2, 1, '2026-10-14 07:00:00', '2026-10-14 08:30:00', 150, 'scheduled'),
(16, 'CZ302', 4, 5, '2026-10-16 08:00:00', '2026-10-16 15:30:00', 220, 'scheduled'),
(17, 'SU104', 1, 6, '2026-10-18 10:00:00', '2026-10-18 11:30:00', 150, 'scheduled'),
(18, 'SU600', 6, 1, '2026-10-19 12:00:00', '2026-10-19 13:30:00', 150, 'scheduled'),

(19, 'SU105', 1, 2, '2026-11-02 09:00:00', '2026-11-02 10:30:00', 150, 'scheduled'),
(20, 'SU203', 1, 3, '2026-11-05 14:00:00', '2026-11-05 22:00:00', 200, 'scheduled'),
(21, 'TK123', 5, 1, '2026-11-08 18:00:00', '2026-11-08 23:59:00', 180, 'scheduled'),
(22, 'SU303', 2, 1, '2026-11-10 07:00:00', '2026-11-10 08:30:00', 150, 'scheduled'),
(23, 'SU700', 1, 7, '2026-11-12 06:00:00', '2026-11-12 10:00:00', 180, 'scheduled'),
(24, 'SU701', 7, 1, '2026-11-14 11:00:00', '2026-11-14 15:00:00', 180, 'scheduled');

INSERT INTO bookings
    (booking_id, passenger_id, flight_id, tariff_id, seat_number,
     price, booking_date, booking_status) VALUES

(11, 1,  6,  1, '5A',  4200.00,  '2026-09-01 10:00:00', 'completed'),
(12, 6,  6,  1, '5B',  4200.00,  '2026-09-01 10:05:00', 'completed'),
(13, 20, 6,  1, '6A',  4200.00,  '2026-09-01 11:00:00', 'cancelled'),
(14, 7,  7,  2, '10C', 20500.00, '2026-09-02 09:00:00', 'completed'),
(15, 8,  7,  2, '10D', 20500.00, '2026-09-02 09:10:00', 'completed'),
(16, 9,  8,  4, '2C',  58000.00, '2026-09-03 12:00:00', 'completed'),
(17, 10, 9,  1, '8A',  6500.00,  '2026-09-05 08:00:00', 'completed'),
(18, 1,  10, 2, '15E', 31000.00, '2026-09-06 14:00:00', 'cancelled'),
(19, 11, 11, 3, '1B',  8200.00,  '2026-09-08 16:00:00', 'completed'),
(20, 6,  11, 1, '4C',  4300.00,  '2026-09-09 10:00:00', 'completed'),

(21, 1,  12, 1, '7A',  4600.00,  '2026-09-25 10:00:00', 'completed'),
(22, 13, 12, 1, '7B',  4600.00,  '2026-09-25 10:05:00', 'completed'),
(23, 2,  13, 2, '9C',  21500.00, '2026-09-28 13:00:00', 'completed'),
(24, 4,  13, 4, '1A',  59000.00, '2026-09-30 15:00:00', 'cancelled'),
(25, 14, 14, 4, '3D',  57000.00, '2026-10-01 09:00:00', 'completed'),
(26, 15, 15, 1, '11A', 6400.00,  '2026-10-02 09:00:00', 'completed'),
(27, 3,  16, 2, '20B', 30000.00, '2026-10-03 12:00:00', 'completed'),
(28, 18, 16, 2, '21F', 30000.00, '2026-10-04 12:00:00', 'completed'),
(29, 16, 17, 1, '5C',  5200.00,  '2026-10-05 10:00:00', 'completed'),
(30, 17, 18, 3, '2A',  8000.00,  '2026-10-06 10:00:00', 'completed'),

(31, 1,  19, 1, '6B',  4700.00,  '2026-10-20 10:00:00', 'confirmed'),
(32, 5,  19, 1, '6C',  4700.00,  '2026-10-20 10:05:00', 'confirmed'),
(33, 2,  19, 3, '1C',  8300.00,  '2026-10-29 10:00:00', 'confirmed'),
(34, 6,  20, 2, '12C', 22000.00, '2026-10-22 11:00:00', 'confirmed'),
(35, 8,  20, 2, '12D', 22000.00, '2026-10-22 11:05:00', 'created'),
(36, 9,  21, 4, '4A',  61000.00, '2026-10-25 12:00:00', 'confirmed'),
(37, 10, 22, 1, '9A',  6600.00,  '2026-10-26 12:00:00', 'created'),
(38, 11, 23, 2, '16A', 24000.00, '2026-10-27 12:00:00', 'confirmed'),
(39, 13, 23, 2, '16B', 24000.00, '2026-11-01 12:00:00', 'created'),
(40, 14, 23, 4, '2B',  62000.00, '2026-11-02 12:00:00', 'confirmed');

UPDATE bookings SET booking_status = 'completed'
WHERE booking_id IN (1, 2, 3, 4, 6, 7, 8, 9);

UPDATE bookings SET booking_status = 'cancelled'
WHERE booking_id IN (5, 10);

UPDATE passengers p
SET bonus_miles = c.miles
FROM (
    SELECT passenger_id, count(*) * 1000 AS miles
    FROM bookings
    WHERE booking_status = 'completed'
    GROUP BY passenger_id
) c
WHERE p.passenger_id = c.passenger_id;

INSERT INTO flight_changes
    (flight_id, changed_at, changed_field, old_value, new_value, change_reason) VALUES
(7,  '2026-08-20 09:00:00', 'departure_time', '2026-09-05 11:00:00', '2026-09-05 13:00:00', 'технические причины'),
(7,  '2026-08-20 09:00:00', 'status',         'scheduled',           'delayed',             'технические причины'),
(14, '2026-09-28 16:00:00', 'departure_time', '2026-10-12 16:00:00', '2026-10-12 18:00:00', NULL),
(14, '2026-09-28 16:00:00', 'status',         'scheduled',           'delayed',             NULL),
(10, '2026-09-01 12:00:00', 'status',         'scheduled',           'cancelled',           'погодные условия');

SELECT setval('airports_airport_id_seq',      (SELECT MAX(airport_id)   FROM airports));
SELECT setval('passengers_passenger_id_seq',  (SELECT MAX(passenger_id) FROM passengers));
SELECT setval('tariffs_tariff_id_seq',         (SELECT MAX(tariff_id)    FROM tariffs));
SELECT setval('flights_flight_id_seq',         (SELECT MAX(flight_id)    FROM flights));
SELECT setval('bookings_booking_id_seq',       (SELECT MAX(booking_id)   FROM bookings));
SELECT setval('flight_changes_change_id_seq',  (SELECT MAX(change_id)    FROM flight_changes));

COMMIT;