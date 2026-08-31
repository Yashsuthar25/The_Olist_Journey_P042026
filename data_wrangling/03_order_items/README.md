# Order Items Table — Data Wrangling

## Overview
`olist_order_items` holds one row per item within an order: `order_id`, `order_item_id`, `product_id`, `seller_id`, `shipping_limit_date`, `price`, `freight_value`. Expected size: 112,650 rows.

## Issues Found
- Checked for duplicate rows at `order_id` + `order_item_id` granularity, and again across all columns together.
- Checked NULLs across all 7 columns.
- The table had been imported with columns typed loosely (via a `staging_order_items` table), so `shipping_limit_date` was not a usable DATETIME and numeric columns weren't reliably typed for calculations.
- Checked for negative or zero `price` / `freight_value`.
- Checked `order_id` / `product_id` / `seller_id` length consistency (expected 32 characters) and case consistency (expected lowercase hashes).
- Checked referential integrity: every `order_id` should exist in `olist_orders`, every `product_id` in `olist_products`, and every `seller_id` in `olist_sellers`.

## Actions Taken
| Issue | Action | Reasoning |
|---|---|---|
| Loosely-typed columns | Dropped and rebuilt `olist_order_items` with explicit types (`VARCHAR(32)` for IDs, `INT` for `order_item_id`, `DATETIME` for `shipping_limit_date`, `DECIMAL(10,2)` for `price`/`freight_value`), then repopulated from `staging_order_items` using `STR_TO_DATE` and `CAST` | Ensures dates and monetary values can be reliably used in calculations and joins |
| Post-rebuild verification | Confirmed row count matched the real dataset size (112,650) and checked for any NULL dates introduced during the type conversion | Ensures the rebuild didn't silently drop or corrupt data |
| Stuck queries during rebuild | Used `SHOW FULL PROCESSLIST` + `KILL QUERY` to clear hung sessions before retrying | Long DDL/DML on a large table needed a clean session to complete |

## Issues Left Unresolved
- None flagged — duplicate checks, NULL checks, price/freight sanity checks, ID format checks, and referential integrity checks (via `LEFT JOIN` against `olist_orders`, `olist_products`, `olist_sellers`) all came back clean with zero orphaned rows.

## Note
This table was later touched a second time as part of a broader cross-table re-import fix — see [`09_import_corrections`](../09_import_corrections/README.md) for the full staging-table rebuild that also corrected a date-format mismatch.

## Final Schema (as wrangled)
| Column | Type | Notes |
|---|---|---|
| order_id | VARCHAR(32) | FK → olist_orders, verified no orphans |
| order_item_id | INT | Sequence number within an order |
| product_id | VARCHAR(32) | FK → olist_products, verified no orphans |
| seller_id | VARCHAR(32) | FK → olist_sellers, verified no orphans |
| shipping_limit_date | DATETIME | Rebuilt from TEXT via STR_TO_DATE |
| price | DECIMAL(10,2) | Rebuilt via CAST |
| freight_value | DECIMAL(10,2) | Rebuilt via CAST |
