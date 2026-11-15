SELECT
    p.passenger_id,
    p.last_name,
    p.first_name
FROM passengers p
WHERE EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.passenger_id = p.passenger_id
      AND b.booking_status = 'cancelled'
)
ORDER BY p.last_name;