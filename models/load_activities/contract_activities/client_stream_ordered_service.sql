{{-
    config(materialized = 'table')
-}}

{{-
generate_fake_data (
    activity_name = 'ordered_service',
    has_revenue_impact = true,
    feature_json_dict = '{"service": ["service1", "service2", "service3"],
"segment": [
    "active_users",
        "churn_risk_users",
        "churned_users",
        "free_users",
        "paid_users",
        "grace_period_users",
        "canceled_users",
        "new_users",
        "returning_users",
        "trial_users"
    ],
    "plan": [
        "basic_plan",
        "standard_plan",
        "premium_plan",
        "monthly_plan",
        "annual_plan",
        "lifetime_plan"
    ]}'
  )
-}}
