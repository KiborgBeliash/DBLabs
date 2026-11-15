SELECT
    to_char(booking_date, 'YYYY-MM')                          AS month,
    count(*)                                                  AS bookings_total,
    count(*) FILTER (WHERE booking_status = 'completed')      AS bookings_completed,
    coalesce(sum(price) FILTER (WHERE booking_status = 'completed'), 0) AS revenue,
    round(avg(price) FILTER (WHERE booking_status = 'completed'), 2)    AS avg_check,
    min(price)                                                AS min_price,
    max(price)                                                AS max_price
FROM bookings
GROUP BY to_char(booking_date, 'YYYY-MM')
ORDER BY month;


SELECT
    t.tariff_name,
    count(b.booking_id) AS bookings_cnt,
    sum(b.price)        AS revenue
FROM tariffs t
JOIN bookings b ON b.tariff_id = t.tariff_id
WHERE b.booking_status <> 'cancelled'
GROUP BY t.tariff_name
HAVING sum(b.price) > 100000
ORDER BY revenue DESC;


SELECT
    CASE WHEN t.is_international THEN 'international'
         ELSE 'domestic' END   AS flight_type,
    count(*)                   AS bookings_cnt,
    sum(b.price)               AS revenue,
    round(avg(b.price), 2)     AS avg_check,
    max(b.price)               AS max_price
FROM bookings b
JOIN tariffs t ON t.tariff_id = b.tariff_id
WHERE b.booking_status <> 'cancelled'
GROUP BY CASE WHEN t.is_international THEN 'international'
              ELSE 'domestic' END
ORDER BY flight_type;