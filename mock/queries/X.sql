create
or replace table mock.X as
select
    week,
    community_area,
    is_end_of_year,
    sum(x_arson) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_arson,
    sum(x_assault) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_assault,
    sum(x_battery) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_battery,
    sum(x_burglary) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_burglary,
    sum(x_concealed_carry_license_violation) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_concealed_carry_license_violation,
    sum(x_crim_sexual_assault) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_crim_sexual_assault,
    sum(x_criminal_damage) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_criminal_damage,
    sum(x_criminal_sexual_assault) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_criminal_sexual_assault,
    sum(x_criminal_trespass) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_criminal_trespass,
    sum(x_deceptive_practice) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_deceptive_practice,
    sum(x_gambling) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_gambling,
    sum(x_homicide) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_homicide,
    sum(x_human_trafficking) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_human_trafficking,
    sum(x_interference_with_public_officer) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_interference_with_public_officer,
    sum(x_intimidation) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_intimidation,
    sum(x_kidnapping) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_kidnapping,
    sum(x_liquor_law_violation) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_liquor_law_violation,
    sum(x_motor_vehicle_theft) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_motor_vehicle_theft,
    sum(x_narcotics) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_narcotics,
    sum(x_non_criminal_subject_specified) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_non_criminal_subject_specified,
    sum(x_obscenity) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_obscenity,
    sum(x_offense_involving_children) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_offense_involving_children,
    sum(x_other_narcotic_violation) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_other_narcotic_violation,
    sum(x_other_offense) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_other_offense,
    sum(x_prostitution) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_prostitution,
    sum(x_public_indecency) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_public_indecency,
    sum(x_public_peace_violation) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_public_peace_violation,
    sum(x_ritualism) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_ritualism,
    sum(x_robbery) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_robbery,
    sum(x_sex_offense) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_sex_offense,
    sum(x_stalking) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_stalking,
    sum(x_theft) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_theft,
    sum(x_weapons_violation) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_weapons_violation,
    sum(x_is_domestic) over (
        partition by
            community_area
        order by
            week rows between 11 preceding
            and 0 preceding
    ) as agg_x_is_domestic,
    row_number() over (
        partition by
            community_area
        order by
            week
    ) as rn
from
    mock.full_pred
order by
    2,
    1