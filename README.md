# Olist E-Commerce Data Analysis

My first full data analysis project, built using the **Project-Based Learning (PBL) methodology** — learning tools and techniques as the project demands them, rather than studying everything upfront.

This project follows 4 phases:

| Phase | Status | Description |
|---|---|---|
| **Ask** | 🔲 Upcoming | Define the business problem and key questions |
| **Prepare & Wrangle** | 🟡 In Progress | Clean and structure all 8 Olist tables in MySQL |
| **Analyze** | 🔲 Upcoming | Explore cleaned data for patterns and insights |
| **Share** | 🔲 Upcoming | Present findings via reports/dashboards |

---

## About the Dataset

The [Olist Brazilian E-Commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) contains ~100k real, anonymized orders placed on the Olist marketplace between 2016–2018, spread across 8 relational tables covering customers, orders, order items, payments, reviews, products, sellers, and geolocation.

---

## 📂 Repository Structure

```
The_Olist_Journey_P042026/
├── README.md
├── data_wrangling/
│   ├── README.md                     ← index of the wrangling process
│   ├── 00_setup/                     ← initial CSV import
│   ├── 01_customers/
│   ├── 02_geolocation/
│   ├── 03_order_items/
│   ├── 04_order_payments/
│   ├── 05_order_reviews/
│   ├── 06_orders/
│   ├── 07_products/
│   ├── 08_sellers/
│   └── 09_import_corrections/        ← cross-table re-import fix
├── docs/
└── erd/
```

Each table folder contains:
- The numbered `.sql` files, in the order the checks/fixes were actually run
- A `README.md` documenting issues found, fixes applied, issues left unresolved, and the final schema

See [`data_wrangling/README.md`](./data_wrangling/README.md) for the full index and overall methodology.

---

## 🛠️ Tools Used

- **MySQL** — data cleaning, transformation, and querying
- **VS Code** & **GitHub** — version control and project organization
- *(More tools — Python, visualization/BI — will be added in later phases)*

---

## ✅ Progress

- [x] Repo structure created
- [x] Customers table wrangling documented
- [x] Geolocation table wrangling documented
- [x] Order items table wrangling documented
- [x] Order payments table wrangling documented
- [x] Order reviews table wrangling documented
- [x] Orders table wrangling documented
- [x] Products table wrangling documented
- [x] Sellers table wrangling documented
- [x] Cross-table import corrections documented
- [x] Master README finalized
- [ ] Ask phase
- [ ] Analyze phase
- [ ] Share phase

---

## 💬 Why This Repo Exists

I wanted a space that shows real progress and real decision-making — the messy parts included — rather than just a polished final output. Every fix in here was made for a documented reason, and every issue left alone was left alone on purpose, not by accident. Expect this repo to evolve phase by phase as the project moves forward.

Feedback, suggestions, and critiques are always welcome.
