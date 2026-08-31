# Order Reviews Table — Data Wrangling

## Overview
`olist_order_reviews` holds customer review data per order: `review_id`, `order_id`, `review_score`, `review_comment_title`, `review_comment_message`, `review_creation_date`, `review_answer_timestamp`.

## Issues Found
- Checked for duplicate `review_id` + `order_id` combinations — found cases where the same `review_id` appears more than once. Investigated further with a `LEFT JOIN` against `olist_orders` to see the customer/order context behind the duplicates.
- Checked NULLs across `review_id`, `order_id`, and `review_score` — none found.
- Checked `review_id` / `order_id` length consistency (expected 32 characters).
- Checked `review_score` was within the valid range (1–5).
- `review_creation_date` and `review_answer_timestamp` were not usable as proper datetimes — required parsing via a `staging_order_reviews` table.
- Checked for logical ordering: `review_answer_timestamp` should never be earlier than `review_creation_date`.

## Actions Taken
| Issue | Action | Reasoning |
|---|---|---|
| Unusable date columns | Parsed via `staging_order_reviews` using `STR_TO_DATE` and `NULLIF` for blanks, then updated the live table via a `JOIN` | Needed real DATETIME values to support any time-based analysis |
| Malformed date strings during parsing | Filtered using `REGEXP` to validate date format (`^[0-9]{4}-[0-9]{2}-[0-9]{2}`) before inserting, then did a full `TRUNCATE` + re-`INSERT` from the validated staging data | A first pass caused issues with malformed rows; re-doing the load with a stricter filter avoided corrupting the date columns |
| Stuck query during the process | Used `SHOW FULL PROCESSLIST` + `KILL QUERY` to clear a hung session | Needed a clean session before re-running the `TRUNCATE`/`INSERT` |

## Issues Left Unresolved
- **Duplicate `review_id` values**: confirmed to exist and investigated (joined against `olist_orders` for context), but no deduplication step was applied in this pass. This is a known characteristic of the public Olist dataset (a review can be logged more than once for the same order in some cases) — flagged rather than removed, pending a decision in the Analyze phase on how to handle it (e.g., keep latest, keep highest score, or keep as-is for review-count metrics).

## Note
This table was later touched a second time as part of a broader cross-table re-import fix — see [`09_import_corrections`](../09_import_corrections/README.md) for the full staging-table rebuild that also corrected a date-format mismatch (the source CSV used a `DD-MM-YYYY` format on a later re-import).

## Final Schema (as wrangled)
| Column | Type | Notes |
|---|---|---|
| review_id | CHAR(32) | Duplicates exist and are unresolved (flagged) |
| order_id | CHAR(32) | Length-verified |
| review_score | TINYINT | Range-verified (1–5) |
| review_comment_title | VARCHAR/NULL | Blanks converted to NULL |
| review_comment_message | TEXT/NULL | Blanks converted to NULL |
| review_creation_date | DATETIME | Rebuilt via STR_TO_DATE |
| review_answer_timestamp | DATETIME | Rebuilt via STR_TO_DATE |
