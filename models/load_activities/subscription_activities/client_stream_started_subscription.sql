{{-
    config(materialized = 'table')
-}}

{{-
generate_fake_data (
    activity_name = 'started_subscription',
    has_revenue_impact = true,
    feature_json_dict = '{"segment": [
    "active_users",
    "free_users",
    "paid_users",
    "new_users",
    "trial_users"
],
                         "plan": [
    "basic_plan",
    "standard_plan",
    "premium_plan",
    "monthly_plan",
    "annual_plan"
]}'
  )
-}}
