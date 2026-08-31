-- Hello, I'm back, and I should have continued yesterday as well but I'd gueste to cater to, so let's go. 

DESCRIBE olist_sellers;

SELECT
	*
FROM
	olist_database.olist_sellers
LIMIT 	
	10;
    
-- So, 2 columns are completed & 2 are remaining.
SELECT
	COUNT(DISTINCT(seller_city))
FROM
	olist_database.olist_sellers;
-- The output is 610, the sources which I found from the internet, state the same story but I'm a little
-- doubtful about this, I'll try to find more if possible.

SELECT
	COUNT(DISTINCT(seller_state))
FROM
	olist_database.olist_sellers;
-- The count is correct, and I'll quickly just look at 23 Distinct values for format consistency and cross-verification.

SELECT
	DISTINCT(seller_State)
FROM
	olist_database.olist_sellers;
-- Data consistency is okay, so with that I'm completed with the data wrangling process for this table. 

/* Now, since I've completed the data wrangling process for this table, with that all the tables are completed
But I remember, their is one table which I've to get back to, with that my data wrangling process will be completed,
I know, It took me a lot of time to complete this but I wanted to build consistency & understanding which takes
time, I'll continue tomorrow. 

