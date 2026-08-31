# Order Payments Table — Data Wrangling

## Overview
`olist_order_payments` holds payment details per order: `order_id`, `payment_sequential`, `payment_type`, `payment_installments`, `payment_value`. An order can have multiple payment rows (e.g., split payments).

## Issues Found
- Checked for duplicate `order_id` + `payment_sequential` combinations.
- Checked NULLs across all 5 columns.
- Checked distinct `payment_type` values and distinct `payment_installments` values for unexpected entries.
- Found rows where `payment_value = 0` **and** `payment_type = 'not_defined'` — an anomaly worth investigating further.
- Checked `order_id` length consistency (expected 32 characters).
- Checked for `payment_installments <= 0` as an edge case.

## Actions Taken
| Issue | Action | Reasoning |
|---|---|---|
| Duplicate order_id + payment_sequential | No action needed | Checks came back clean |
| NULLs across all columns | No action needed | Checks came back clean |
| `payment_value = 0` with `payment_type = 'not_defined'` | Investigated by cross-referencing the affected `order_id`s against `olist_order_items` and `olist_orders` | Wanted to understand whether these were canceled/failed orders rather than a data entry error before deciding on a fix |

## Issues Left Unresolved
- **`payment_type = 'not_defined'` with `payment_value = 0`**: investigated via cross-referencing to specific orders, but no corrective action (update/delete) was applied in this pass. This is flagged as a known anomaly likely tied to canceled or otherwise incomplete order/payment records, rather than a fixable data-entry error — left as-is pending further business-context decisions in the Analyze phase.

## Final Schema (as wrangled)
| Column | Type (expected) | Notes |
|---|---|---|
| order_id | CHAR(32) | Verified length consistency |
| payment_sequential | INT | Sequence of payment attempts per order |
| payment_type | VARCHAR | Includes a `not_defined` category — unresolved anomaly |
| payment_installments | INT | Checked for invalid (≤0) values |
| payment_value | DECIMAL | Zero-value rows tied to `not_defined` type, unresolved |
