DROP TABLE IF EXISTS nsduh_2022_raw;

CREATE TABLE nsduh_2022_raw (
    MHTRTPY INT,
    MHTSHLDTX INT,
    MHTSKTHPY NUMERIC,     -- Must be NUMERIC to handle decimal/NaN values
    IRWRKSTAT INT,
    AGE2 INT,
    IRSEX INT,
    NEWRACE2 INT,
    IREDUHIGHST2 INT,
    FILEDATE TEXT,         -- Must be TEXT to handle date strings (e.g., '11/4/2024')
    ANALWT2_C NUMERIC,     -- Must be NUMERIC for the weight values
    VESTR_C INT,
    VEREP INT
);


-- Create new table that matches previous years schemas, based on raw data (subset) table, with calculated unmet_need, renamed
-- variables to match 2019-2021. Note: 2022 is a calculation and is derived 
-- from the three new variables. 



DROP TABLE IF EXISTS nsduh_2022;

CREATE TABLE nsduh_2022 AS
SELECT
    CASE
        WHEN mhtrtpy = 1 THEN 0
        WHEN mhtrtpy = 0 AND (mhtshldtx = 1 OR mhtskthpy = 1) THEN 1
        WHEN mhtrtpy = 0
             AND COALESCE(mhtshldtx, 2) IN (0, 2)
             AND COALESCE(mhtskthpy, 2) IN (0, 2) THEN 0
        ELSE NULL
    END AS unmet_need_revised,

    irwrkstat,
    age2,
    irsex,
    newrace2,
    ireduhighst2,
    filedate,
    analwt2_c,
    vestr_c,
    verep
FROM nsduh_2022_raw;


SELECT * from nsduh_2022_raw;

-- rename 2022 cols to match 2019-2021

ALTER TABLE nsduh_2022 RENAME COLUMN unmet_need_revised TO unmet_need;
ALTER TABLE nsduh_2022 RENAME COLUMN irwrkstat TO employment_status;
ALTER TABLE nsduh_2022 RENAME COLUMN age2 TO age_group;
ALTER TABLE nsduh_2022 RENAME COLUMN irsex TO sex;
ALTER TABLE nsduh_2022 RENAME COLUMN newrace2 TO race_ethnicity;
ALTER TABLE nsduh_2022 RENAME COLUMN ireduhighst2 TO education_level;
ALTER TABLE nsduh_2022 RENAME COLUMN filedate TO survey_date;
ALTER TABLE nsduh_2022 RENAME COLUMN analwt2_c TO person_weight;
ALTER TABLE nsduh_2022 RENAME COLUMN vestr_c TO variance_stratum;
ALTER TABLE nsduh_2022 RENAME COLUMN verep TO variance_replicate;

--Correct Data Types, namely DATE. 
-- Convert survey_date from text to DATE for 2019
ALTER TABLE nsduh_2019
    ALTER COLUMN survey_date TYPE date
    USING to_date(survey_date, 'MM/DD/YYYY');

-- Convert survey_date from text to DATE for 2020
ALTER TABLE nsduh_2020
    ALTER COLUMN survey_date TYPE date
    USING to_date(survey_date, 'MM/DD/YYYY');

-- Convert survey_date from text to DATE for 2021
ALTER TABLE nsduh_2021
    ALTER COLUMN survey_date TYPE date
    USING to_date(survey_date, 'MM/DD/YYYY');

-- Convert survey_date from text to DATE for 2022
ALTER TABLE nsduh_2022
    ALTER COLUMN survey_date TYPE date
    USING to_date(survey_date, 'MM/DD/YYYY');

-- Convert survey_date from text to DATE for 2023
ALTER TABLE nsduh_2023
    ALTER COLUMN survey_date TYPE date
    USING to_date(survey_date, 'MM/DD/YYYY');


--check, differences found in data types, new conversion necessary


-- Return column names and data types for nsduh_2019
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'nsduh_2019';

-- Return column names and data types for nsduh_2020
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'nsduh_2020';

-- Return column names and data types for nsduh_2021
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'nsduh_2021';

-- Return column names and data types for nsduh_2022
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'nsduh_2022';

-- Return column names and data types for nsduh_2023
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'nsduh_2023';

--Enforce data types for analysis due to methodology changes in 2022, 2023. 
ALTER TABLE nsduh_2019
    ALTER COLUMN unmet_need TYPE integer,
    ALTER COLUMN employment_status TYPE integer,
    ALTER COLUMN age_group TYPE integer,
    ALTER COLUMN sex TYPE integer,
    ALTER COLUMN race_ethnicity TYPE integer,
    ALTER COLUMN education_level TYPE integer,
    ALTER COLUMN survey_date TYPE date,
    ALTER COLUMN person_weight TYPE numeric,
    ALTER COLUMN variance_stratum TYPE integer,
    ALTER COLUMN variance_replicate TYPE integer;

ALTER TABLE nsduh_2020
    ALTER COLUMN unmet_need TYPE integer,
    ALTER COLUMN employment_status TYPE integer,
    ALTER COLUMN age_group TYPE integer,
    ALTER COLUMN sex TYPE integer,
    ALTER COLUMN race_ethnicity TYPE integer,
    ALTER COLUMN education_level TYPE integer,
    ALTER COLUMN survey_date TYPE date,
    ALTER COLUMN person_weight TYPE numeric,
    ALTER COLUMN variance_stratum TYPE integer,
    ALTER COLUMN variance_replicate TYPE integer;

ALTER TABLE nsduh_2021
    ALTER COLUMN unmet_need TYPE integer,
    ALTER COLUMN employment_status TYPE integer,
    ALTER COLUMN age_group TYPE integer,
    ALTER COLUMN sex TYPE integer,
    ALTER COLUMN race_ethnicity TYPE integer,
    ALTER COLUMN education_level TYPE integer,
    ALTER COLUMN survey_date TYPE date,
    ALTER COLUMN person_weight TYPE numeric,
    ALTER COLUMN variance_stratum TYPE integer,
    ALTER COLUMN variance_replicate TYPE integer;

