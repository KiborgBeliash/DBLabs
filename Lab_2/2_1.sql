SELECT
    b.booking_id,
    p.last_name || ' ' || p.first_name AS passenger,
    f.flight_number,
    a_dep.city                         AS departure_city,
    a_arr.city                         AS arrival_city,
    t.tariff_name,
    b.seat_number,
    b.price,
    b.booking_status,
    b.booking_date
FROM bookings b
JOIN passengers p   ON p.passenger_id = b.passenger_id
JOIN flights f      ON f.flight_id     = b.flight_id
JOIN airports a_dep ON a_dep.airport_id = f.departure_airport_id
JOIN airports a_arr ON a_arr.airport_id = f.arrival_airport_id
JOIN tariffs t      ON t.tariff_id      = b.tariff_id
ORDER BY b.booking_date;


SELECT
    f.flight_id,
    f.flight_number,
    a_dep.city || ' -> ' || a_arr.city AS route,
    f.departure_time,
    f.status                           AS flight_status
FROM flights f
JOIN airports a_dep ON a_dep.airport_id = f.departure_airport_id
JOIN airports a_arr ON a_arr.airport_id = f.arrival_airport_id
LEFT JOIN bookings b ON b.flight_id = f.flight_id
WHERE b.booking_id IS NULL
ORDER BY f.departure_time;


SELECT
    b.booking_id,
    b.price,
    b.booking_status,
    t.tariff_name,
    f.flight_number,
    a.city                             AS arrival_city,
    f.arrival_time
FROM bookings b
JOIN tariffs t  ON t.tariff_id     = b.tariff_id
JOIN flights f  ON f.flight_id     = b.flight_id
JOIN airports a ON a.airport_id    = f.arrival_airport_id
WHERE t.is_international = TRUE
  AND b.booking_status   = 'completed'
  AND a.city             = 'Moscow'
  AND f.arrival_time    >= '2026-09-01'
  AND f.arrival_time     < '2026-11-01'
ORDER BY b.price DESC;