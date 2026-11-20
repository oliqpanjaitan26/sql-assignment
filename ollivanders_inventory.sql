with temp as (
SELECT
    w.id,
    w.coins_needed,
    wp.age,
    w.power,
    wp.is_evil,
    min(w.coins_needed) over(partition by wp.age, w.power) as min_coins_needed
from wands w
join wands_property wp on wp.code = w.code
where wp.is_evil = 0
)


select
    id,
    age,
    coins_needed,
    power
from temp
where coins_needed = min_coins_needed
order by power desc, age desc
;
