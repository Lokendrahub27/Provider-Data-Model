{{ config(
    materialized='incremental',
    unique_key='PROVIDER_PRACTITIONER_LINK_HK'
) }}

{%- set yaml_metadata -%}
source_model: 
  - v_stg_practitioner
src_pk: PROVIDER_PRACTITIONER_LINK_HK
src_fk:
  - PROVIDER_HK
  - PRACTITIONER_HK
src_ldts: LOAD_DATETIME
src_source: SOURCE
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.link(
    source_model=metadata_dict['source_model'],
    src_pk=metadata_dict['src_pk'],
    src_fk=metadata_dict['src_fk'],
    src_ldts=metadata_dict['src_ldts'],
    src_source=metadata_dict['src_source']
) }}
