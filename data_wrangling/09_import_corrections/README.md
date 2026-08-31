# Import Corrections — Cross-Table Re-Import Fix

## Overview
Unlike the other folders, this isn't about a single table — it documents a structural issue that surfaced *after* several tables had already been wrangled, and the full staging-table rebuild used to fix it across `olist_orders`, `olist_order_items`, and `olist_order_reviews`.

## Issues Found
- **Sanity check first**: ran a row-count comparison (`UNION ALL`) across `olist_sellers`, `product_category_name_translation`, and `olist_products` to confirm nothing had silently gone wrong with those tables before digging into the bigger issue.
- **Root cause**: a re-cleaned/re-exported version of the source CSVs (`_cleaned3` for orders, plus similarly reprocessed files for order_items and order_reviews) had two problems:
  1. Date columns had shifted from the original `YYYY-MM-DD` format to a **`DD-MM-YYYY`** format, which `STR_TO_DATE` in the earlier wrangling passes wasn't expecting — causing failed or NULL date conversions.
  2. The CSVs had **trailing commas** producing phantom extra columns, which broke a straightforward `LOAD DATA INFILE`.

## Actions Taken
| Issue | Action | Reasoning |
|---|---|---|
| Trailing commas creating phantom columns | Used `LOAD_FILE` + `REGEXP_REPLACE` to strip trailing commas from the raw CSV at the file level before loading (`order_items`, `order_reviews`); used dummy placeholder columns (`@dummy1`...`@dummy8`) in the `LOAD DATA INFILE` statement for `orders` to safely absorb any extra trailing fields regardless of count | Prevents the extra phantom fields from misaligning real columns during import |
| Unreliable typing on direct import | Rebuilt via `TEXT`-only staging tables (`staging_orders`, `staging_order_items`, `staging_order_reviews`) that can accept any raw string without failing, then cast/parsed into the real tables afterward | Guarantees the import step itself never fails on a type mismatch — all type conversion happens in a controlled second step |
| New `DD-MM-YYYY` date format | Used `STR_TO_DATE` with `COALESCE` across two format patterns (`'%d-%m-%Y %H:%i'` and `'%d-%m-%Y'`) to handle both timestamped and date-only values | Original single-format `STR_TO_DATE` calls from earlier sessions couldn't handle the new format; `COALESCE` provides a fallback so both variants parse correctly |
| Swapping in corrected data | Used `TRUNCATE TABLE` + `INSERT ... SELECT` from the corrected staging tables, rather than dropping and recreating the tables | Preserves the existing table structure/constraints while replacing the data cleanly |
| `order_payments` | Re-imported directly via `LOAD DATA INFILE` with no staging table | This table has no date columns, so the type/format issues affecting the other three tables didn't apply here |
| Verifying the fix | Ran row counts on every staging table and every corrected final table, plus a full `SELECT *` sanity pass across all 8 core tables + the translation lookup table | Confirms no rows were silently lost or duplicated during the rebuild |

## Issues Left Unresolved
- None specific to this correction pass — this was purely a structural/import fix, and all row counts were verified as matching expectations after the rebuild.

## Why This Folder Exists Separately
This fix touched multiple already-wrangled tables (`orders`, `order_items`, `order_reviews`) at once, using a different technique (file-level regex cleanup + staging tables) than the original per-table wrangling sessions. Rather than force it into one table's folder, it's documented here as its own step in the process — a good example of a data pipeline issue that only became visible after working with the data for a while, not something caught on the first pass.

## Files
- `01_row_count_sanity_check.sql` — quick cross-table row count verification
- `02_staging_reimport_fix.sql` — the full staging-table rebuild for `orders`, `order_items`, and `order_reviews`, plus the direct re-import of `order_payments`
