{%-
  macro generate_fake_data (
    activity_name,
    feature_json_dict,
    has_revenue_impact = false
  )
-%}

with cte_sequence as (
    select unnest(generate_series(1,1000)) as id
)
, cte_entity as (
    select
        id,
        case when id%1000 = 0 then id%1000+1 else id%1000 end as entity_id
    from
        cte_sequence
)
, cte_date_spine as (
    select
        id,
        now() - to_seconds(floor(random()*id*1000)::int) as ts
    from
        cte_sequence
),
cte_feature_json_dict as (
    select
        '{{feature_json_dict}}' as feature_dict
),
cte_feature_json_dict_keys as (
    select
        unnest(json_keys(feature_dict)) as json_feature_key
    from
        cte_feature_json_dict
),
cte_feature_json_dict_values as (
    select
        feature_dict,
        json_feature_key,
        json_extract(feature_dict, json_feature_key) as json_feature_array,
        json_array_length(json_feature_array) as json_feature_array_length
    from
        cte_feature_json_dict
        cross join cte_feature_json_dict_keys
),
cte_feature_json_values as (
SELECT
    id,
    json_feature_key,
    feature_dict->>json_feature_key->>(
        MOD(
            CAST(
                '0x' || LEFT(MD5(id || json_feature_key), 8) AS UINT64
            ),
            json_feature_array_length
        )
    )::int AS json_feature_value
FROM
    cte_feature_json_dict_values
    CROSS JOIN cte_sequence
),
cte_feature_json as (
    select
        id,
        '{' || string_agg('"' || json_feature_key || '":"' || json_feature_value || '"', ',') || '}' as feature_json
    from
        cte_feature_json_values
    group by 1
)
select 
    cc.id,
    cc.entity_id,
    ds.ts as activity_ts,
    '{{activity_name}}' as activity,
    {% if has_revenue_impact == true %} round(random()*10000::float, 2) {% else %} 0 {% endif %} as revenue_impact,
    feature_json
from
    cte_entity cc
    join cte_date_spine ds
        on cc.id = ds.id
    join cte_feature_json jf
        on cc.id = jf.id
{% endmacro %}
