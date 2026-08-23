# Retail Demand Forecasting & Inventory Analytics

## Overview

This project analyzes retail demand across products and stores and
develops a machine learning forecasting pipeline to support
inventory planning decisions.

Using the M5 retail sales dataset, the project combines exploratory
data analysis, feature engineering, time-series forecasting, and
inventory analytics to identify demand patterns and translate
forecasts into actionable business recommendations.

### Project Pipeline

Data Cleaning → EDA → Feature Engineering → Forecasting →
Model Evaluation → Inventory Analytics → Tableau Dashboard

---

## Business Problem

Retailers need accurate demand forecasts to make effective inventory
decisions.

Poor forecasts can lead to:

- Stockouts and lost sales
- Excess inventory
- Inefficient allocation of inventory across stores
- Increased holding costs

The goal of this project is to determine whether historical demand,
calendar patterns, product/store characteristics, events, and pricing
can improve demand forecasts and support inventory planning.

---

## Dataset

The project uses the M5 retail sales dataset.

### Dataset characteristics

- 3,049 products
- 10 stores
- 3 states
- 7 departments
- 3 categories
- 1,913 daily observations
- Date range: January 29, 2011 – June 19, 2016

The dataset consists of:

- `sales` — historical daily unit sales
- `calendar` — dates, weekdays, events, and SNAP indicators
- `prices` — historical product/store prices

---

# 1. Exploratory Data Analysis

EDA was performed to identify the major patterns that should inform
the forecasting model.

### Key Findings

**Strong weekly seasonality**

Weekend demand was substantially higher than weekday demand, with
Saturday and Sunday showing the highest average daily sales.

**Store-level demand variation**

Demand differed substantially across stores, indicating that
location should be incorporated into forecasting.

**Category concentration**

FOODS accounted for the majority of total sales, followed by
HOUSEHOLD and HOBBIES.

**Moderate annual seasonality**

Demand generally increased toward August–September before declining
toward November–December.

**Heterogeneous event effects**

Events did not universally increase demand. Event effects varied
considerably by event type and individual event.

### Modeling Implications

These findings motivated the use of:

- Calendar features
- Historical demand lags
- Rolling demand statistics
- Product/store identifiers
- Event information
- Pricing information

---

# 2. Demand Forecasting

## Feature Engineering

The forecasting dataset incorporated:

### Calendar

- Day of week
- Week of year
- Month
- Year
- Weekend indicator

### Historical Demand

- 1-day lag
- 7-day lag
- 28-day lag
- 7-day rolling mean
- 28-day rolling mean
- 7-day rolling standard deviation

### Product & Location

- Item
- Department
- Category
- Store
- State

### Events & Pricing

- Event indicator
- Event type
- Selling price
- Price-missing indicator

All lag and rolling features were constructed using historical
information only to avoid target leakage.

---

## Forecasting Methodology

A time-based validation strategy was used rather than a random
train/test split.

### Training

Training data ended:

**March 27, 2016**

### Validation

Validation period:

**March 28, 2016 – April 24, 2016**

The validation set contained:

**42,000 observations**

Two forecasting approaches were compared:

1. Seasonal Naive
2. LightGBM

The seasonal-naive baseline predicts demand using the corresponding
day from the previous week.

---

## Model Performance

| Model | MAE | RMSE | WMAPE |
|---|---:|---:|---:|
| Seasonal Naive | 4.71 | 8.18 | 59.37% |
| **LightGBM** | **3.50** | **5.78** | **44.19%** |

LightGBM reduced:

- **MAE by 25.57%**
- **RMSE by 29.38%**
- **WMAPE by 25.57%**

This demonstrates that combining historical demand with calendar,
product, store, event, and pricing information substantially improved
forecast performance over the seasonal-naive baseline.

---

## Feature Importance

The most important LightGBM features were:

1. `lag_1`
2. `item_id`
3. `lag_7`
4. `lag_28`
5. `rolling_mean_7`
6. `week_of_year`
7. `day_of_week`
8. `rolling_mean_28`
9. `rolling_std_7`
10. `sell_price`

The model relied heavily on recent demand history and recurring
seasonal patterns, while product, store, and pricing information
provided additional predictive value.

---

# 3. Inventory Analytics

> **In progress**

The forecasting model will be translated into inventory planning
metrics including:

- Forecasted demand
- Safety stock
- Reorder point
- Stockout risk
- Inventory prioritization
- Store/product demand risk

The goal is to move from:

**"What will demand be?"**

to:

**"What should the retailer do about it?"**

---

# 4. Tableau Dashboard

> **In progress**

The final dashboard will communicate:

### Demand Overview

- Sales trends
- Category performance
- Store performance
- Seasonality

### Forecasting

- Actual vs predicted demand
- Forecast accuracy
- High-demand products/stores

### Inventory

- Stockout risk
- Reorder recommendations
- Safety stock
- Inventory prioritization

---

# Project Structure

```text
Retail-Demand-Forecasting/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│   ├── 01_EDA.ipynb
│   └── 02_Forecasting.ipynb
│
├── download_dataset.py
│
└── README.md