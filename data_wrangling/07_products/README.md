# Products Table — Data Wrangling

## Overview
`olist_products` holds product catalog data: `product_id`, `product_category_name`, name/description length, photo count, and physical dimensions (weight, length, height, width). Expected size: 32,951 unique products.

## Issues Found
- Verified `product_id` uniqueness — count matched the expected metadata total (32,951), confirming no duplicates.
- Checked NULLs across all 9 columns — found exactly **610 NULLs**, appearing simultaneously across `product_name_lenght`, `product_description_lenght`, and `product_photos_qty`.
- Dug deeper into those same 610 rows and found `product_category_name` was also blank (`''`) for all of them — a 4th affected column.
- Researched the issue online and confirmed this is a widely-known, common data gap in the public Olist dataset — not something with a fixable root cause on this end.
- Checked `product_id` length consistency (expected 32 characters).
- Verified referential integrity of `product_id` against `olist_order_items` in both directions (`LEFT JOIN` each way) to confirm no orphaned products or orphaned order items.
- Checked all numeric columns (name length, description length, photo count, weight, dimensions) for zero or negative values — found exactly 2 NULLs in `product_weight_g` / `product_length_cm` / `product_height_cm` / `product_width_cm`, and separately found 4 rows where `product_weight_g = 0`.

## Actions Taken
| Issue | Action | Reasoning |
|---|---|---|
| 610 rows missing category + description info | Updated `product_category_name` to `'N/A'` and set `product_name_lenght`, `product_description_lenght`, `product_photos_qty` to `0` (instead of leaving them blank/NULL) | Flags these rows clearly as "missing info" rather than leaving ambiguous blanks/NULLs; confirmed as a known dataset-wide issue with no real fix available |
| Missing English category translations | Added a new column `product_category_name_english` via `ALTER TABLE`, backfilled it with a `JOIN` against `product_category_name_translation` | Chose to add a new column rather than overwrite the original Portuguese category name, preserving the source data |
| 2 category names missing from the translation lookup table (`pc_gamer`, `portateis_cozinha_e_preparadores_de_alimentos`) | Manually inserted their English translations into `product_category_name_translation`, then re-ran the backfill | The lookup table itself was incomplete; found by comparing distinct product categories against the translation table |
| Risk of destructive changes | Created `olist_products_backup` as a full backup before altering the table | Safety net before running `ALTER TABLE` / `UPDATE` statements |
| 4 rows with `product_weight_g = 0` | Updated to NULL | A weight of exactly 0 is not physically valid for a shippable product; NULL more accurately represents "unknown" than a false zero |

## Issues Left Unresolved
- **2 NULLs in `product_weight_g` / `product_length_cm` / `product_height_cm` / `product_width_cm`** (separate from the 4 zero-weight rows above): researched online, found no identifiable root cause or reliable way to impute these values — left as NULL rather than guessing, to avoid introducing incorrect data.

## Final Schema (as wrangled)
| Column | Type | Notes |
|---|---|---|
| product_id | CHAR(32) | Verified unique, verified referential integrity |
| product_category_name | VARCHAR | 610 blanks flagged as `'N/A'` |
| product_category_name_english | VARCHAR (new) | Added via translation lookup, 2 manual translations added |
| product_name_lenght | INT | 610 NULLs set to 0 (flagged missing) |
| product_description_lenght | INT | 610 NULLs set to 0 (flagged missing) |
| product_photos_qty | INT | 610 NULLs set to 0 (flagged missing) |
| product_weight_g | INT | 4 zero-values set to NULL; 2 pre-existing NULLs left as-is |
| product_length_cm | INT | 2 pre-existing NULLs left as-is |
| product_height_cm | INT | 2 pre-existing NULLs left as-is |
| product_width_cm | INT | 2 pre-existing NULLs left as-is |
