{{-
    config(materialized = 'table')
-}}

{{-
generate_fake_data (
    activity_name = 'lost_opportunity',
    has_revenue_impact = false,
    feature_json_dict = '{"tenure": [
        "0-1",
        "1-2",
        "2-3",
        "3-4",
        "4-5",
        "5-6",
        "6-7"
    ]}'  )
-}}
