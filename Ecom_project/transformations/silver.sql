---sales silver


-- create streaming table dev.silver.sales_cleaned
-- (CONSTRAINT valid_order_id expect (order_id is not null) on violation drop row)
-- as 
-- select distinct * except (`_rescued_data`,ingest_date,path) from stream dev.bronze.sales

--scd type 1 on products

CREATE OR REFRESH STREAMING TABLE silver.products;

CREATE FLOW product_flow AS AUTO CDC INTO
  silver.products
FROM
  stream(dev.bronze.products)
KEYS
  (product_id)
APPLY AS DELETE WHEN
  operation = "DELETE"
SEQUENCE BY
  seqNum
COLUMNS * EXCEPT
  (operation, seqNum, _rescued_data,ingest_date,path)
STORED AS
  SCD TYPE 1;



-- scd type 2 on customers
CREATE OR REFRESH STREAMING TABLE silver.customers_scd;

CREATE FLOW customer_flow AS AUTO CDC INTO
  silver.customers_scd
FROM
  stream(dev.bronze.customers)
KEYS
  (customer_id)
APPLY AS DELETE WHEN
  operation = "DELETE"
SEQUENCE BY
  sequenceNum
COLUMNS * EXCEPT
  (operation, sequenceNum, _rescued_data,ingest_date,path)
STORED AS
  SCD TYPE 2;
