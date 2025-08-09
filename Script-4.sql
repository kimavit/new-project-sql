SELECT id_transaction,
       dt,
       total,
       ROUND((lg+total+ld)/3::NUMERIC, 2) AS sliding
FROM (
    SELECT id_transaction,
        dt,
        LAG(total) OVER(ORDER BY dt) AS lg,
        total,
        LEAD(total) OVER(ORDER BY dt) AS ld
    FROM
    (
        SELECT id_transaction,
            MAX(date) AS dt,
            SUM(sm) AS total
        FROM (
            SELECT id_transaction,
                date,
                CASE
                    WHEN type=1 THEN -sum
                    ELSE sum
                END sm
            FROM transactions
            ) t
    GROUP BY id_transaction
    ) t2
)t3
ORDER BY id_transaction
