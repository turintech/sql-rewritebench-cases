WITH sales_base AS (
  SELECT cs.*, i.*, d.*
  FROM catalog_sales cs
  JOIN item i ON i_item_sk = cs_item_sk
  JOIN date_dim d ON d_date_sk = cs_sold_date_sk
  WHERE i_manufact_id = 361
    AND d_date between '2000-01-27' and (cast('2000-01-27' as date) + interval '90' day)
    AND d_date between '2000-01-27' and (cast('2000-01-27' as date) + interval '90' day)
)
SELECT sum(cs_ext_discount_amt) as "excess discount amount"
FROM (

  SELECT * FROM sales_base
) sales_wrapper
WHERE cs_ext_discount_amt > (
  select 1.3 * avg(cs_ext_discount_amt)
  from catalog_sales cs2
  join date_dim d2 on d2.d_date_sk = cs2.cs_sold_date_sk
  where cs2.cs_item_sk = sales_wrapper.cs_item_sk
    and d2.d_date between '2000-01-27' and (cast('2000-01-27' as date) + interval '90' day)
)
LIMIT 100;
