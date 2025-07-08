{{ config(
    materialized = 'incremental',
    unique_key = 'TAX_HK'
) }}

{%- set source_model = 'v_stg_tax_info' -%}
{%- set src_pk = 'TAX_HK' -%}
{%- set src_nk = ['TAX_ID'] -%}
{%- set src_ldts = 'LOAD_DATETIME' -%}
{%- set src_source = 'SOURCE' -%}

{{ automate_dv.hub(
    source_model = source_model,
    src_pk = src_pk,
    src_nk = src_nk,
    src_ldts = src_ldts,
    src_source = src_source
) }}
