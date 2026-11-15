SELECT
    p.passenger_id,
    p.last_name,
    p.first_name,
    p.phone
FROM passengers p
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.passenger_id = p.passenger_id
      AND b.booking_status = 'completed'
)
ORDER BY p.passenger_id;