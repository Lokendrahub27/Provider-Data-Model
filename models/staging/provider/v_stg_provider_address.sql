{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  raw: "provider_address"
derived_columns:
  SOURCE: "!1"
  LOAD_DATETIME: "LOAD_DATETIME"
  EFFECTIVE_FROM: "LOAD_DATETIME"
  START_DATE: "LOAD_DATETIME"
  END_DATE: "TO_DATE('9999-12-31')"
hashed_columns:
  ADDRESS_HK: "ADDRESS_ID"
  PROVIDER_HK: "PROVIDER_ID"
  PROVIDER_ADDRESS_LINK_HK:
    columns:
      - "PROVIDER_ID"
      - "ADDRESS_ID"
  ADDRESS_HASHDIFF:
    is_hashdiff: true
    columns:
      - "STREET"
      - "CITY"
      - "STATE"
      - "ZIP"
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
