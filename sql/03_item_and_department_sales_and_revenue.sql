WITH sales_summary AS (
    SELECT
        CASE
            WHEN GROUPING(item_id) = 1 THEN NULL
            ELSE item_id
        END AS item_id,
        CASE
            WHEN GROUPING(dept_id) = 1 THEN NULL
            ELSE dept_id
        END AS dept_id,
        GROUPING(item_id) AS item_grouped,
        GROUPING(dept_id) AS dept_grouped,
        SUM(sales) AS actual_sales,
        SUM(forecast) AS forecast_sales,
        SUM(sales * sell_price) AS actual_revenue,
        SUM(forecast * sell_price) AS forecast_revenue
    FROM forecast_prices
    GROUP BY GROUPING SETS (
        (item_id),
        (dept_id),
        ()
    )
)
SELECT
    CASE
        WHEN item_grouped = 0 THEN 'ITEM'
        WHEN dept_grouped = 0 THEN 'DEPARTMENT'
        ELSE 'OVERALL'
    END AS group_type,
    item_id,
    dept_id,
    actual_sales,
    ROUND(forecast_sales, 0),
	TO_CHAR(
	    ROUND(
	        (forecast_sales - actual_sales)
	        / NULLIF(actual_sales, 0) * 100,
	        2
		),
		'FM999,999,990.00%'
    ) AS sales_percent_error,
    TO_CHAR(actual_revenue, 'FM$999,999,999,999,990.00') AS actual_revenue,
    TO_CHAR(forecast_revenue, 'FM$999,999,999,999,990.00') AS forecast_revenue,
	TO_CHAR(
	    ROUND(
	        (forecast_revenue - actual_revenue)
	        / NULLIF(actual_revenue, 0) * 100,
	        2
	    ),
	    'FM999,999,990.00%'
    ) AS revenue_percent_error
FROM sales_summary
ORDER BY
    CASE
        WHEN item_grouped = 0 THEN 1
        WHEN dept_grouped = 0 THEN 2
        ELSE 3
    END,
    item_id,
    dept_id;