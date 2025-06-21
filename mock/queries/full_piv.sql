create
or replace table mock.full_piv as
with
    catSemanas as (
        select distinct
            week
        from
            mock.piv
    ),
    catComm as (
        select distinct
            community_area
        from
            mock.piv
    ),
    prodCart as (
        select
            *
        from
            catSemanas,
            catComm
    )
select
    week,
    community_area,
    coalesce(criminal_sexual_assault, 0) as criminal_sexual_assault,
    coalesce(homicide, 0) as homicide,
    coalesce(human_trafficking, 0) as human_trafficking,
    coalesce(kidnapping, 0) as kidnapping,
    coalesce(robbery, 0) as robbery
from
    prodCart
    left outer join mock.piv using (week, community_area)
order by
    2,
    1