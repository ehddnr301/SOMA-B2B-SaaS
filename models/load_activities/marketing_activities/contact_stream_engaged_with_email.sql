{{-
    config(materialized = 'table')
-}}

{{-
generate_fake_data (
    activity_name = 'engaged_with_email',
    has_revenue_impact = false,
    feature_json_dict = '{"campaign": [
        "feb_event",
        "mar_event",
        "apr_event",
        "may_event",
        "jun_event",
        "jul_event",
        "aug_event"
    ]}'
  )
-}}
