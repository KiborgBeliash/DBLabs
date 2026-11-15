BEGIN;

INSERT INTO passengers
    (passenger_id, passport_number, first_name, last_name, email, phone)
VALUES
    (21, '4520 262728', 'Roman', 'Gusev', 'gusev@example.com', '+79001122334');

INSERT INTO bookings
    (booking_id, passenger_id, flight_id, tariff_id, seat_number,
     price, booking_date, booking_status)
VALUES
    (41, 21, 19, 1, '10A',  4700.00,  '2026-11-03 10:00:00', 'created'),
    (42, 21, 23, 2, '10C',  24000.00, '2026-11-03 10:05:00', 'created');

COMMIT;


UPDATE bookings
SET booking_status = 'confirmed'
WHERE booking_id = 35;

UPDATE flights
SET status         = 'delayed',
    departure_time = departure_time + INTERVAL '2 hours',
    arrival_time   = arrival_time   + INTERVAL '2 hours',
    updated_at     = NOW()
WHERE status = 'scheduled'
  AND departure_time >= '2026-11-01'
  AND departure_time <  '2026-12-01';


DELETE FROM tariffs WHERE tariff_id = 5;

DELETE FROM passengers WHERE passenger_id = 1;

BEGIN;

DELETE FROM bookings WHERE booking_status = 'created';

SELECT count(*) AS bookings_inside_transaction FROM bookings;

ROLLBACK;

SELECT count(*) AS bookings_after_rollback FROM bookings;

SELECT booking_status, count(*) AS cnt
FROM bookings
GROUP BY booking_status
ORDER BY booking_status;