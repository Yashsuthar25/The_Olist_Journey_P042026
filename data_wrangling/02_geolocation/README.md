# Geolocation Table — Data Wrangling

## Overview
`olist_geolocation` maps Brazilian zip code prefixes to latitude/longitude coordinates plus city/state. This is the largest table in the dataset (~1,000,163 rows) and has a many-to-one relationship with zip codes (multiple lat/lng points per prefix).

## Issues Found
- `geolocation_zip_code_prefix` had inconsistent length — some values were shorter than the expected 5 digits (leading zeros had been dropped, likely during CSV import/typing).
- Checked `geolocation_state` length (expected 2 characters).
- Checked `geolocation_lat` / `geolocation_lng` were within valid coordinate ranges (-90 to 90, -180 to 180).
- Checked NULLs across all 5 columns.
- `geolocation_city` had 8,000+ distinct values — investigated whether this was genuine city-name diversity or a formatting artifact (casing, accented characters, special characters). Confirmed most of the inflation was due to formatting inconsistency, not real distinct cities.

## Actions Taken
| Issue | Action | Reasoning |
|---|---|---|
| `geolocation_zip_code_prefix` shorter than 5 digits | `LPAD(geolocation_zip_code_prefix, 5, '0')` to restore leading zeros | Root cause identified: leading zeros were being dropped; padding restores the correct format. 245,733 rows affected; verified against the full table count (1,000,163) post-fix |
| NULLs across all columns | No action needed | Checks came back clean — no NULLs found |

## Issues Left Unresolved
- **`geolocation_city` formatting inconsistency**: confirmed as a real issue (8,000+ distinct values due to casing/accents/special characters) but deliberately left unfixed. Decision: this project relies on `geolocation_state` for location-level analysis, not city, so cleaning city names wasn't necessary for current scope. Flagged for revisiting if city-level analysis is ever needed.
- **`geolocation_lat` / `geolocation_lng`**: left untouched for the same reason — no current use case for precise coordinates in this project, so no cleaning effort was spent here.

## Final Schema (as wrangled)
| Column | Type (expected) | Notes |
|---|---|---|
| geolocation_zip_code_prefix | CHAR(5) | Fixed via zero-padding |
| geolocation_lat | DECIMAL | Range-validated, not otherwise cleaned |
| geolocation_lng | DECIMAL | Range-validated, not otherwise cleaned |
| geolocation_city | VARCHAR | Known formatting inconsistency, left as-is (out of scope) |
| geolocation_state | CHAR(2) | Verified format |
