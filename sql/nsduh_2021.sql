DROP TABLE IF EXISTS nsduh_2021;

CREATE TABLE nsduh_2021 (
  amhtxnd2 SMALLINT,         -- unmet need (perceived need but did not receive treatment)
  irwrkstat SMALLINT,        -- employment status
  age2 SMALLINT,             -- age category
  irsex SMALLINT,            -- sex
  newrace2 SMALLINT,         -- race/ethnicity
  ireduhighst2 SMALLINT,     -- education level
  filedate TEXT,             -- survey date
  analwt2_c DOUBLE PRECISION,-- person weight
  vestr_c INTEGER,           -- variance stratum
  verep INTEGER              -- variance replicate
);



-- rename cols for clarity
ALTER TABLE nsduh_2021 RENAME COLUMN amhtxnd2 TO unmet_need;
ALTER TABLE nsduh_2021 RENAME COLUMN irwrkstat TO employment_status;
ALTER TABLE nsduh_2021 RENAME COLUMN age2 TO age_group;
ALTER TABLE nsduh_2021 RENAME COLUMN irsex TO sex;
ALTER TABLE nsduh_2021 RENAME COLUMN newrace2 TO race_ethnicity;
ALTER TABLE nsduh_2021 RENAME COLUMN ireduhighst2 TO education_level;
ALTER TABLE nsduh_2021 RENAME COLUMN filedate TO survey_date;
ALTER TABLE nsduh_2021 RENAME COLUMN analwt2_c TO person_weight;
ALTER TABLE nsduh_2021 RENAME COLUMN vestr_c TO variance_stratum;
ALTER TABLE nsduh_2021 RENAME COLUMN verep TO variance_replicate;

SELECT COUNT(*) FROM nsduh_2021;
SELECT * FROM nsduh_2021 LIMIT 20;