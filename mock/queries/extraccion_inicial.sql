create
or replace table mock.crime as
SELECT
    unique_key,
    cast(date as date) fh,
    primary_type,
    location_description,
    arrest,
    community_area,
    domestic,
    latitude,
    longitude
FROM
    `bigquery-public-data.chicago_crime.crime`
where
    community_area is not null
    and latitude is not null
    and longitude is not null
    and date is not null
    and primary_type is not null
    and arrest is not null
    and location_description is not null
    and domestic is not null