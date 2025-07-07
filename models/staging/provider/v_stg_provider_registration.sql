{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  raw: "provider_registration"
derived_columns:
  SOURCE: "SOURCE"
  LOAD_DATETIME: "LOAD_DATETIME"
  EFFECTIVE_FROM: "REGISTRATION_DATE"
  START_DATE: "REGISTRATION_DATE"
  END_DATE: "VALID_UNTIL"
hashed_columns:
  PROVIDER_HK: "PROVIDER_ID"
  REGISTRATION_HK: "REGISTRATION_ID"
  PROVIDER_REGISTRATION_LINK_HK:
    - PROVIDER_ID
    - REGISTRATION_ID
  PROVIDER_REGISTRATION_HASHDIFF:
    is_hashdiff: true
    columns:
      - "PROVIDER_ID"
      - "REGISTRATION_ID"
      - "REGISTRATION_DATE"
      - "REGISTRATION_TYPE"
      - "VALID_UNTIL"
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
