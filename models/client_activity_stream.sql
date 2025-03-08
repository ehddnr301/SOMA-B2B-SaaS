{{-
    config(
        materialized = 'table',
)
-}}

-- Returns a list of relations that match schema.prefix%
{% set all_tables = [
    ref('client_stream_decreased_contract'),
    ref('client_stream_incurred_overage'),
    ref('client_stream_ended_subscription'),
    ref('client_stream_expanded_contract'),
    ref('client_stream_active_on_subscription'),
    ref('client_stream_committed_to_churn'),
    ref('client_stream_resurrected_contract'),
    ref('client_stream_ordered_service'),
    ref('client_stream_renewed_contract'),
    ref('client_stream_started_subscription')
] %}

{% for table in all_tables %}
    select
        entity_id as id,
        entity_id as customer_id,
        activity,
        activity_ts,
        coalesce(revenue_impact, 0) as revenue_impact,
        coalesce(feature_json, '{}') as feature_json,
        0 as activity_occurrence
    from
        {{ table }}
{%- if not loop.last %}
union all
{%- endif -%}
{% endfor %}

--depends on: {{ ref('client_stream_decreased_contract') }}
--depends on: {{ ref('client_stream_incurred_overage') }}
--depends on: {{ ref('client_stream_ended_subscription') }}
--depends on: {{ ref('client_stream_expanded_contract') }}
--depends on: {{ ref('client_stream_active_on_subscription') }}
--depends on: {{ ref('client_stream_committed_to_churn') }}
--depends on: {{ ref('client_stream_resurrected_contract') }}
--depends on: {{ ref('client_stream_ordered_service') }}
--depends on: {{ ref('client_stream_renewed_contract') }}
--depends on: {{ ref('client_stream_started_subscription') }}