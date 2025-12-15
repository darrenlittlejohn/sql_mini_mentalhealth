DROP TABLE IF EXISTS nsduh_2023_raw;

CREATE TABLE nsduh_2023_raw (
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


-- Create new table based on raw table, with calculated unmet_need, renamed
-- variables to match 2019-2021. Note: 2023 is a calculation and is derived 
-- from the three new variables. 



DROP TABLE IF EXISTS nsduh_2023;

CREATE TABLE nsduh_2023 AS
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
FROM nsduh_2023_raw;


SELECT * from nsduh_2023_raw;

-- rename 2023 cols to match 2019-2021

ALTER TABLE nsduh_2023 RENAME COLUMN unmet_need_revised TO unmet_need;
ALTER TABLE nsduh_2023 RENAME COLUMN irwrkstat TO employment_status;
ALTER TABLE nsduh_2023 RENAME COLUMN age2 TO age_group;
ALTER TABLE nsduh_2023 RENAME COLUMN irsex TO sex;
ALTER TABLE nsduh_2023 RENAME COLUMN newrace2 TO race_ethnicity;
ALTER TABLE nsduh_2023 RENAME COLUMN ireduhighst2 TO education_level;
ALTER TABLE nsduh_2023 RENAME COLUMN filedate TO survey_date;
ALTER TABLE nsduh_2023 RENAME COLUMN analwt2_c TO person_weight;
ALTER TABLE nsduh_2023 RENAME COLUMN vestr_c TO variance_stratum;
ALTER TABLE nsduh_2023 RENAME COLUMN verep TO variance_replicate;
