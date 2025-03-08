{{-
    config(materialized = 'table')
-}}

{{-
generate_fake_data (
    activity_name = 'submitted_form',
    has_revenue_impact = false,
    feature_json_dict = '{
        "channel": [
            "Owned",
            "Partner",
            "Self-Led",
            "Referral",
            "Other"
        ],
        "campaign": [
            "feb_event",
            "mar_event",
            "apr_event",
            "may_event",
            "jun_event",
            "jul_event",
            "aug_event"
        ],
        "page": [
            "Landing Page",
            "Product Page",
            "Blog Post",
            "Social Media",
            "Article",
            "Report"
        ]
    }'
  )
-}}
