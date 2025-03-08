{%-
  macro generate_fake_data (
    activity_name,
    feature_json_dict,
    has_revenue_impact = false
  )
-%}

WITH 
cte_sequence AS (
    SELECT arrayJoin(range(1, 1001)) AS id
),
cte_entity AS (
    SELECT 
        id, 
        if(id % 1000 = 0, 1, id % 1000) AS entity_id
    FROM cte_sequence
),
cte_date_spine AS (
    SELECT 
        id, 
        now() - INTERVAL toUInt32(rand() % (id * 1000)) SECOND AS ts
    FROM cte_sequence
),
cte_feature_json_dict AS (
    SELECT JSONExtract('{{ feature_json_dict }}', 'Map(String, Array(String))') AS feature_dict
),
cte_feature_json_dict_keys AS (
    SELECT arrayJoin(mapKeys(feature_dict)) AS json_feature_key
    FROM cte_feature_json_dict
),
cte_feature_json_dict_values AS (
    SELECT 
        feature_dict,
        json_feature_key,
        feature_dict[json_feature_key] AS json_feature_array,
        length(feature_dict[json_feature_key]) AS json_feature_array_length
    FROM cte_feature_json_dict
    CROSS JOIN cte_feature_json_dict_keys
),
cte_feature_json_values AS (
    SELECT 
        id, 
        json_feature_key, 
        feature_dict[json_feature_key][
            reinterpretAsUInt64(reverse(unhex(left(MD5(concat(toString(id), json_feature_key)), 16)))) 
            % json_feature_array_length + 1
        ] AS json_feature_value
    FROM cte_feature_json_dict_values
    CROSS JOIN cte_sequence
),
cte_feature_json AS (
    SELECT 
        id,
        '{' || arrayStringConcat(
            arrayMap((k, v) -> concat('"', k, '":"', v, '"'), 
            groupArray(json_feature_key), groupArray(json_feature_value)), 
        ',') || '}' AS feature_json
    FROM cte_feature_json_values
    GROUP BY id
)
    SELECT 
        cc.id AS id,
        cc.entity_id AS entity_id,
        ds.ts AS activity_ts,
        '{{ activity_name }}' AS activity,
        {% if has_revenue_impact == true %} round(rand() * 10000, 2) {% else %} 0 {% endif %} AS revenue_impact,
        feature_json AS feature_json
    FROM cte_entity cc
    JOIN cte_date_spine ds ON cc.id = ds.id
    JOIN cte_feature_json jf ON cc.id = jf.id
{% endmacro %}
