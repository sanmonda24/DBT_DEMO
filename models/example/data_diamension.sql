WITH CTE AS (
  select 
  STARTED_AT
  
  from {{ source('snowflake', 'bike') }}
)

select 
* 
from CTE