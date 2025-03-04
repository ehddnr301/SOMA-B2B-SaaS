{{-
    config(materialized = 'table')
-}}

{{-
generate_fake_data (
    activity_name = 'ended_subscription',
    has_revenue_impact = true,
    feature_json_dict = '{"segment": [
    "churn_risk_users",
    "churned_users",
    "canceled_users"
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
