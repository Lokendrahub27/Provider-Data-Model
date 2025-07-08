{{ config(materialized='incremental') }}

{%- set source_model = "v_stg_tax_info" -%}
{%- set src_pk = "TAX_HK" -%}
{%- set src_hashdiff = "TAX_HASHDIFF" -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "SOURCE" -%}

{{ automate_dv.sat(
    source_model = source_model,
    src_pk = src_pk,
    src_hashdiff = src_hashdiff,
    src_ldts = src_ldts,
    src_source = src_source
) }}
