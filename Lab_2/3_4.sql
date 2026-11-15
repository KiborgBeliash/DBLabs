SELECT
    f.flight_id,
    f.flight_number,
    a_dep.city || ' -> ' || a_arr.city AS route,
    f.total_seats,
    (SELECT count(*)
     FROM bookings b
     WHERE b.flight_id = f.flight_id)          AS tickets_sold,
    round(100.0 * (SELECT count(*)
                   FROM bookings b
                   WHERE b.flight_id = f.flight_id) / f.total_seats, 2) AS load_percent
FROM flights f
JOIN airports a_dep ON a_dep.airport_id = f.departure_airport_id
JOIN airports a_arr ON a_arr.airport_id = f.arrival_airport_id
ORDER BY load_percent DESC;