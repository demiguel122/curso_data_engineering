{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ ref('base_sql_server_dbo__promos') }}
    ),

renamed_casted AS (
    SELECT
         promo_id,
         discount,
         status,
         _fivetran_synced AS date_loaded
    FROM src_promos
    )

SELECT * FROM renamed_casted