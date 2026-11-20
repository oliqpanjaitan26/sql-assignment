with temp as (
    select
        s.name,
        s.marks,
        g.grade
    from students s
    join grades g
        on marks between min_mark and max_mark
)


select
    case when grade < 8 then null else name end as name,
    grade,
    marks
from temp
order by 2 desc, 1, 3
;
