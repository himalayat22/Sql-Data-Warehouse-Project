-- Stored Procedure: Load Bronze Layer (Source -> Bronze)

CREATE OR REPLACE PROCEDURE bronze.load_all_bronze_tables()
LANGUAGE plpgsql
AS $$
BEGIN
    -- 1. crm_cust_info
    TRUNCATE TABLE bronze.crm_cust_info;
    EXECUTE format('COPY bronze.crm_cust_info FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')', 
        'C:\Users\Public\Documents\sql datawarehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv');

    -- 2. crm_prd_info
    TRUNCATE TABLE bronze.crm_prd_info;
    EXECUTE format('COPY bronze.crm_prd_info FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')', 
        'C:\Users\Public\Documents\sql datawarehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv');

    -- 3. crm_sales_details
    TRUNCATE TABLE bronze.crm_sales_details;
    EXECUTE format('COPY bronze.crm_sales_details FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')', 
        'C:\Users\Public\Documents\sql datawarehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv');

    -- 4. erp_cust_az12
    TRUNCATE TABLE bronze.erp_cust_az12;
    EXECUTE format('COPY bronze.erp_cust_az12 FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')', 
        'C:\Users\Public\Documents\sql datawarehouse\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv');

    -- 5. erp_loc_a101
    TRUNCATE TABLE bronze.erp_loc_a101;
    EXECUTE format('COPY bronze.erp_loc_a101 FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')', 
        'C:\Users\Public\Documents\sql datawarehouse\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv');

    -- 6. erp_px_cat_g1v2
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    EXECUTE format('COPY bronze.erp_px_cat_g1v2 FROM %L WITH (FORMAT csv, HEADER true, DELIMITER '','')', 
        'C:\Users\Public\Documents\sql datawarehouse\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv');

    RAISE NOTICE 'All bronze tables loaded successfully.';
END;
$$;


CALL bronze.load_all_bronze_tables();
