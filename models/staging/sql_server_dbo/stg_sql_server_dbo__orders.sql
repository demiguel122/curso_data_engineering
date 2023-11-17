{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
         order_id,
         user_id,
         to_date(created_at) AS created_date,
         to_time(created_at) AS created_time,
         order_cost,
         status,
         shipping_service,
         shipping_cost,
         order_total,
         address_id,
         to_date(estimated_delivery_at) AS estimated_delivery_date,
         to_time(estimated_delivery_at) AS estimated_delivery_time,
         to_date(delivered_at) AS delivered_date,
         to_time(delivered_at) AS delivered_time,
         tracking_id,
         promo_id,
         _fivetran_synced AS date_loaded
    FROM src_orders
    )

SELECT * FROM renamed_casted