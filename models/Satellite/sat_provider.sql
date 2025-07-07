{{ config(materialized='incremental', unique_key='PROVIDER_HK') }}

{%- set yaml_metadata -%}
source_model: "v_stg_provider"
src_pk: "PROVIDER_HK"
src_hashdiff: "PROVIDER_HASHDIFF"
src_payload:
  - "PROVIDER_NAME"
  - "PROVIDER_TYPE"
  - "ADDRESS"
  - "PHONE_NUMBER"
src_ldts: "LOAD_DATETIME"
src_source: "SOURCE"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(
    source_model=metadata_dict['source_model'],
    src_pk=metadata_dict['src_pk'],
    src_hashdiff=metadata_dict['src_hashdiff'],
    src_payload=metadata_dict['src_payload'],
    src_ldts=metadata_dict['src_ldts'],
    src_source=metadata_dict['src_source']
) }}
