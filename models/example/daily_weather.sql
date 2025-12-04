WITH daily_weather as (

    select 
    date(time) as daily_weather,
    WEATHER ,
    temp,
    PRESSURE,
    HUMIDITY,
    CLOUDS
    from {{ source('snowflake', 'weather') }}

    
),

daily_weather_agg as (

select
daily_weather,
weather ,
round(avg(temp),2) as avg_temp,
round(avg(PRESSURE),2) as agv_pressure,
round(avg(HUMIDITY),2) as avg_humidity,
round(avg(CLOUDS),2) as avg_clouds

from daily_weather
group by  daily_weather, weather

qualify ROW_NUMBER() OVER (PARTITION BY daily_weather ORDER BY count(weather) desc  ) =1

)

select 
*
from daily_weather_agg