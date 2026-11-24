DROP VIEW IF EXISTS forecast_prices;

CREATE VIEW forecast_prices AS
SELECT
    vf.*,
    sp.sell_price
FROM validation_forecasts vf
LEFT JOIN calendar c
    ON vf.calendar_date = c.calendar_date
LEFT JOIN sell_prices sp
    ON vf.item_id = sp.item_id
    AND vf.store_id = sp.store_id
    AND c.wm_yr_wk = sp.wm_yr_wk;