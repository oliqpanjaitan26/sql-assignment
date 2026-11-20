with temp1 as (
    select
        cha.challenge_id,
        dif.score as max_score
    from challenges cha
    join difficulty dif on dif.difficulty_level = cha.difficulty_level
)
, temp2 AS (
    SELECT
        sub.hacker_id,
        COUNT(DISTINCT sub.challenge_id) AS total_challenge
    FROM submissions sub
    JOIN temp1 te1
        ON sub.challenge_id = te1.challenge_id
    WHERE sub.score = te1.max_score
    GROUP BY 1
    HAVING COUNT(DISTINCT sub.challenge_id) > 1
)
, temp3 AS (
    SELECT
        hac.hacker_id,
        hac.name,
        te2.total_challenge
    FROM temp2 te2
    JOIN hackers hac
        ON te2.hacker_id = hac.hacker_id
)
SELECT
    hacker_id,
    name
FROM temp3
ORDER BY
    total_challenge DESC, 1;
