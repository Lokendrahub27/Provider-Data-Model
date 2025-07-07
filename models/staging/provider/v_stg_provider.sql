{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 
  raw: "raw_provider"
derived_columns:
  SOURCE: "!1"
  LOAD_DATETIME: "UPDATED_AT"
  EFFECTIVE_FROM: "UPDATED_AT"
  START_DATE: "UPDATED_AT"
  END_DATE: "TO_DATE('9999-12-31')"
hashed_columns:
  PROVIDER_HK: "PROVIDER_ID"
  PROVIDER_TYPE_HK: "PROVIDER_TYPE"
  PROVIDER_HASHDIFF:
    is_hashdiff: true
    columns:
      - "PROVIDER_ID"
      - "PROVIDER_NAME"
      - "PROVIDER_TYPE"
      - "ADDRESS"
      - "PHONE_NUMBER"
      - "UPDATED_AT"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(
     include_source_columns=true,
     source_model=metadata_dict['source_model'],
     derived_columns=metadata_dict['derived_columns'],
     null_columns=none,
     hashed_columns=metadata_dict['hashed_columns'],
     ranked_columns=none
) }}
