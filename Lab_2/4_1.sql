WITH source AS (
    SELECT
        b.booking_id,
        b.price,
        b.booking_status,
        b.booking_date,
        t.tariff_name
    FROM bookings b
    JOIN tariffs t ON t.tariff_id = b.tariff_id
    JOIN flights f ON f.flight_id = b.flight_id
),
valid AS (
    SELECT
        booking_id,
        price,
        to_char(booking_date, 'YYYY-MM') AS month,
        tariff_name
    FROM source
    WHERE booking_status IN ('completed', 'confirmed')
),
by_tariff AS (
    SELECT
        month,
        tariff_name,
        count(*)          AS bookings_cnt,
        sum(price)        AS revenue,
        round(avg(price), 2) AS avg_check
    FROM valid
    GROUP BY month, tariff_name
)
SELECT
    month,
    tariff_name,
    bookings_cnt,
    revenue,
    avg_check,
    round(100.0 * revenue / sum(revenue) OVER (PARTITION BY month), 2)
        AS share_of_month_percent
FROM by_tariff
ORDER BY month, revenue DESC;