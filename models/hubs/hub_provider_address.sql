{{ config(
    materialized='incremental',
    unique_key='ADDRESS_HK'
) }}

{%- set yaml_metadata -%}
source_model: 
    - v_stg_provider_address
src_pk: ADDRESS_HK
src_nk:
  - ADDRESS_ID
src_ldts: LOAD_DATETIME
src_source: SOURCE
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.hub(
    source_model=metadata_dict['source_model'],
    src_pk=metadata_dict['src_pk'],
    src_nk=metadata_dict['src_nk'],
    src_ldts=metadata_dict['src_ldts'],
    src_source=metadata_dict['src_source']
) }}
