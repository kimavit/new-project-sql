SELECT employee, dt, lg, sm, ROUND((sm-lg)/lg::NUMERIC, 2) AS inc
FROM (
    SELECT employee, dt, lag(sm) OVER(PARTITION BY employee ORDER BY dt) AS lg, sm
    FROM (
        SELECT employee, date as dt, SUM(sum) AS sm
        FROM transactions
        WHERE type = 0
        GROUP BY employee, date
        ) t
    ) t2
ORDER BY employee, dt
