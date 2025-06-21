create
or replace table mock.tgt as
with
    winAgg as (
        SELECT
            week,
            community_area,
            sum(criminal_sexual_assault) over (
                partition by
                    community_area
                order by
                    week rows between 1 following
                    and 2 following
            ) as tgt_criminal_sexual_assault,
            sum(homicide) over (
                partition by
                    community_area
                order by
                    week rows between 1 following
                    and 2 following
            ) as tgt_homicide,
            sum(human_trafficking) over (
                partition by
                    community_area
                order by
                    week rows between 1 following
                    and 2 following
            ) as tgt_human_trafficking,
            sum(kidnapping) over (
                partition by
                    community_area
                order by
                    week rows between 1 following
                    and 2 following
            ) as tgt_kidnapping,
            sum(robbery) over (
                partition by
                    community_area
                order by
                    week rows between 1 following
                    and 2 following
            ) as tgt_robbery,
            row_number() over (
                partition by
                    community_area
                order by
                    week
            ) as rn
        FROM
            `mock.full_piv`
        where
            week not in ('2025-22', '2025-23')
    )
select
    week,
    community_area,
    case
        when tgt_criminal_sexual_assault > 0 then 1
        else 0
    end as tgt_criminal_sexual_assault,
    case
        when tgt_homicide > 0 then 1
        else 0
    end as tgt_homicide,
    case
        when tgt_human_trafficking > 0 then 1
        else 0
    end as tgt_human_trafficking,
    case
        when tgt_kidnapping > 0 then 1
        else 0
    end as tgt_kidnapping,
    case
        when tgt_robbery > 0 then 1
        else 0
    end as tgt_robbery
from
    winAgg