{{-
    config(materialized = 'table')
-}}

{{-
generate_fake_data (
    activity_name = 'sdr_disqualified_prospect',
    has_revenue_impact = false,
    feature_json_dict = '{        "channel": [
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
        "org": [
            "Sales",
            "Marketing",
            "Engineering",
            "Management"
        ]}'
  )
-}}
