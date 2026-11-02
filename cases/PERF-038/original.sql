WITH
perf_waste_1 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_sold_date_sk IS NOT NULL OR cs_sold_date_sk IS NULL
),
perf_waste_2 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_item_sk IS NOT NULL OR cs_item_sk IS NULL
),
perf_waste_3 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_order_number IS NOT NULL OR cs_order_number IS NULL
),
perf_waste_4 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_bill_customer_sk IS NOT NULL OR cs_bill_customer_sk IS NULL
),
perf_waste_5 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_sold_date_sk IS NOT NULL OR cs_sold_date_sk IS NULL
),
perf_waste_6 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_item_sk IS NOT NULL OR cs_item_sk IS NULL
),
perf_waste_7 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_order_number IS NOT NULL OR cs_order_number IS NULL
),
perf_waste_8 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_bill_customer_sk IS NOT NULL OR cs_bill_customer_sk IS NULL
),
perf_waste_9 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_sold_date_sk IS NOT NULL OR cs_sold_date_sk IS NULL
),
perf_waste_10 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_item_sk IS NOT NULL OR cs_item_sk IS NULL
),
perf_waste_11 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_order_number IS NOT NULL OR cs_order_number IS NULL
),
perf_waste_12 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_bill_customer_sk IS NOT NULL OR cs_bill_customer_sk IS NULL
),
perf_waste_13 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_sold_date_sk IS NOT NULL OR cs_sold_date_sk IS NULL
),
perf_waste_14 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_item_sk IS NOT NULL OR cs_item_sk IS NULL
),
perf_waste_15 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_order_number IS NOT NULL OR cs_order_number IS NULL
),
perf_waste_16 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_bill_customer_sk IS NOT NULL OR cs_bill_customer_sk IS NULL
),
perf_waste_17 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_sold_date_sk IS NOT NULL OR cs_sold_date_sk IS NULL
),
perf_waste_18 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_item_sk IS NOT NULL OR cs_item_sk IS NULL
),
perf_waste_19 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_order_number IS NOT NULL OR cs_order_number IS NULL
),
perf_waste_20 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_bill_customer_sk IS NOT NULL OR cs_bill_customer_sk IS NULL
),
perf_waste_21 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_sold_date_sk IS NOT NULL OR cs_sold_date_sk IS NULL
),
perf_waste_22 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_item_sk IS NOT NULL OR cs_item_sk IS NULL
),
perf_waste_23 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_order_number IS NOT NULL OR cs_order_number IS NULL
),
perf_waste_24 AS MATERIALIZED (
  SELECT count(*) AS c
  FROM catalog_sales
  WHERE cs_bill_customer_sk IS NOT NULL OR cs_bill_customer_sk IS NULL
),
perf_degraded AS MATERIALIZED (
  SELECT q.*
  FROM (

    WITH perf_reference AS MATERIALIZED (
      SELECT q.*
      FROM (

        WITH perf_reference AS MATERIALIZED (
          SELECT q.*
          FROM (
            select  *
            from (select i_manager_id
                         ,sum(ss_sales_price) sum_sales
                         ,avg(sum(ss_sales_price)) over (partition by i_manager_id) avg_monthly_sales
                  from item
                      ,store_sales
                      ,date_dim
                      ,store
                  where ss_item_sk = i_item_sk
                    and ss_sold_date_sk = d_date_sk
                    and ss_store_sk = s_store_sk
                    and d_month_seq in (1181,1181+1,1181+2,1181+3,1181+4,1181+5,1181+6,1181+7,1181+8,1181+9,1181+10,1181+11)
                    and ((    i_category in ('Books','Children','Electronics')
                          and i_class in ('personal','portable','reference','self-help')
                          and i_brand in ('scholaramalgamalg #14','scholaramalgamalg #7',
            		                  'exportiunivamalg #9','scholaramalgamalg #9'))
                       or(    i_category in ('Women','Music','Men')
                          and i_class in ('accessories','classical','fragrances','pants')
                          and i_brand in ('amalgimporto #1','edu packscholar #1','exportiimporto #1',
            		                 'importoamalg #1')))
            group by i_manager_id, d_moy) tmp1
            where case when avg_monthly_sales > 0 then abs (sum_sales - avg_monthly_sales) / avg_monthly_sales else null end > 0.1
            order by i_manager_id
                    ,avg_monthly_sales
                    ,sum_sales
             LIMIT 100
          ) q
        )
        SELECT *
        FROM perf_reference
      ) q
    )
    SELECT *
    FROM perf_reference
  ) q
  CROSS JOIN perf_waste_1 w1
  CROSS JOIN perf_waste_2 w2
  CROSS JOIN perf_waste_3 w3
  CROSS JOIN perf_waste_4 w4
  CROSS JOIN perf_waste_5 w5
  CROSS JOIN perf_waste_6 w6
  CROSS JOIN perf_waste_7 w7
  CROSS JOIN perf_waste_8 w8
  CROSS JOIN perf_waste_9 w9
  CROSS JOIN perf_waste_10 w10
  CROSS JOIN perf_waste_11 w11
  CROSS JOIN perf_waste_12 w12
  CROSS JOIN perf_waste_13 w13
  CROSS JOIN perf_waste_14 w14
  CROSS JOIN perf_waste_15 w15
  CROSS JOIN perf_waste_16 w16
  CROSS JOIN perf_waste_17 w17
  CROSS JOIN perf_waste_18 w18
  CROSS JOIN perf_waste_19 w19
  CROSS JOIN perf_waste_20 w20
  CROSS JOIN perf_waste_21 w21
  CROSS JOIN perf_waste_22 w22
  CROSS JOIN perf_waste_23 w23
  CROSS JOIN perf_waste_24 w24
  WHERE w1.c >= 0 AND w2.c >= 0 AND w3.c >= 0 AND w4.c >= 0 AND w5.c >= 0 AND w6.c >= 0 AND w7.c >= 0 AND w8.c >= 0 AND w9.c >= 0 AND w10.c >= 0 AND w11.c >= 0 AND w12.c >= 0 AND w13.c >= 0 AND w14.c >= 0 AND w15.c >= 0 AND w16.c >= 0 AND w17.c >= 0 AND w18.c >= 0 AND w19.c >= 0 AND w20.c >= 0 AND w21.c >= 0 AND w22.c >= 0 AND w23.c >= 0 AND w24.c >= 0
)
SELECT *
FROM perf_degraded;
