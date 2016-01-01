-- Problem 1
-----------------------

-- Part a
SELECT COUNT(*) 
FROM frequency 
WHERE docid='10398_txt_earn';

-- Part b
SELECT COUNT(*) FROM (
     SELECT term FROM frequency
     WHERE docid='10398_txt_earn'
     AND count=1
);

-- Part c
SELECT COUNT(*) FROM(
     SELECT term FROM frequency
     WHERE docid='10398_txt_earn'
     AND count = 1
     UNION
     SELECT term FROM frequency
     WHERE docid='925_txt_trade'
     AND count = 1
);

-- Part d
SELECT COUNT(*) FROM (
     SELECT DISTINCT docid
     FROM frequency
     WHERE term = 'law' OR term = 'legal'
);

-- Part e
SELECT COUNT(*) FROM(
     SELECT docid FROM frequency
     GROUP BY docid
     HAVING COUNT(*) > 300
);

-- Part f
SELECT COUNT(*) FROM(
     SELECT docid FROM frequency
     WHERE term = 'transactions'
     INTERSECT
     SELECT docid FROM frequency
     WHERE term = 'world'
);

-- Problem 3
----------------------

-- Part h
SELECT A.docid, B.docid, SUM(A.count*B.count)
FROM frequency as A, frequency as B
ON A.term=B.term
WHERE A.docid < B.docid
AND A.docid='10080_txt_crude'
AND B.docid='17035_txt_earn';

-- Part i
CREATE VIEW query AS
SELECT * FROM frequency
UNION
SELECT 'q' as docid, 'washington' as term, 1 as count
UNION
SELECT 'q' as docid, 'taxes' as term, 1 as count
UNION
SELECT 'q' as docid, 'treasury' as term, 1 as count;

SELECT A.docid, B.docid, SUM(A.count*B.count) as s
FROM frequency as A, query as B
ON A.term=B.term
WHERE B.docid = 'q'
AND A.docid < B.docid
GROUP BY A.docid
ORDER BY s DESC
LIMIT 10;


