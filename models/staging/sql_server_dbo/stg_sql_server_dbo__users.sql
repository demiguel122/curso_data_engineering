{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

renamed_casted AS (
    SELECT
         user_id,
         first_name,
         last_name,
         email,
         phone_number,
         total_orders,
         address_id,
         to_date(created_at) AS created_date,
         to_time(created_at) AS created_time,
         to_date(updated_at) AS updated_date,
         to_time(updated_at) AS updated_time,
         _fivetran_synced AS date_loaded
    FROM src_users
    )

SELECT * FROM renamed_casted