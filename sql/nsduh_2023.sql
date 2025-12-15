DROP TABLE IF EXISTS nsduh_2023;

CREATE TABLE nsduh_2023 (
  mhtrtpy SMALLINT,         -- received mental health treatment past year (0/1)
  mhtshldtx SMALLINT,        -- thought should get treatment (0/1)
  mhtskthpy SMALLINT,        -- unmet need derived variable (1=yes, 2=no)
  irwrkstat SMALLINT,        -- employment status
  age2 SMALLINT,             -- age category
  irsex SMALLINT,            -- sex
  newrace2 SMALLINT,         -- race/ethnicity
  ireduhighst2 SMALLINT,     -- education level
  filedate TEXT,             -- survey date
  analwt2_c DOUBLE PRECISION, -- person weight
  vestr_c INTEGER,            -- variance stratum
  verep INTEGER              -- variance replicate
);

-- rename cols for clarity
ALTER TABLE nsduh_2023 RENAME COLUMN mhtrtpy TO received_treatment;
ALTER TABLE nsduh_2023 RENAME COLUMN mhtshldtx TO thought_should_get_treatment;
ALTER TABLE nsduh_2023 RENAME COLUMN mhtskthpy TO unmet_need_derived;
ALTER TABLE nsduh_2023 RENAME COLUMN irwrkstat TO employment_status;
ALTER TABLE nsduh_2023 RENAME COLUMN age2 TO age_group;
ALTER TABLE nsduh_2023 RENAME COLUMN irsex TO sex;
ALTER TABLE nsduh_2023 RENAME COLUMN newrace2 TO race_ethnicity;
ALTER TABLE nsduh_2023 RENAME COLUMN ireduhighst2 TO education_level;
ALTER TABLE nsduh_2023 RENAME COLUMN filedate TO survey_date;
ALTER TABLE nsduh_2023 RENAME COLUMN analwt2_c TO person_weight;
ALTER TABLE nsduh_2023 RENAME COLUMN vestr_c TO variance_stratum;
ALTER TABLE nsduh_2023 RENAME COLUMN verep TO variance_replicate;

-- derive unmet_need flag harmonized with 2019–2021 AMHTXND2
ALTER TABLE nsduh_2023 ADD COLUMN unmet_need SMALLINT;

UPDATE nsduh_2023
SET unmet_need = CASE
  WHEN received_treatment = 1 THEN 0
  WHEN received_treatment = 0 AND (thought_should_get_treatment = 1 OR unmet_need_derived = 1) THEN 1
  WHEN received_treatment = 0 AND COALESCE(thought_should_get_treatment,2) IN (0,2) AND COALESCE(unmet_need_derived,2) IN (0,2) THEN 0
  ELSE NULL
END;

SELECT COUNT(*) FROM nsduh_2023;
SELECT * FROM nsduh_2023 LIMIT 20;
