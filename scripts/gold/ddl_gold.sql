-- ddl scrips for gold layer

-- ===================================
-- for gold.dim_customers
-- ===================================
create view gold.dim_customers as
select
row_number() over(order by cst_id) as customer_key,
ci.cst_id customer_id,
ci.cst_key cutomer_number,
ci.cst_firstname first_name,
ci.cst_lastname last_name,
la.cntry country,
ci.cst_material_status maritul_status,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr
else ca.gen
end gender,
ca.bdate birthdate,
ci.cst_create_date create_date
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca
on ci.cst_key= ca.cid
left join silver.erp_loc_a101 la
on ci.cst_key=la.cid


-- ===================================
-- for gold.dim_products
-- ===================================
create view gold.dim_products as
select
	row_number() over(order by pn.prd_start_dt, pn.prd_key) product_key,
	pn.prd_id product_id,
	pn.prd_key product_number,
	pn.prd_nm product_name,
	pn.cat_id category_id,
	pc.cat category,
	pc.subcat subcategory,
	pc.maintenance,
	pn.prd_cost cost,
	pn.prd_line product_line,
	pn.prd_start_dt start_date
from silver.crm_prd_info pn
left join silver.erp_px_cat_g1v2 pc
on pn.cat_id=pc.id
where pn.prd_end_dt is null --filter out all historical data

-- ===================================
-- for gold.fact_sales
-- ===================================
create view gold.fact_sales as
select
sd.sls_ord_num order_number,
pr.product_key,
cu.customer_key,
sd.sls_order_dt order_date,
sd.sls_ship_dt shipping_date,
sd.sls_due_dt due_date,
sd.sls_sales sales_amount,
sd.sls_quantity quantity,
sd.sls_price price
from silver.crm_sales_details sd
left join gold.dim_products pr
on sd.sls_prd_key=pr.product_number
left join gold.dim_customers cu
on sd.sls_cust_id=cu.customer_id
