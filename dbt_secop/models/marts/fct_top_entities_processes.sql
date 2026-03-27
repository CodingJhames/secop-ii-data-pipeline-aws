{{ config(materialized='table') }}

select
    entity_name,
    department,
    count(process_id) as total_processes
from {{ ref('stg_secop_contracts') }}
group by 1, 2
order by total_processes desc
