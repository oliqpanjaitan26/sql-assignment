with temp as (
    SELECT
    hacker_id,
    challenge_id,
    max(score) as max_score
from submissions
group by 1, 2
)


, temp2 as (
    SELECT
hacker_id,
sum(max_score) as total_score
from temp
group by 1
)


SELECT
hac.hacker_id,
hac.name,
te2.total_score
from temp2 te2
join hackers hac on hac.hacker_id = te2.hacker_id
where te2.total_score > 0
order by 3 desc, 1
;
