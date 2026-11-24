DROP VIEW IF EXISTS forecast_prices;
DROP TABLE IF EXISTS calendar;
DROP TABLE IF EXISTS sell_prices;
DROP TABLE IF EXISTS validation_forecasts;

CREATE TABLE calendar (
	calendar_date	DATE NOT NULL,
	wm_yr_wk		SMALLINT NOT NULL,
	weekday			TEXT NOT NULL,
	wday			SMALLINT NOT NULL,
	calendar_month	SMALLINT NOT NULL,
	calendar_year	SMALLINT NOT NULL,
	d				TEXT NOT NULL,
	event_name_1	TEXT,
	event_type_1	TEXT,
	event_name_2	TEXT,
	event_type_2	TEXT,
	snap_CA			BOOLEAN NOT NULL,
	snap_TX			BOOLEAN NOT NULL,
	snap_WI			BOOLEAN NOT NULL
);

CREATE TABLE sell_prices (
	store_id		TEXT NOT NULL,
	item_id			TEXT NOT NULL,
	wm_yr_wk		SMALLINT NOT NULL,
	sell_price		NUMERIC
);

CREATE TABLE validation_forecasts (
	id				TEXT NOT NULL,
	item_id			TEXT NOT NULL,
	dept_id			TEXT NOT NULL,
	cat_id			TEXT NOT NULL,
	store_id		TEXT NOT NULL,
	state_id		TEXT NOT NULL,
	calendar_date	DATE NOT NULL,
	sales			NUMERIC NOT NULL,
	forecast		NUMERIC NOT NULL
);

COPY calendar
FROM '{{CALENDAR_CSV}}'
DELIMITER ','
CSV HEADER;

COPY sell_prices
FROM '{{SELL_PRICE_CSV}}'
DELIMITER ','
CSV HEADER;

COPY validation_forecasts
FROM '{{VALIDATION_FORECASTS_CSV}}'
DELIMITER ','
CSV HEADER;