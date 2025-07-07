{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  raw: "pharmacy"
derived_columns:
  SOURCE: "SOURCE"
  LOAD_DATETIME: "LOAD_DATETIME"
  EFFECTIVE_FROM: "LOAD_DATETIME"
  START_DATE: "LOAD_DATETIME"
  END_DATE: "TO_DATE('9999-12-31')"
hashed_columns:
  PHARMACY_HK: "PHARMACY_ID"
  PROVIDER_HK: "PROVIDER_ID"
  LICENSE_HK: "LICENSE_ID"
  PHARMACY_HASHDIFF:
    is_hashdiff: true
    columns:
      - "PHARMACY_ID"
      - "PHARMACY_NAME"
      - "PROVIDER_ID"
      - "LICENSE_ID"
      - "LOCATION"
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
