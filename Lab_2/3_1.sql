SELECT
    p.passenger_id,
    p.last_name,
    p.first_name,
    sum(b.price) AS total_spent
FROM passengers p
JOIN bookings b ON b.passenger_id = p.passenger_id
WHERE b.booking_status = 'completed'
GROUP BY p.passenger_id, p.last_name, p.first_name
HAVING sum(b.price) > (
    SELECT avg(sub.total)
    FROM (
        SELECT sum(b2.price) AS total
        FROM bookings b2
        WHERE b2.booking_status = 'completed'
        GROUP BY b2.passenger_id
    ) sub
)
ORDER BY total_spent DESC;