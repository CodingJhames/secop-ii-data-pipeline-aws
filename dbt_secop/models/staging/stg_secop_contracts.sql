{{ config(materialized='view') }}

select
    id_del_proceso as process_id,
    entidad as entity_name,
    nit_entidad as entity_nit,
    departamento_entidad as department,
    ciudad_entidad as city,
    ordenentidad as entity_order
from {{ source('athena_source', 'raw') }}
