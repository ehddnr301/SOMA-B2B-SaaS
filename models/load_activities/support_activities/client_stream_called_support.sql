{{-
    config(materialized = 'table')
-}}

{{-
generate_fake_data (
    activity_name = 'called_supportf',
    has_revenue_impact = false,
    feature_json_dict = '{"segment": [
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
    "mrr_tier": ["tier1", "tier2", "tier3", "tier4", "tier5"],
    "plan": [
        "basic_plan",
        "standard_plan",
        "premium_plan",
        "monthly_plan",
        "annual_plan"
    ],
    "csm": ["chris", "john", "jane", "jim", "jill", "james"]}'
  )
-}}
