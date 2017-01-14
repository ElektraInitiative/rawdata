This repository contains the anonymized raw data
of the survey conducted from:

- 24.05 Start preparation
- 20.06 Survey is online
- 11.07 Reminder of survey
- 18.07 Official Deadline
        (Anywhere on Earth)


## Anonymization ##

The raw data was anonymized the following ways:

- The age was grouped
- FLOSS projects with a small number of participants
  were anonymized (got a number instead of its name)
- open questions were removed
  (non-anonymized people got an answer)


## R ##

To see an summary of the raw data, use:

	R --no-save < syntax.R

It uses `rawdata.csv`.
Names of columns/meanings of data are given in `syntax.R`.

## Libreoffice ##

`rawdata.ods` contains the raw data and basic statistics.
Some columns were removed/added for clearness.
