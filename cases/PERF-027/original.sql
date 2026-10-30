WITH
perf_waste_1 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM web_sales
  WHERE ws_sold_date_sk IS NOT NULL OR ws_sold_date_sk IS NULL
),
perf_waste_2 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM web_sales
  WHERE ws_item_sk IS NOT NULL OR ws_item_sk IS NULL
),
perf_waste_3 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM web_sales
  WHERE ws_order_number IS NOT NULL OR ws_order_number IS NULL
),
perf_waste_4 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM web_sales
  WHERE ws_bill_customer_sk IS NOT NULL OR ws_bill_customer_sk IS NULL
),
perf_waste_5 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM web_sales
  WHERE ws_sold_date_sk IS NOT NULL OR ws_sold_date_sk IS NULL
),
perf_waste_6 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM web_sales
  WHERE ws_item_sk IS NOT NULL OR ws_item_sk IS NULL
),
perf_waste_7 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM web_sales
  WHERE ws_order_number IS NOT NULL OR ws_order_number IS NULL
),
perf_waste_8 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM web_sales
  WHERE ws_bill_customer_sk IS NOT NULL OR ws_bill_customer_sk IS NULL
),
perf_degraded AS MATERIALIZED (
  SELECT q.*
  FROM (

    SELECT q.*
    FROM (
      select  i_item_id
             ,i_item_desc
             ,s_state
             ,count(ss_quantity) as store_sales_quantitycount
             ,avg(ss_quantity) as store_sales_quantityave
             ,stddev_samp(ss_quantity) as store_sales_quantitystdev
             ,stddev_samp(ss_quantity)/avg(ss_quantity) as store_sales_quantitycov
             ,count(sr_return_quantity) as store_returns_quantitycount
             ,avg(sr_return_quantity) as store_returns_quantityave
             ,stddev_samp(sr_return_quantity) as store_returns_quantitystdev
             ,stddev_samp(sr_return_quantity)/avg(sr_return_quantity) as store_returns_quantitycov
             ,count(cs_quantity) as catalog_sales_quantitycount ,avg(cs_quantity) as catalog_sales_quantityave
             ,stddev_samp(cs_quantity) as catalog_sales_quantitystdev
             ,stddev_samp(cs_quantity)/avg(cs_quantity) as catalog_sales_quantitycov
       from store_sales
           ,store_returns
           ,catalog_sales
           ,date_dim d1
           ,date_dim d2
           ,date_dim d3
           ,store
           ,item
       where d1.d_quarter_name = '1999Q1'
         and d1.d_date_sk = ss_sold_date_sk
         and i_item_sk = ss_item_sk
         and s_store_sk = ss_store_sk
         and ss_customer_sk = sr_customer_sk
         and ss_item_sk = sr_item_sk
         and ss_ticket_number = sr_ticket_number
         and sr_returned_date_sk = d2.d_date_sk
         and d2.d_quarter_name in ('1999Q1','1999Q2','1999Q3')
         and sr_customer_sk = cs_bill_customer_sk
         and sr_item_sk = cs_item_sk
         and cs_sold_date_sk = d3.d_date_sk
         and d3.d_quarter_name in ('1999Q1','1999Q2','1999Q3')
       group by i_item_id
               ,i_item_desc
               ,s_state
       order by i_item_id
               ,i_item_desc
               ,s_state
       LIMIT 100
    ) q
  ) q
  CROSS JOIN perf_waste_1 w1
  CROSS JOIN perf_waste_2 w2
  CROSS JOIN perf_waste_3 w3
  CROSS JOIN perf_waste_4 w4
  CROSS JOIN perf_waste_5 w5
  CROSS JOIN perf_waste_6 w6
  CROSS JOIN perf_waste_7 w7
  CROSS JOIN perf_waste_8 w8
  WHERE w1.c >= 0 AND w2.c >= 0 AND w3.c >= 0 AND w4.c >= 0 AND w5.c >= 0 AND w6.c >= 0 AND w7.c >= 0 AND w8.c >= 0
)
SELECT *
FROM perf_degraded;
