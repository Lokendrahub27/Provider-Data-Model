{{ config(materialized='incremental') }}

{%- set source_model = "v_stg_provider_address" -%}
{%- set src_pk = "PROVIDER_ADDRESS_LINK_HK" -%}
{%- set src_fk = ["PROVIDER_HK", "ADDRESS_HK"] -%}
{%- set src_ldts = "LOAD_DATETIME" -%}
{%- set src_source = "SOURCE" -%}

{{ automate_dv.link(
    src_pk=src_pk,
    src_fk=src_fk,
    src_ldts=src_ldts,
    src_source=src_source,
    source_model=source_model
) }}
