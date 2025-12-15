DROP TABLE IF EXISTS nsduh_2020;

CREATE TABLE nsduh_2020 (
  amhtxnd2 SMALLINT, -- unmet need (perceived need but did not receive treatment)
  irwrkstat SMALLINT, -- employment status
  age2 SMALLINT, -- age category
  irsex SMALLINT, -- sex
  newrace2 SMALLINT, -- race/ethnicity
  ireduhighst2 SMALLINT, -- education level
  filedate TEXT, -- survey date
  analwtq1q4_c DOUBLE PRECISION, -- person weight
  vestrq1q4_c INTEGER, -- variance stratum
  verep INTEGER -- variance replicate

);

 -- rename cols for clarity
ALTER TABLE nsduh_2020 RENAME COLUMN amhtxnd2 TO unmet_need;
ALTER TABLE nsduh_2020 RENAME COLUMN irwrkstat TO employment_status;
ALTER TABLE nsduh_2020 RENAME COLUMN age2 TO age_group;
ALTER TABLE nsduh_2020 RENAME COLUMN irsex TO sex;
ALTER TABLE nsduh_2020 RENAME COLUMN newrace2 TO race_ethnicity;
ALTER TABLE nsduh_2020 RENAME COLUMN ireduhighst2 TO education_level;
ALTER TABLE nsduh_2020 RENAME COLUMN filedate TO survey_date;
ALTER TABLE nsduh_2020 RENAME COLUMN analwtq1q4_c TO person_weight;
ALTER TABLE nsduh_2020 RENAME COLUMN vestrq1q4_c TO variance_stratum;
ALTER TABLE nsduh_2020 RENAME COLUMN verep TO variance_replicate;

SELECT COUNT(*) FROM nsduh_2020;
SELECT * FROM nsduh_2020 LIMIT 20;

--due to a change in some vabiable names in 2020, we had to make some changes to the tables from 2019 to match the new naming convention. This is some ai (advanced SQL) to compare col names. would be easy in R or Python.
WITH cols_2020 AS (
  SELECT ROW_NUMBER() OVER (ORDER BY COLUMN_NAME) AS rn, COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME = 'nsduh_2020'
),
cols_2019 AS (
  SELECT ROW_NUMBER() OVER (ORDER BY COLUMN_NAME) AS rn, COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME = 'nsduh_2019'
)
SELECT 
  cols_2020.COLUMN_NAME AS nsduh_2020_column,
  cols_2019.COLUMN_NAME AS nsduh_2019_column
FROM cols_2020
FULL OUTER JOIN cols_2019 ON cols_2020.rn = cols_2019.rn
ORDER BY COALESCE(cols_2020.rn, cols_2019.rn);
