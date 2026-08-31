SELECT *
FROM  
 Olist_database.Olist_customers;
 
 
 SELECT *
FROM  
 Olist_database.Olist_customers;

SELECT COUNT(customer_unique_id)
FROM
 Olist_database.Olist_customers
GROUP BY 
 customer_unique_id
HAVING
 customer_unique_id >1;
 
 SELECT 
    customer_id, 
    COUNT(customer_id) AS Count_Customers
FROM
    Olist_database.Olist_customers
GROUP BY 
    customer_id
HAVING
    Count_Customers >1;