{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model:
  raw: "practitioner"
derived_columns:
  SOURCE: "!1"
  LOAD_DATETIME: "LOAD_DATETIME"
  EFFECTIVE_FROM: "LOAD_DATETIME"
  START_DATE: "LOAD_DATETIME"
  END_DATE: "TO_DATE('9999-12-31')"
hashed_columns:
  PRACTITIONER_HK: "PRACTITIONER_ID"
  PROVIDER_HK: "PROVIDER_ID"
  PROVIDER_PRACTITIONER_LINK_HK:
    - PROVIDER_ID
    - PRACTITIONER_ID
  PRACTITIONER_HASHDIFF:
    is_hashdiff: true
    columns:
      - "PRACTITIONER_ID"
      - "PROVIDER_ID"
      - "PRACTITIONER_NAME"
      - "SPECIALITY"
      - "LICENSE_NUMBER"
      - "LOAD_DATETIME"
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
