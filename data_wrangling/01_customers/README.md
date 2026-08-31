# Customers Table — Data Wrangling

## Overview
`olist_customers` holds one row per order-level customer record: `customer_id`, `customer_unique_id`, `customer_zip_code_prefix`, `customer_city`, `customer_state`. Note: `customer_id` is order-scoped in this dataset — a real-world customer (`customer_unique_id`) can have multiple `customer_id` values across different orders.

## Issues Found
- A stray, redundant table `olist_customers_dataset` existed alongside `olist_customers` — a leftover from an earlier import attempt.
- Checked for duplicate `customer_id` and `customer_unique_id` values.
- Checked NULLs across all 5 columns.
- Checked `customer_id` / `customer_unique_id` length consistency (expected 32-character hash IDs).
- Checked `customer_zip_code_prefix` length consistency (expected 5 digits).
- Checked `customer_state` length (expected 2-character state code).
- Investigated `customer_city` for casing/formatting inconsistency by comparing raw distinct count vs. an uppercased + trimmed distinct count.

## Actions Taken
| Issue | Action | Reasoning |
|---|---|---|
| Stray `olist_customers_dataset` table | Dropped the table | Leftover duplicate from import; not part of the real schema |
| Duplicates on `customer_id` / `customer_unique_id` | No action needed | Checks came back clean — no duplicates found |
| NULLs across all columns | No action needed | Checks came back clean — no NULLs found |
| ID / zip / state length consistency | No action needed | All values matched expected lengths |

## Issues Left Unresolved
- **`customer_city` formatting inconsistency**: the raw distinct count vs. the normalized (uppercase + trimmed) distinct count was compared to gauge how much casing/whitespace inconsistency exists in this column. No normalization (`UPPER`/`TRIM`) was actually applied to the live data — this was an investigative step only, not a fix, and the column was left as-is at this stage of the project.

## Final Schema (as wrangled)
| Column | Type (expected) | Notes |
|---|---|---|
| customer_id | CHAR(32) | Unique per order, not per real customer |
| customer_unique_id | CHAR(32) | Identifies the real customer across orders |
| customer_zip_code_prefix | CHAR(5) | Verified 5-digit format |
| customer_city | VARCHAR | Casing/formatting inconsistency noted, not normalized |
| customer_state | CHAR(2) | Verified format |
