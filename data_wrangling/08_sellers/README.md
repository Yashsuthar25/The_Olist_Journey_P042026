# Sellers Table — Data Wrangling

## Overview
`olist_sellers` is the smallest table in the dataset — 4 columns: `seller_id`, `seller_zip_code_prefix`, `seller_city`, `seller_state`.

## Issues Found
- Verified `seller_id` uniqueness by comparing total row count against distinct `seller_id` count.
- Checked NULLs across all 4 columns.
- Checked `seller_zip_code_prefix` length consistency (expected 5 digits).
- Checked distinct `seller_city` count (610) and cross-referenced against external sources out of caution, given how high the number seemed relative to the table size.
- Checked distinct `seller_state` count (23) and reviewed the values for format consistency.

## Actions Taken
No corrective actions were required — every check on this table came back clean.

| Check | Result |
|---|---|
| Duplicate `seller_id` | None found |
| NULLs (all columns) | None found |
| Zip code length | Consistent (5 digits) |
| City/state format | Consistent |

## Issues Left Unresolved
- None. This was the cleanest table in the dataset — smallest column count and no data quality issues surfaced during checks.

## Final Schema (as wrangled)
| Column | Type (expected) | Notes |
|---|---|---|
| seller_id | CHAR(32) | Verified unique |
| seller_zip_code_prefix | CHAR(5) | Verified format |
| seller_city | VARCHAR | Verified, no fixes needed |
| seller_state | CHAR(2) | Verified, no fixes needed |
