create
or replace table mock.full_pred as
with
    catSemanas as (
        select distinct
            week,
            is_end_of_year
        from
            mock.predictors
    ),
    catComm as (
        select distinct
            community_area
        from
            mock.predictors
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
    is_end_of_year,
    coalesce(x_arson, 0) as x_arson,
    coalesce(x_assault, 0) as x_assault,
    coalesce(x_battery, 0) as x_battery,
    coalesce(x_burglary, 0) as x_burglary,
    coalesce(x_concealed_carry_license_violation, 0) as x_concealed_carry_license_violation,
    coalesce(x_crim_sexual_assault, 0) as x_crim_sexual_assault,
    coalesce(x_criminal_damage, 0) as x_criminal_damage,
    coalesce(x_criminal_sexual_assault, 0) as x_criminal_sexual_assault,
    coalesce(x_criminal_trespass, 0) as x_criminal_trespass,
    coalesce(x_deceptive_practice, 0) as x_deceptive_practice,
    coalesce(x_gambling, 0) as x_gambling,
    coalesce(x_homicide, 0) as x_homicide,
    coalesce(x_human_trafficking, 0) as x_human_trafficking,
    coalesce(x_interference_with_public_officer, 0) as x_interference_with_public_officer,
    coalesce(x_intimidation, 0) as x_intimidation,
    coalesce(x_kidnapping, 0) as x_kidnapping,
    coalesce(x_liquor_law_violation, 0) as x_liquor_law_violation,
    coalesce(x_motor_vehicle_theft, 0) as x_motor_vehicle_theft,
    coalesce(x_narcotics, 0) as x_narcotics,
    coalesce(x_non_criminal_subject_specified, 0) as x_non_criminal_subject_specified,
    coalesce(x_obscenity, 0) as x_obscenity,
    coalesce(x_offense_involving_children, 0) as x_offense_involving_children,
    coalesce(x_other_narcotic_violation, 0) as x_other_narcotic_violation,
    coalesce(x_other_offense, 0) as x_other_offense,
    coalesce(x_prostitution, 0) as x_prostitution,
    coalesce(x_public_indecency, 0) as x_public_indecency,
    coalesce(x_public_peace_violation, 0) as x_public_peace_violation,
    coalesce(x_ritualism, 0) as x_ritualism,
    coalesce(x_robbery, 0) as x_robbery,
    coalesce(x_sex_offense, 0) as x_sex_offense,
    coalesce(x_stalking, 0) as x_stalking,
    coalesce(x_theft, 0) as x_theft,
    coalesce(x_weapons_violation, 0) as x_weapons_violation,
    coalesce(x_is_domestic, 0) as x_is_domestic
from
    prodCart
    left outer join mock.predictors using (week, community_area, is_end_of_year)
order by
    2,
    1