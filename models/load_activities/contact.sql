{{-
  config(materialized = 'table')
-}}

with cte_sequence as (
    select arrayJoin(range(1, 5001)) as id
),
cte_base as (
    select
        id,
        now() - toIntervalSecond(floor(rand() * id * 10000)) as create_date,
        'channel' || floor(50*rand())::int::text as first_touch_channel,
        'channel' || floor(50*rand())::int::text as last_touch_channel,
        'segment' || floor(30*rand())::int::text as segment
    from
        cte_sequence
)
select *, substring(date_trunc('month', create_date)::text, 1, 7) as cohort
from cte_base
