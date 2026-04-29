CREATE OR REFRESH MATERIALIZED VIEW dev.gold.active_customers AS
SELECT
  customer_id,
  customer_name,
  customer_email,
  customer_city,
  customer_state
FROM dev.silver.customers_scd
WHERE __END_AT IS NULL;


create materialized view dev.gold.customers_sales as 
select s.customer_id, ac.customer_name, ac.customer_city, s.total_amount  
from silver.sales_cleaned s
join gold.active_customers ac 
on s.customer_id=ac.customer_id