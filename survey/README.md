This repository contains the anonymized raw data
of the survey conducted from:

- 24.05.2016 Start preparation
- 20.06.2016 Survey is online
- 11.07.2016 Reminder of survey
- 18.07.2016 Official Deadline
             (Anywhere on Earth)


## Anonymization ##

The raw data was anonymized the following ways:

- The age was grouped
- FLOSS projects with a small number of participants
  were anonymized (got a number instead of its name)
- open questions were removed
  (non-anonymized people got an answer)

## Donations ##


For 116 responses, we donated 3 € each, 348 € total:

- SPI (General Donation) 27 votes = 81 €
- GNOME (GNOME) 16 votes = 48 €
- KDE (KDE) 19 votes = 57 €
- Free Software Foundation Europe (FSFE) 31 votes = 93 €
- LimeSurvey (Lime) 5 votes = 15 €
- Mozilla (Firefox) 10 votes = 30 €
- Wikimedia Foundation (Wikipedia) 8 votes = 24 €


## R ##

To see an summary of the raw data, use:

	R --no-save < syntax.R

It uses `rawdata.csv`.
Names of columns/meanings of data are given in `syntax.R`.

## Libreoffice ##

`rawdata.ods` contains the raw data and basic statistics.
Some columns were removed/added for clearness.
