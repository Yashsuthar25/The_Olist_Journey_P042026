# Setup & Bulk Import

## Overview
Initial load of all 9 raw Olist CSVs (8 core tables + `product_category_name_translation`) into MySQL using `LOAD DATA INFILE`.

## What This Covers
- Checked `secure_file_priv` to confirm where MySQL allows file imports from
- Bulk-imported all 9 CSVs directly into pre-created tables:
  - `olist_customers`, `olist_sellers`, `product_category_name_translation`, `olist_products`, `olist_orders`, `olist_order_items`, `olist_order_payments`, `olist_order_reviews`, `olist_geolocation`
- All imports used comma-delimited, double-quote-enclosed, newline-terminated format with the header row skipped (`IGNORE 1 ROWS`)

## Issues Found
- None at this stage — this is the raw, first-pass import before any wrangling began. Data type mismatches and formatting issues were discovered later, table by table (see individual folders and `09_import_corrections/` for the bigger structural fix that came out of this).

## Notes
This file represents the starting point of the whole project. Every issue documented in `01` through `08` was found *after* this raw import.
