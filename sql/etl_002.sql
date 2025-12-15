-- Simple cross-tab of all NSDUH table columns
SELECT DISTINCT c.column_name,
       CASE WHEN t2019.column_name IS NOT NULL THEN '✓' END AS nsduh_2019,
       CASE WHEN t2020.column_name IS NOT NULL THEN '✓' END AS nsduh_2020,
       CASE WHEN t2021.column_name IS NOT NULL THEN '✓' END AS nsduh_2021,
       CASE WHEN t2022.column_name IS NOT NULL THEN '✓' END AS nsduh_2022,
       CASE WHEN t2023.column_name IS NOT NULL THEN '✓' END AS nsduh_2023
FROM (
  SELECT column_name FROM information_schema.columns
  WHERE table_schema='public' AND table_name IN ('nsduh_2019','nsduh_2020','nsduh_2021','nsduh_2022','nsduh_2023')
) c
LEFT JOIN (SELECT column_name FROM information_schema.columns WHERE table_schema='public' AND table_name='nsduh_2019') t2019 USING (column_name)
LEFT JOIN (SELECT column_name FROM information_schema.columns WHERE table_schema='public' AND table_name='nsduh_2020') t2020 USING (column_name)
LEFT JOIN (SELECT column_name FROM information_schema.columns WHERE table_schema='public' AND table_name='nsduh_2021') t2021 USING (column_name)
LEFT JOIN (SELECT column_name FROM information_schema.columns WHERE table_schema='public' AND table_name='nsduh_2022') t2022 USING (column_name)
LEFT JOIN (SELECT column_name FROM information_schema.columns WHERE table_schema='public' AND table_name='nsduh_2023') t2023 USING (column_name)
ORDER BY c.column_name;


UPDATE public.nsduh_2022
SET unmet_need = unmet_need_derived;

SELECT table_name, column_name
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name LIKE 'nsduh_%'
ORDER BY table_name, column_name;

ALTER TABLE public.nsduh_2022
DROP COLUMN IF EXISTS thought_should_get_treatment,
DROP COLUMN IF EXISTS received_treatment;

ALTER TABLE public.nsduh_2022
RENAME COLUMN unmet_need_derived TO unmet_need;

ALTER TABLE public.nsduh_2023
DROP COLUMN IF EXISTS thought_should_get_treatment,
DROP COLUMN IF EXISTS received_treatment;

ALTER TABLE public.nsduh_2023
RENAME COLUMN unmet_need_derived TO unmet_need;

SELECT * FROM nsduh_2022;

-- Failing pattern (unequal number of columns across SELECTs)
SELECT *
FROM public.nsduh_2019
UNION ALL
SELECT *
FROM public.nsduh_2020
UNION ALL
SELECT *
FROM public.nsduh_2021
UNION ALL
SELECT *
FROM public.nsduh_2022
UNION ALL
SELECT *
FROM public.nsduh_2023;




