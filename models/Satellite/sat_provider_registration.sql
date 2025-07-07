{{ config(
    materialized='incremental',
    unique_key='PROVIDER_REGISTRATION_HASHDIFF'
) }}

{%- set yaml_metadata -%}
source_model: "v_stg_provider_registration"

src_pk: "PROVIDER_REGISTRATION_LINK_HK"
src_hashdiff: "PROVIDER_REGISTRATION_HASHDIFF"
src_payload:
  - "PROVIDER_ID"
  - "REGISTRATION_ID"
  - "REGISTRATION_DATE"
  - "REGISTRATION_TYPE"
  - "VALID_UNTIL"
src_eff: "EFFECTIVE_FROM"
src_ldts: "LOAD_DATETIME"
src_source: "SOURCE"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(
    source_model=metadata_dict['source_model'],
    src_pk=metadata_dict['src_pk'],
    src_hashdiff=metadata_dict['src_hashdiff'],
    src_payload=metadata_dict['src_payload'],
    src_eff=metadata_dict['src_eff'],
    src_ldts=metadata_dict['src_ldts'],
    src_source=metadata_dict['src_source']
) }}
