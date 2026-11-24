WITH revenue_summary AS (
    SELECT
        CASE
            WHEN GROUPING(store_id) = 1 THEN NULL
            ELSE store_id
        END AS store_id,
        CASE
            WHEN GROUPING(state_id) = 1 THEN NULL
            ELSE state_id
        END AS state_id,
        GROUPING(store_id) AS store_grouped,
        GROUPING(state_id) AS state_grouped,
        SUM(sales * sell_price) AS actual_revenue,
        SUM(forecast * sell_price) AS forecast_revenue
    FROM forecast_prices
    GROUP BY GROUPING SETS (
        (store_id),
        (state_id),
        ()
    )
)
SELECT
    CASE
        WHEN store_grouped = 0 THEN 'STORE'
        WHEN state_grouped = 0 THEN 'STATE'
        ELSE 'OVERALL'
    END AS group_type,
    store_id,
    state_id,
    ROUND(actual_revenue, 2) AS actual_revenue,
    ROUND(forecast_revenue, 2) AS forecast_revenue,
    ROUND(
        (forecast_revenue - actual_revenue)
        / NULLIF(actual_revenue, 0) * 100,
        2
    ) AS percent_error
FROM revenue_summary
ORDER BY
    CASE
        WHEN store_grouped = 0 THEN 1
        WHEN state_grouped = 0 THEN 2
        ELSE 3
    END,
    store_id,
    state_id;