DROP VIEW IF EXISTS forecast_prices;

CREATE VIEW forecast_prices AS
SELECT
    vf.*,
    sp.sell_prices
FROM validation_forecasts vf
LEFT JOIN calendar c
    ON vf.date = c.date
LEFT JOIN sell_prices sp
    ON vf.item_id = sp.item_id
    AND vf.store_id = sp.store_id
    AND c.wm_yr_wk = sp.wm_yr_wk;