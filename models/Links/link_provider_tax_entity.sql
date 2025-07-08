{{ config(materialized='incremental') }}

{%- set source_model = "v_stg_tax_info" -%}
{%- set src_pk = "PROVIDER_TAX_ENTITY_LINK_HK" -%}
{%- set src_fk = ["PROVIDER_HK", "TAX_HK"] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "SOURCE" -%}

{{ automate_dv.link(
    source_model = source_model,
    src_pk = src_pk,
    src_fk = src_fk,
    src_ldts = src_ldts,
    src_source = src_source
) }}
