# Orders Table — Data Wrangling

## Overview
`olist_orders` is the central table of the dataset: `order_id`, `customer_id`, `order_status`, and 5 timestamp columns tracking an order's lifecycle (purchase → approved → delivered to carrier → delivered to customer → estimated delivery). This was the most involved table to wrangle, spanning 6 sessions.

## Issues Found
- Found rows with `order_id` that was NULL, `'0'`, or an empty string.
- Checked `customer_id`, `order_status`, and all timestamp columns for NULLs.
- Investigated the relationship between `order_status` and NULL `order_approved_at` — found orders with `order_status = 'delivered'` that still had a NULL `order_approved_at` (logically unexpected).
- Investigated orders where both `order_delivered_carrier_date` and `order_delivered_customer_date` were NULL, broken down by `order_status` (`canceled`, `unavailable`, `processing`, `invoiced`) to see if this was expected for those statuses.
- Found some orders with both delivery dates NULL that fell **outside** that expected status list — a genuine anomaly.
- Investigated orders with `order_status = 'delivered'` but `order_delivered_customer_date` still NULL — logically, a delivered order should have this date populated.
- Checked `order_id` / `customer_id` length consistency (expected 32 characters).
- Checked chronological logic across the 4 lifecycle timestamps (`purchase → approved → delivered_carrier → delivered_customer`) — flagged any row where an earlier stage's timestamp came *after* a later stage's.
- For the chronological violations found, drilled down further to check whether they were genuine multi-day errors or just same-day logging quirks (using `DATE()` and `DATEDIFF`).

## Actions Taken
| Issue | Action | Reasoning |
|---|---|---|
| NULL / `'0'` / blank `order_id` | `DELETE` the affected rows | These rows have no valid identifier and can't be joined or analyzed meaningfully |
| Row count / distinct `order_id` verification | Confirmed distinct count matched total row count post-cleanup | Ensures the delete didn't leave duplicate or orphaned identifiers |

## Issues Left Unresolved
- **`delivered` status orders with NULL `order_approved_at` or NULL `order_delivered_customer_date`**: confirmed as a genuine data gap in the source dataset, not something introduced by wrangling. Left as-is — these are treated as a known limitation of the original Olist data rather than something to force-fill or guess at.
- **Timestamp sequence violations** (e.g., `order_approved_at` earlier than `order_purchase_timestamp`): investigated at the day-level to separate real multi-day errors from same-timestamp/same-day logging artifacts. No rows were deleted or corrected — determined to be a data-logging characteristic of the source system rather than a fixable error, and flagged for awareness during analysis rather than removed.

## Note
This table was later touched a second time as part of a broader cross-table re-import fix — see [`09_import_corrections`](../09_import_corrections/README.md) for a full staging-table rebuild that also corrected a date-format mismatch found in a later CSV re-import.

## Final Schema (as wrangled)
| Column | Type | Notes |
|---|---|---|
| order_id | CHAR(32) | NULL/blank/'0' rows removed |
| customer_id | CHAR(32) | Length-verified |
| order_status | VARCHAR | Cross-checked against timestamp completeness |
| order_purchase_timestamp | DATETIME | Sequence-checked |
| order_approved_at | DATETIME | Some NULLs on 'delivered' orders — unresolved (source data gap) |
| order_delivered_carrier_date | DATETIME | Sequence-checked |
| order_delivered_customer_date | DATETIME | Some NULLs on 'delivered' orders — unresolved (source data gap) |
| order_estimated_delivery_date | DATETIME | Not deeply investigated beyond NULL check |
