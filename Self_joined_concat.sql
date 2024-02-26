WITH cte AS (
    SELECT *, CONCAT(ID, NAME) AS com_1 FROM emp
),
cte_s AS (
    SELECT c1.ID AS id1, c2.ID AS id2, c1.com_1 AS com_1_1, c2.com_1 AS com_1_2
    FROM cte c1
    JOIN cte c2 ON c1.ID <> c2.ID AND c1.ID - c2.ID = 1
)

SELECT Concat(com_1_2,'',com_1_1) systemm
FROM cte_s
WHERE id1 % 2 = 0;
