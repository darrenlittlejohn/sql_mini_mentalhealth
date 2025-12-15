SELECT 
    table_schema,
    table_name,
    COUNT(*) AS column_count
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name LIKE 'nsduh_%'  -- <— adjust this pattern to match your tables
GROUP BY table_schema, table_name
ORDER BY table_name;

SELECT 
    table_schema,
    table_name,
    ordinal_position,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name LIKE 'nsduh_%'
ORDER BY table_name, ordinal_position;


CREATE OR REPLACE VIEW nsduh_all AS
SELECT *, 2019 AS year FROM nsduh_2019
UNION ALL
SELECT *, 2020 AS year FROM nsduh_2020
UNION ALL
SELECT *, 2021 AS year FROM nsduh_2021
UNION ALL
SELECT *, 2022 AS year FROM nsduh_2022
UNION ALL
SELECT *, 2023 AS year FROM nsduh_2023;

SELECT year, COUNT(*) AS total_rows
FROM nsduh_all
GROUP BY year
ORDER BY year;

-- columns unique to each table
SELECT '2019_only' AS scope, column_name FROM information_schema.columns
 WHERE table_schema='public' AND table_name='nsduh_2019'
 EXCEPT SELECT column_name FROM information_schema.columns
 WHERE table_schema='public' AND table_name IN ('nsduh_2020','nsduh_2021','nsduh_2022','nsduh_2023')
UNION ALL
SELECT '2020_only', column_name FROM information_schema.columns
 WHERE table_schema='public' AND table_name='nsduh_2020'
 EXCEPT SELECT column_name FROM information_schema.columns
 WHERE table_schema='public' AND table_name IN ('nsduh_2019','nsduh_2021','nsduh_2022','nsduh_2023')
UNION ALL
SELECT '2021_only', column_name FROM information_schema.columns
 WHERE table_schema='public' AND table_name='nsduh_2021'
 EXCEPT SELECT column_name FROM information_schema.columns
 WHERE table_schema='public' AND table_name IN ('nsduh_2019','nsduh_2020','nsduh_2022','nsduh_2023')
UNION ALL
SELECT '2022_only', column_name FROM information_schema.columns
 WHERE table_schema='public' AND table_name='nsduh_2022'
 EXCEPT SELECT column_name FROM information_schema.columns
 WHERE table_schema='public' AND table_name IN ('nsduh_2019','nsduh_2020','nsduh_2021','nsduh_2023')
UNION ALL
SELECT '2023_only', column_name FROM information_schema.columns
 WHERE table_schema='public' AND table_name='nsduh_2023'
 EXCEPT SELECT column_name FROM information_schema.columns
 WHERE table_schema='public' AND table_name IN ('nsduh_2019','nsduh_2020','nsduh_2021','nsduh_2022')
ORDER BY scope, column_name;



