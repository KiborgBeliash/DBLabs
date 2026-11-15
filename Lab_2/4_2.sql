WITH profitable AS (
    SELECT b.tariff_id, b.price
    FROM bookings b
    WHERE b.booking_status IN ('completed', 'confirmed')
),
global AS (
    SELECT round(avg(price), 2) AS avg_check
    FROM profitable
)
SELECT
    t.tariff_name                                   AS class,
    CASE WHEN t.is_international THEN 'international'
         ELSE 'domestic' END                        AS scope,
    g.avg_check                                     AS global_avg_check,
    sum(p.price)                                    AS revenue
FROM profitable p
JOIN tariffs t ON t.tariff_id = p.tariff_id
CROSS JOIN global g
GROUP BY t.tariff_name, t.is_international, g.avg_check
HAVING sum(p.price) < g.avg_check
ORDER BY revenue;