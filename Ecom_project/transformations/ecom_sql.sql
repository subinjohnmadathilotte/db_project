create streaming table sales as
select * , current_timestamp() as ingest_date,_metadata.file_name as path from stream read_files("/Volumes/dev/bronze/raw/sales");

create streaming table customers as
select * , current_timestamp() as ingest_date,_metadata.file_name as path from stream read_files("/Volumes/dev/bronze/raw/customers");

create streaming table products as
select * , current_timestamp() as ingest_date,_metadata.file_name as path from stream read_files("/Volumes/dev/bronze/raw/products")