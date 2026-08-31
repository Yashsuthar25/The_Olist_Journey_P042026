# Data Wrangling — Index

This folder documents the full data wrangling process for the Olist Brazilian E-Commerce dataset, one folder per table, in the order they were tackled.

Each table folder contains the raw `.sql` files (numbered in the order the checks/fixes were run) and a `README.md` covering:
- **Issues Found** — what was wrong with the data
- **Actions Taken** — what was fixed, and why
- **Issues Left Unresolved** — what was deliberately left alone, and the reasoning
- **Final Schema** — the state of the table after wrangling

## Tables (in the order they were wrangled)

| # | Table | Folder | Summary |
|---|---|---|---|
| — | Setup | [`00_setup`](./00_setup/README.md) | Initial bulk CSV import for all 9 source files |
| 1 | Customers | [`01_customers`](./01_customers/README.md) | Dropped a stray leftover table; all core checks passed clean |
| 2 | Geolocation | [`02_geolocation`](./02_geolocation/README.md) | Fixed zip code padding; left city/lat/lng inconsistencies out of scope |
| 3 | Order Items | [`03_order_items`](./03_order_items/README.md) | Rebuilt table with proper data types; referential integrity verified |
| 4 | Order Payments | [`04_order_payments`](./04_order_payments/README.md) | Flagged an unresolved `not_defined` payment-type anomaly |
| 5 | Order Reviews | [`05_order_reviews`](./05_order_reviews/README.md) | Fixed date columns; left duplicate reviews flagged but unresolved |
| 6 | Orders | [`06_orders`](./06_orders/README.md) | Removed invalid order IDs; flagged delivery-date and timestamp-sequence anomalies as source data gaps |
| 7 | Products | [`07_products`](./07_products/README.md) | Fixed 610 rows with missing category/description info; added English category translations |
| 8 | Sellers | [`08_sellers`](./08_sellers/README.md) | Cleanest table — all checks passed, no fixes needed |
| — | Import Corrections | [`09_import_corrections`](./09_import_corrections/README.md) | Cross-table fix for a date-format + trailing-comma issue found in re-imported CSVs |

## Overall Methodology

For every table, the same general pass was followed:
1. **Structure check** — `DESCRIBE`, row counts, primary key uniqueness
2. **Duplicates check** — at both the primary-key level and full-row level where relevant
3. **NULLs check** — across every column
4. **Format/consistency check** — ID lengths, casing, valid ranges (dates, scores, coordinates, etc.)
5. **Referential integrity check** — cross-table `LEFT JOIN`s to catch orphaned foreign keys
6. **Decide: fix or flag** — every issue found was either corrected with a documented reason, or deliberately left as-is with the reasoning recorded in that table's README

This "fix or flag with reasoning" approach was intentional — not every irregularity in a real-world dataset should be forced into a fix, and the goal of this project is to document that judgment, not just the SQL syntax.
