{{-
    config(materialized = 'view')
-}}

{% set cube_tables = [
    ref('ga_cube_churned_subscriptions'),
    ref('ga_cube_churned_revenue'),
    ref('ga_cube_contraction_revenue'),
    ref('ga_cube_contraction_subscriptions'),
    ref('ga_cube_expansion_revenue'),
    ref('ga_cube_expansion_subscriptions'),
    ref('ga_cube_new_revenue'),
    ref('ga_cube_new_subscriptions'),
    ref('ga_cube_resurrected_revenue'),
    ref('ga_cube_resurrected_subscriptions'),
    ref('ga_cube_net_revenue'),
    ref('ga_cube_retained_subscriptions'),
    ref('ga_cube_retained_revenue'),
    ref('ga_cube_net_subscriptions'),
    ref('ga_cube_quick_ratio'),
    ref('ga_cube_total_revenue'),
    ref('ga_cube_total_subscriptions'),
    ref('ga_cube_committed_revenue'),
    ref('ga_cube_gross_revenue_churn'),
    ref('ga_cube_gross_revenue_churn_rate'),
    ref('ga_cube_net_revenue_churn'),
    ref('ga_cube_net_revenue_churn_rate'),
    ref('ga_cube_revenue_cmgr'),
    ref('ga_cube_gross_subscriptions_churn'),
    ref('ga_cube_revenue_growth_rate'),
    ref('ga_cube_subscriber_cmgr'),
    ref('ga_cube_subscriber_growth_rate'),
    ref('ga_cube_gross_dollar_retention'),
    ref('ga_cube_net_dollar_retention')
] %}

{{ dbt_utils.union_relations(relations = cube_tables) }}
