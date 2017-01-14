data <- read.csv("rawdata.csv", quote = "'\"", na.strings=c("", "\"\""), stringsAsFactors=FALSE, fileEncoding="UTF-8")


# LimeSurvey Field type: F
data[, 1] <- as.numeric(data[, 1])
attributes(data)$variable.labels[1] <- "id"
names(data)[1] <- "id"
# LimeSurvey Field type: F
data[, 2] <- as.numeric(data[, 2])
attributes(data)$variable.labels[2] <- "How old are you?"
names(data)[2] <- "age"
# LimeSurvey Field type: A
data[, 3] <- as.character(data[, 3])
attributes(data)$variable.labels[3] <- "Which country are you from?"
data[, 3] <- factor(data[, 3], levels=c("AF","AL","DZ","AS","AD","AO","AI","AQ","AG","AR","AM","AW","AU","AT","AZ","BS","BH","BD","BB","BY","BE","BZ","BJ","BM","BT","BO","BA","BW","BR","IO","VG","BN","BG","BF","BI","KH","CM","CA","CV","KY","CF","TD","CL","CN","CX","CC","CO","KM","CK","CR","HR","CU","CW","CY","CZ","CD","DK","DJ","DM","DO","TL","EC","EG","SV","GQ","ER","EE","ET","FK","FO","FJ","FI","FR","PF","GA","GM","GE","DE","GH","GI","GR","GL","GD","GU","GT","GG","GN","GW","GY","HT","HN","HK","HU","IS","IN","ID","IR","IQ","IE","IM","IL","IT","CI","JM","JP","JE","JO","KZ","KE","KI","XK","KW","KG","LA","LV","LB","LS","LR","LY","LI","LT","LU","MO","MK","MG","MW","MY","MV","ML","MT","MH","MR","MU","YT","MX","FM","MD","MC","MN","ME","MS","MA","MZ","MM","NA","NR","NP","NL","AN","NC","NZ","NI","NE","NG","NU","KP","MP","NO","OM","PK","PW","PS","PA","PG","PY","PE","PH","PN","PL","PT","PR","QA","CG","RE","RO","RU","RW","BL","SH","KN","LC","MF","PM","VC","WS","SM","ST","SA","SN","RS","SC","SL","SG","SX","SK","SI","SB","SO","ZA","KR","SS","ES","LK","SD","SR","SJ","SZ","SE","CH","SY","TW","TJ","TZ","TH","TG","TK","TO","TT","TN","TR","TM","TC","TV","VI","UG","UA","AE","GB","US","UY","UZ","VU","VA","VE","VN","WF","EH","YE","ZM","ZW"),labels=c("Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "British Indian Ocean Territory", "British Virgin Islands", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos Islands", "Colombia", "Comoros", "Cook Islands", "Costa Rica", "Croatia", "Cuba", "Curacao", "Cyprus", "Czech Republic", "Democratic Republic of the Congo", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "Finland", "France", "French Polynesia", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guam", "Guatemala", "Guernsey", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Ivory Coast", "Jamaica", "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kosovo", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macao", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "North Korea", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Republic of the Congo", "Reunion", "Romania", "Russia", "Rwanda", "Saint Barthelemy", "Saint Helena", "Saint Kitts and Nevis", "Saint Lucia", "Saint Martin", "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Sint Maarten", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Svalbard and Jan Mayen", "Swaziland", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "U.S. Virgin Islands", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican", "Venezuela", "Vietnam", "Wallis and Futuna", "Western Sahara", "Yemen", "Zambia", "Zimbabwe"))
names(data)[3] <- "country"
# LimeSurvey Field type: A
data[, 4] <- as.character(data[, 4])
attributes(data)$variable.labels[4] <- "Which is the highest degree that you have?"
data[, 4] <- factor(data[, 4], levels=c("a1","a2","a3","a4","a5"),labels=c("no degree", "still a student", "bachelor", "master", "phd"))
names(data)[4] <- "education"
# LimeSurvey Field type: F
data[, 5] <- as.numeric(data[, 5])
attributes(data)$variable.labels[5] <- "[software developer] What is your occupation?"
data[, 5] <- factor(data[, 5], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[5] <- "occupation_a1"
# LimeSurvey Field type: F
data[, 6] <- as.numeric(data[, 6])
attributes(data)$variable.labels[6] <- "[administrator] What is your occupation?"
data[, 6] <- factor(data[, 6], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[6] <- "occupation_a2"
# LimeSurvey Field type: F
data[, 7] <- as.numeric(data[, 7])
attributes(data)$variable.labels[7] <- "[student] What is your occupation?"
data[, 7] <- factor(data[, 7], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[7] <- "occupation_a3"
# LimeSurvey Field type: F
data[, 8] <- as.numeric(data[, 8])
attributes(data)$variable.labels[8] <- "[researcher] What is your occupation?"
data[, 8] <- factor(data[, 8], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[8] <- "occupation_a4"
# LimeSurvey Field type: F
data[, 9] <- as.numeric(data[, 9])
attributes(data)$variable.labels[9] <- "[other] What is your occupation?"
data[, 9] <- factor(data[, 9], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[9] <- "occupation_a5"
# LimeSurvey Field type: A
data[, 10] <- as.character(data[, 10])
attributes(data)$variable.labels[10] <- "[Project 1] [Project name] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[10] <- "flossprojects_p1_name"
# LimeSurvey Field type: A
data[, 11] <- as.character(data[, 11])
attributes(data)$variable.labels[11] <- "[Project 1] [Involvement] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[11] <- "flossprojects_p1_tasks"
# LimeSurvey Field type: A
data[, 12] <- as.character(data[, 12])
attributes(data)$variable.labels[12] <- "[Project 1] [Length of Participation [years]] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[12] <- "flossprojects_p1_duration"
# LimeSurvey Field type: A
data[, 13] <- as.character(data[, 13])
attributes(data)$variable.labels[13] <- "[Project 2] [Project name] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[13] <- "flossprojects_p2_name"
# LimeSurvey Field type: A
data[, 14] <- as.character(data[, 14])
attributes(data)$variable.labels[14] <- "[Project 2] [Involvement] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[14] <- "flossprojects_p2_tasks"
# LimeSurvey Field type: A
data[, 15] <- as.character(data[, 15])
attributes(data)$variable.labels[15] <- "[Project 2] [Length of Participation [years]] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[15] <- "flossprojects_p2_duration"
# LimeSurvey Field type: A
data[, 16] <- as.character(data[, 16])
attributes(data)$variable.labels[16] <- "[Project 3] [Project name] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[16] <- "flossprojects_p3_name"
# LimeSurvey Field type: A
data[, 17] <- as.character(data[, 17])
attributes(data)$variable.labels[17] <- "[Project 3] [Involvement] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[17] <- "flossprojects_p3_tasks"
# LimeSurvey Field type: A
data[, 18] <- as.character(data[, 18])
attributes(data)$variable.labels[18] <- "[Project 3] [Length of Participation [years]] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[18] <- "flossprojects_p3_duration"
# LimeSurvey Field type: A
data[, 19] <- as.character(data[, 19])
attributes(data)$variable.labels[19] <- "[Project 4] [Project name] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[19] <- "flossprojects_p4_name"
# LimeSurvey Field type: A
data[, 20] <- as.character(data[, 20])
attributes(data)$variable.labels[20] <- "[Project 4] [Involvement] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[20] <- "flossprojects_p4_tasks"
# LimeSurvey Field type: A
data[, 21] <- as.character(data[, 21])
attributes(data)$variable.labels[21] <- "[Project 4] [Length of Participation [years]] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[21] <- "flossprojects_p4_duration"
# LimeSurvey Field type: A
data[, 22] <- as.character(data[, 22])
attributes(data)$variable.labels[22] <- "[Project 5] [Project name] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[22] <- "flossprojects_p5_name"
# LimeSurvey Field type: A
data[, 23] <- as.character(data[, 23])
attributes(data)$variable.labels[23] <- "[Project 5] [Involvement] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[23] <- "flossprojects_p5_tasks"
# LimeSurvey Field type: A
data[, 24] <- as.character(data[, 24])
attributes(data)$variable.labels[24] <- "[Project 5] [Length of Participation [years]] In which free and open source software (FLOSS) projects have you been or are you involved?If you are associated with multiple projects, please write them line-by-line.Within each line describe your involvement (position, tasks, ...) in the individual project."
names(data)[24] <- "flossprojects_p5_duration"
# LimeSurvey Field type: A
data[, 25] <- as.character(data[, 25])
attributes(data)$variable.labels[25] <- "[getenv/environment variables (e.g. PATH)] Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?"
data[, 25] <- factor(data[, 25], levels=c("used1","used3","used4"),labels=c("have not used ordon\'t know it", "had contact with", "used in source code"))
names(data)[25] <- "usedsystems1_getenv"
# LimeSurvey Field type: A
data[, 26] <- as.character(data[, 26])
attributes(data)$variable.labels[26] <- "[command-line arguments] Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?"
data[, 26] <- factor(data[, 26], levels=c("used1","used3","used4"),labels=c("have not used ordon\'t know it", "had contact with", "used in source code"))
names(data)[26] <- "usedsystems1_envvar"
# LimeSurvey Field type: A
data[, 27] <- as.character(data[, 27])
attributes(data)$variable.labels[27] <- "[XSettings] Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?"
data[, 27] <- factor(data[, 27], levels=c("used1","used3","used4"),labels=c("have not used ordon\'t know it", "had contact with", "used in source code"))
names(data)[27] <- "usedsystems1_xsettings"
# LimeSurvey Field type: A
data[, 28] <- as.character(data[, 28])
attributes(data)$variable.labels[28] <- "[GSettings] Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?"
data[, 28] <- factor(data[, 28], levels=c("used1","used3","used4"),labels=c("have not used ordon\'t know it", "had contact with", "used in source code"))
names(data)[28] <- "usedsystems1_gsettings"
# LimeSurvey Field type: A
data[, 29] <- as.character(data[, 29])
attributes(data)$variable.labels[29] <- "[QSettings] Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?"
data[, 29] <- factor(data[, 29], levels=c("used1","used3","used4"),labels=c("have not used ordon\'t know it", "had contact with", "used in source code"))
names(data)[29] <- "usedsystems1_qsettings"
# LimeSurvey Field type: A
data[, 30] <- as.character(data[, 30])
attributes(data)$variable.labels[30] <- "[KConfig (from KDE Frameworks)] Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?"
data[, 30] <- factor(data[, 30], levels=c("used1","used3","used4"),labels=c("have not used ordon\'t know it", "had contact with", "used in source code"))
names(data)[30] <- "usedsystems1_kconfig"
# LimeSurvey Field type: A
data[, 31] <- as.character(data[, 31])
attributes(data)$variable.labels[31] <- "[dconf] Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?"
data[, 31] <- factor(data[, 31], levels=c("used1","used3","used4"),labels=c("have not used ordon\'t know it", "had contact with", "used in source code"))
names(data)[31] <- "usedsystems1_dconf"
# LimeSurvey Field type: A
data[, 32] <- as.character(data[, 32])
attributes(data)$variable.labels[32] <- "[configuration files (e.g. /etc/papersize, /etc/motd, …)] Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?"
data[, 32] <- factor(data[, 32], levels=c("used1","used3","used4"),labels=c("have not used ordon\'t know it", "had contact with", "used in source code"))
names(data)[32] <- "usedsystems1_cfgfiles"
# LimeSurvey Field type: A
data[, 33] <- as.character(data[, 33])
attributes(data)$variable.labels[33] <- "[freedesktop standards (e.g. shared-mime-info)] Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?"
data[, 33] <- factor(data[, 33], levels=c("used1","used3","used4"),labels=c("have not used ordon\'t know it", "had contact with", "used in source code"))
names(data)[33] <- "usedsystems1_freedesktop"
# LimeSurvey Field type: A
data[, 34] <- as.character(data[, 34])
attributes(data)$variable.labels[34] <- "[registry (if Windows support available)] Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?"
data[, 34] <- factor(data[, 34], levels=c("used1","used3","used4"),labels=c("have not used ordon\'t know it", "had contact with", "used in source code"))
names(data)[34] <- "usedsystems1_registra"
# LimeSurvey Field type: A
data[, 35] <- as.character(data[, 35])
attributes(data)$variable.labels[35] <- "[plist (if Mac OS X support available)] Which configuration systems/libraries/APIs have you already used or would like to use in one of your FLOSS project(s)?"
data[, 35] <- factor(data[, 35], levels=c("used1","used3","used4"),labels=c("have not used ordon\'t know it", "had contact with", "used in source code"))
names(data)[35] <- "usedsystems1_plist"
# LimeSurvey Field type: A
data[, 36] <- as.character(data[, 36])
attributes(data)$variable.labels[36] <- "[getenv/environment variables (e.g. http_proxy)] What is your experience with the following configuration systems/libraries/APIs?"
data[, 36] <- factor(data[, 36], levels=c("bad","confused","help","neutral","good"),labels=c("very frustrating", "frustrating", "neutral", "satisfying", "very satisfying"), ordered=TRUE)
names(data)[36] <- "usedsystems2_getenv"
# LimeSurvey Field type: A
data[, 37] <- as.character(data[, 37])
attributes(data)$variable.labels[37] <- "[command-line arguments] What is your experience with the following configuration systems/libraries/APIs?"
data[, 37] <- factor(data[, 37], levels=c("bad","confused","help","neutral","good"),labels=c("very frustrating", "frustrating", "neutral", "satisfying", "very satisfying"), ordered=TRUE)
names(data)[37] <- "usedsystems2_envvar"
# LimeSurvey Field type: A
data[, 38] <- as.character(data[, 38])
attributes(data)$variable.labels[38] <- "[XSettings] What is your experience with the following configuration systems/libraries/APIs?"
data[, 38] <- factor(data[, 38], levels=c("bad","confused","help","neutral","good"),labels=c("very frustrating", "frustrating", "neutral", "satisfying", "very satisfying"), ordered=TRUE)
names(data)[38] <- "usedsystems2_xsettings"
# LimeSurvey Field type: A
data[, 39] <- as.character(data[, 39])
attributes(data)$variable.labels[39] <- "[GSettings] What is your experience with the following configuration systems/libraries/APIs?"
data[, 39] <- factor(data[, 39], levels=c("bad","confused","help","neutral","good"),labels=c("very frustrating", "frustrating", "neutral", "satisfying", "very satisfying"), ordered=TRUE)
names(data)[39] <- "usedsystems2_gsettings"
# LimeSurvey Field type: A
data[, 40] <- as.character(data[, 40])
attributes(data)$variable.labels[40] <- "[QSettings] What is your experience with the following configuration systems/libraries/APIs?"
data[, 40] <- factor(data[, 40], levels=c("bad","confused","help","neutral","good"),labels=c("very frustrating", "frustrating", "neutral", "satisfying", "very satisfying"), ordered=TRUE)
names(data)[40] <- "usedsystems2_qsettings"
# LimeSurvey Field type: A
data[, 41] <- as.character(data[, 41])
attributes(data)$variable.labels[41] <- "[KConfig (from KDE Frameworks)] What is your experience with the following configuration systems/libraries/APIs?"
data[, 41] <- factor(data[, 41], levels=c("bad","confused","help","neutral","good"),labels=c("very frustrating", "frustrating", "neutral", "satisfying", "very satisfying"), ordered=TRUE)
names(data)[41] <- "usedsystems2_kconfig"
# LimeSurvey Field type: A
data[, 42] <- as.character(data[, 42])
attributes(data)$variable.labels[42] <- "[dconf] What is your experience with the following configuration systems/libraries/APIs?"
data[, 42] <- factor(data[, 42], levels=c("bad","confused","help","neutral","good"),labels=c("very frustrating", "frustrating", "neutral", "satisfying", "very satisfying"), ordered=TRUE)
names(data)[42] <- "usedsystems2_dconf"
# LimeSurvey Field type: A
data[, 43] <- as.character(data[, 43])
attributes(data)$variable.labels[43] <- "[configuration files (e.g. /etc/papersize, /etc/motd, …)] What is your experience with the following configuration systems/libraries/APIs?"
data[, 43] <- factor(data[, 43], levels=c("bad","confused","help","neutral","good"),labels=c("very frustrating", "frustrating", "neutral", "satisfying", "very satisfying"), ordered=TRUE)
names(data)[43] <- "usedsystems2_cfgfiles"
# LimeSurvey Field type: A
data[, 44] <- as.character(data[, 44])
attributes(data)$variable.labels[44] <- "[freedesktop standards (e.g. shared-mime-info)] What is your experience with the following configuration systems/libraries/APIs?"
data[, 44] <- factor(data[, 44], levels=c("bad","confused","help","neutral","good"),labels=c("very frustrating", "frustrating", "neutral", "satisfying", "very satisfying"), ordered=TRUE)
names(data)[44] <- "usedsystems2_freedesktop"
# LimeSurvey Field type: A
data[, 45] <- as.character(data[, 45])
attributes(data)$variable.labels[45] <- "[registry (if Windows support available)] What is your experience with the following configuration systems/libraries/APIs?"
data[, 45] <- factor(data[, 45], levels=c("bad","confused","help","neutral","good"),labels=c("very frustrating", "frustrating", "neutral", "satisfying", "very satisfying"), ordered=TRUE)
names(data)[45] <- "usedsystems2_registra"
# LimeSurvey Field type: A
data[, 46] <- as.character(data[, 46])
attributes(data)$variable.labels[46] <- "[plist (if Mac OS X support available)] What is your experience with the following configuration systems/libraries/APIs?"
data[, 46] <- factor(data[, 46], levels=c("bad","confused","help","neutral","good"),labels=c("very frustrating", "frustrating", "neutral", "satisfying", "very satisfying"), ordered=TRUE)
names(data)[46] <- "usedsystems2_plist"
# LimeSurvey Field type: F
data[, 47] <- as.numeric(data[, 47])
attributes(data)$variable.labels[47] <- "[introduced a new configuration file format (e.g. a new INI dialect)] In which way have you used or contributed to the configuration system/library/API in your previously mentioned FLOSS project(s)?"
data[, 47] <- factor(data[, 47], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[47] <- "flosscontribution_a1"
# LimeSurvey Field type: F
data[, 48] <- as.numeric(data[, 48])
attributes(data)$variable.labels[48] <- "[introduced a new configuration system/library/API] In which way have you used or contributed to the configuration system/library/API in your previously mentioned FLOSS project(s)?"
data[, 48] <- factor(data[, 48], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[48] <- "flosscontribution_a2"
# LimeSurvey Field type: F
data[, 49] <- as.numeric(data[, 49])
attributes(data)$variable.labels[49] <- "[implemented a configuration file parser] In which way have you used or contributed to the configuration system/library/API in your previously mentioned FLOSS project(s)?"
data[, 49] <- factor(data[, 49], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[49] <- "flosscontribution_a3"
# LimeSurvey Field type: F
data[, 50] <- as.numeric(data[, 50])
attributes(data)$variable.labels[50] <- "[used an internal configuration system/library/API] In which way have you used or contributed to the configuration system/library/API in your previously mentioned FLOSS project(s)?"
data[, 50] <- factor(data[, 50], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[50] <- "flosscontribution_a4"
# LimeSurvey Field type: F
data[, 51] <- as.numeric(data[, 51])
attributes(data)$variable.labels[51] <- "[used an external configuration system/library/API (like those in previous question)] In which way have you used or contributed to the configuration system/library/API in your previously mentioned FLOSS project(s)?"
data[, 51] <- factor(data[, 51], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[51] <- "flosscontribution_a5"
# LimeSurvey Field type: F
data[, 52] <- as.numeric(data[, 52])
attributes(data)$variable.labels[52] <- "[implemented other configuration related artifacts] In which way have you used or contributed to the configuration system/library/API in your previously mentioned FLOSS project(s)?"
data[, 52] <- factor(data[, 52], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[52] <- "flosscontribution_a6"
# LimeSurvey Field type: F
data[, 53] <- as.numeric(data[, 53])
attributes(data)$variable.labels[53] <- "[most of my contributions were non-configurable] In which way have you used or contributed to the configuration system/library/API in your previously mentioned FLOSS project(s)?"
data[, 53] <- factor(data[, 53], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[53] <- "flosscontribution_a7"
# LimeSurvey Field type: A
data[, 54] <- as.character(data[, 54])
attributes(data)$variable.labels[54] <- "[to improve user experience] Configuration integration is an effort to adapt applications better to the system.How important are the following reasons to introduce configuration integration? (e.g. reading /etc/papersize)"
data[, 54] <- factor(data[, 54], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"))
names(data)[54] <- "introduceconfintrg_a1"
# LimeSurvey Field type: A
data[, 55] <- as.character(data[, 55])
attributes(data)$variable.labels[55] <- "[because common/default settings are already available (e.g. in /etc/papersize)] Configuration integration is an effort to adapt applications better to the system.How important are the following reasons to introduce configuration integration? (e.g. reading /etc/papersize)"
data[, 55] <- factor(data[, 55], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"))
names(data)[55] <- "introduceconfintrg_a2"
# LimeSurvey Field type: A
data[, 56] <- as.character(data[, 56])
attributes(data)$variable.labels[56] <- "[because guidelines recommended it (e.g. $HOME in POSIX)] Configuration integration is an effort to adapt applications better to the system.How important are the following reasons to introduce configuration integration? (e.g. reading /etc/papersize)"
data[, 56] <- factor(data[, 56], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"))
names(data)[56] <- "introduceconfintrg_a3"
# LimeSurvey Field type: A
data[, 57] <- as.character(data[, 57])
attributes(data)$variable.labels[57] <- "[because I am convinced it should be done] Configuration integration is an effort to adapt applications better to the system.How important are the following reasons to introduce configuration integration? (e.g. reading /etc/papersize)"
data[, 57] <- factor(data[, 57], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"))
names(data)[57] <- "introduceconfintrg_a4"
# LimeSurvey Field type: A
data[, 58] <- as.character(data[, 58])
attributes(data)$variable.labels[58] <- "[other: (Please name it after making a selection)] Configuration integration is an effort to adapt applications better to the system.How important are the following reasons to introduce configuration integration? (e.g. reading /etc/papersize)"
data[, 58] <- factor(data[, 58], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"))
names(data)[58] <- "introduceconfintrg_a5"
# LimeSurvey Field type: F
data[, 59] <- as.numeric(data[, 59])
attributes(data)$variable.labels[59] <- "[so that users avoid common errors] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 59] <- factor(data[, 59], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[59] <- "specifyconfig_a1"
# LimeSurvey Field type: F
data[, 60] <- as.numeric(data[, 60])
attributes(data)$variable.labels[60] <- "[for rigorous validation] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 60] <- factor(data[, 60], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[60] <- "specifyconfig_a2"
# LimeSurvey Field type: F
data[, 61] <- as.numeric(data[, 61])
attributes(data)$variable.labels[61] <- "[for documentation (looking up what the value does)] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 61] <- factor(data[, 61], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[61] <- "specifyconfig_a3"
# LimeSurvey Field type: F
data[, 62] <- as.numeric(data[, 62])
attributes(data)$variable.labels[62] <- "[for code generation accessing configuration] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 62] <- factor(data[, 62], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[62] <- "specifyconfig_a4"
# LimeSurvey Field type: F
data[, 63] <- as.numeric(data[, 63])
attributes(data)$variable.labels[63] <- "[for documentation generation (e.g. man pages, user guide)] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 63] <- factor(data[, 63], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[63] <- "specifyconfig_a5"
# LimeSurvey Field type: F
data[, 64] <- as.numeric(data[, 64])
attributes(data)$variable.labels[64] <- "[for user interface generation (e.g. generate combo box with specified answers)] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 64] <- factor(data[, 64], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[64] <- "specifyconfig_a6"
# LimeSurvey Field type: F
data[, 65] <- as.numeric(data[, 65])
attributes(data)$variable.labels[65] <- "[for reuse of configuration items (specifying links)] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 65] <- factor(data[, 65], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[65] <- "specifyconfig_a7"
# LimeSurvey Field type: F
data[, 66] <- as.numeric(data[, 66])
attributes(data)$variable.labels[66] <- "[for external tools accessing configuration] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 66] <- factor(data[, 66], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[66] <- "specifyconfig_a8"
# LimeSurvey Field type: F
data[, 67] <- as.numeric(data[, 67])
attributes(data)$variable.labels[67] <- "[to simplify maintenance] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 67] <- factor(data[, 67], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[67] <- "specifyconfig_a9"
# LimeSurvey Field type: F
data[, 68] <- as.numeric(data[, 68])
attributes(data)$variable.labels[68] <- "[I would not because they are too complicated] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 68] <- factor(data[, 68], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[68] <- "specifyconfig_a10"
# LimeSurvey Field type: F
data[, 69] <- as.numeric(data[, 69])
attributes(data)$variable.labels[69] <- "[I would not because it creates inconsistencies] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 69] <- factor(data[, 69], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[69] <- "specifyconfig_a11"
# LimeSurvey Field type: F
data[, 70] <- as.numeric(data[, 70])
attributes(data)$variable.labels[70] <- "[I would not (use other to write why)] Configuration specification (e.g. XSD/JSON schemas) allows you to describe possible values and their meaning.Why do/would you specify configuration?"
data[, 70] <- factor(data[, 70], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[70] <- "specifyconfig_a12"
# LimeSurvey Field type: F
data[, 71] <- as.numeric(data[, 71])
attributes(data)$variable.labels[71] <- "[to provide better user experience] Why do you think configuration should be reduced?"
data[, 71] <- factor(data[, 71], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[71] <- "configreduction_a1"
# LimeSurvey Field type: F
data[, 72] <- as.numeric(data[, 72])
attributes(data)$variable.labels[72] <- "[because use-cases which are rarely used should not be supported] Why do you think configuration should be reduced?"
data[, 72] <- factor(data[, 72], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[72] <- "configreduction_a2"
# LimeSurvey Field type: F
data[, 73] <- as.numeric(data[, 73])
attributes(data)$variable.labels[73] <- "[because only standard use-cases should be supported] Why do you think configuration should be reduced?"
data[, 73] <- factor(data[, 73], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[73] <- "configreduction_a3"
# LimeSurvey Field type: F
data[, 74] <- as.numeric(data[, 74])
attributes(data)$variable.labels[74] <- "[to prevent errors and misconfiguration] Why do you think configuration should be reduced?"
data[, 74] <- factor(data[, 74], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[74] <- "configreduction_a4"
# LimeSurvey Field type: F
data[, 75] <- as.numeric(data[, 75])
attributes(data)$variable.labels[75] <- "[to simplify code maintenance] Why do you think configuration should be reduced?"
data[, 75] <- factor(data[, 75], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[75] <- "configreduction_a5"
# LimeSurvey Field type: F
data[, 76] <- as.numeric(data[, 76])
attributes(data)$variable.labels[76] <- "[because auto-detection should be preferred] Why do you think configuration should be reduced?"
data[, 76] <- factor(data[, 76], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[76] <- "configreduction_a6"
# LimeSurvey Field type: F
data[, 77] <- as.numeric(data[, 77])
attributes(data)$variable.labels[77] <- "[auto-detection should always be overridable] Why do you think configuration should be reduced?"
data[, 77] <- factor(data[, 77], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[77] <- "configreduction_a7"
# LimeSurvey Field type: F
data[, 78] <- as.numeric(data[, 78])
attributes(data)$variable.labels[78] <- "[I never find time for this task] Why do you think configuration should be reduced?"
data[, 78] <- factor(data[, 78], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[78] <- "configreduction_a8"
# LimeSurvey Field type: F
data[, 79] <- as.numeric(data[, 79])
attributes(data)$variable.labels[79] <- "[I do not think it should be reduced] Why do you think configuration should be reduced?"
data[, 79] <- factor(data[, 79], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[79] <- "configreduction_a9"
# LimeSurvey Field type: F
data[, 80] <- as.numeric(data[, 80])
attributes(data)$variable.labels[80] <- "[provide proper default values] Which effort do you think is worthwhile for providing better configuration experience?"
data[, 80] <- factor(data[, 80], levels=c(1,0),labels=c("Yes", "Not selected"), ordered=TRUE)
names(data)[80] <- "effortconfexp_a1"
# LimeSurvey Field type: F
data[, 81] <- as.numeric(data[, 81])
attributes(data)$variable.labels[81] <- "[reading environment variables] Which effort do you think is worthwhile for providing better configuration experience?"
data[, 81] <- factor(data[, 81], levels=c(1,0),labels=c("Yes", "Not selected"), ordered=TRUE)
names(data)[81] <- "effortconfexp_a2"
# LimeSurvey Field type: F
data[, 82] <- as.numeric(data[, 82])
attributes(data)$variable.labels[82] <- "[reading configuration of other applications] Which effort do you think is worthwhile for providing better configuration experience?"
data[, 82] <- factor(data[, 82], levels=c(1,0),labels=c("Yes", "Not selected"), ordered=TRUE)
names(data)[82] <- "effortconfexp_a3"
# LimeSurvey Field type: F
data[, 83] <- as.numeric(data[, 83])
attributes(data)$variable.labels[83] <- "[accessing system-environment APIs (e.g. GSettings, XSettings)] Which effort do you think is worthwhile for providing better configuration experience?"
data[, 83] <- factor(data[, 83], levels=c(1,0),labels=c("Yes", "Not selected"), ordered=TRUE)
names(data)[83] <- "effortconfexp_a4"
# LimeSurvey Field type: F
data[, 84] <- as.numeric(data[, 84])
attributes(data)$variable.labels[84] <- "[adding dependency to library that only does detection (e.g. libpaper)] Which effort do you think is worthwhile for providing better configuration experience?"
data[, 84] <- factor(data[, 84], levels=c(1,0),labels=c("Yes", "Not selected"), ordered=TRUE)
names(data)[84] <- "effortconfexp_a5"
# LimeSurvey Field type: F
data[, 85] <- as.numeric(data[, 85])
attributes(data)$variable.labels[85] <- "[accessing external APIs (which adds new dependencies)] Which effort do you think is worthwhile for providing better configuration experience?"
data[, 85] <- factor(data[, 85], levels=c(1,0),labels=c("Yes", "Not selected"), ordered=TRUE)
names(data)[85] <- "effortconfexp_a6"
# LimeSurvey Field type: F
data[, 86] <- as.numeric(data[, 86])
attributes(data)$variable.labels[86] <- "[reading /proc and other OS-specific sources] Which effort do you think is worthwhile for providing better configuration experience?"
data[, 86] <- factor(data[, 86], levels=c(1,0),labels=c("Yes", "Not selected"), ordered=TRUE)
names(data)[86] <- "effortconfexp_a7"
# LimeSurvey Field type: F
data[, 87] <- as.numeric(data[, 87])
attributes(data)$variable.labels[87] <- "[detecting network-properties and bandwidth] Which effort do you think is worthwhile for providing better configuration experience?"
data[, 87] <- factor(data[, 87], levels=c(1,0),labels=c("Yes", "Not selected"), ordered=TRUE)
names(data)[87] <- "effortconfexp_a8"
# LimeSurvey Field type: F
data[, 88] <- as.numeric(data[, 88])
attributes(data)$variable.labels[88] <- "[I do not think such effort would be useful] Which effort do you think is worthwhile for providing better configuration experience?"
data[, 88] <- factor(data[, 88], levels=c(1,0),labels=c("Yes", "Not selected"), ordered=TRUE)
names(data)[88] <- "effortconfexp_a9"
# LimeSurvey Field type: A
data[, 89] <- as.character(data[, 89])
attributes(data)$variable.labels[89] <- "[native GUI (e.g. GTK, Qt)] How important is it to expose configuration options in the following ways?"
data[, 89] <- factor(data[, 89], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[89] <- "importancecfgoptions_a1"
# LimeSurvey Field type: A
data[, 90] <- as.character(data[, 90])
attributes(data)$variable.labels[90] <- "[a web GUI] How important is it to expose configuration options in the following ways?"
data[, 90] <- factor(data[, 90], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[90] <- "importancecfgoptions_a2"
# LimeSurvey Field type: A
data[, 91] <- as.character(data[, 91])
attributes(data)$variable.labels[91] <- "[command-line utility] How important is it to expose configuration options in the following ways?"
data[, 91] <- factor(data[, 91], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[91] <- "importancecfgoptions_a3"
# LimeSurvey Field type: A
data[, 92] <- as.character(data[, 92])
attributes(data)$variable.labels[92] <- "[configuration file (e.g. INI)] How important is it to expose configuration options in the following ways?"
data[, 92] <- factor(data[, 92], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[92] <- "importancecfgoptions_a4"
# LimeSurvey Field type: A
data[, 93] <- as.character(data[, 93])
attributes(data)$variable.labels[93] <- "[library APIs] How important is it to expose configuration options in the following ways?"
data[, 93] <- factor(data[, 93], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[93] <- "importancecfgoptions_a5"
# LimeSurvey Field type: A
data[, 94] <- as.character(data[, 94])
attributes(data)$variable.labels[94] <- "[IPC (inter-process communication, e.g. dbus)] How important is it to expose configuration options in the following ways?"
data[, 94] <- factor(data[, 94], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[94] <- "importancecfgoptions_a6"
# LimeSurvey Field type: A
data[, 95] <- as.character(data[, 95])
attributes(data)$variable.labels[95] <- "[REST API] How important is it to expose configuration options in the following ways?"
data[, 95] <- factor(data[, 95], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[95] <- "importancecfgoptions_a7"
# LimeSurvey Field type: F
data[, 96] <- as.numeric(data[, 96])
attributes(data)$variable.labels[96] <- "[for debugging/testing purposes] At which places in the code would you use a getenv*?* the C-API getenv(3) or other means of configuration/environment access"
data[, 96] <- factor(data[, 96], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[96] <- "getenv_a1"
# LimeSurvey Field type: F
data[, 97] <- as.numeric(data[, 97])
attributes(data)$variable.labels[97] <- "[to bypass standard configuration system/library/API] At which places in the code would you use a getenv*?* the C-API getenv(3) or other means of configuration/environment access"
data[, 97] <- factor(data[, 97], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[97] <- "getenv_a2"
# LimeSurvey Field type: F
data[, 98] <- as.numeric(data[, 98])
attributes(data)$variable.labels[98] <- "[if configuration is unlikely to be changed by a user] At which places in the code would you use a getenv*?* the C-API getenv(3) or other means of configuration/environment access"
data[, 98] <- factor(data[, 98], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[98] <- "getenv_a3"
# LimeSurvey Field type: F
data[, 99] <- as.numeric(data[, 99])
attributes(data)$variable.labels[99] <- "[if environment semantics are needed (inherit changed environment at fork)] At which places in the code would you use a getenv*?* the C-API getenv(3) or other means of configuration/environment access"
data[, 99] <- factor(data[, 99], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[99] <- "getenv_a4"
# LimeSurvey Field type: F
data[, 100] <- as.numeric(data[, 100])
attributes(data)$variable.labels[100] <- "[even when it is used inside a loop, e.g.:for (int i = 0; i < K; ++i) getenv(\"HOME\");] At which places in the code would you use a getenv*?* the C-API getenv(3) or other means of configuration/environment access"
data[, 100] <- factor(data[, 100], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[100] <- "getenv_a5"
# LimeSurvey Field type: F
data[, 101] <- as.numeric(data[, 101])
attributes(data)$variable.labels[101] <- "[even when it is in a function which should be lightweight] At which places in the code would you use a getenv*?* the C-API getenv(3) or other means of configuration/environment access"
data[, 101] <- factor(data[, 101], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[101] <- "getenv_a6"
# LimeSurvey Field type: F
data[, 102] <- as.numeric(data[, 102])
attributes(data)$variable.labels[102] <- "[even in multi-threaded code] At which places in the code would you use a getenv*?* the C-API getenv(3) or other means of configuration/environment access"
data[, 102] <- factor(data[, 102], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[102] <- "getenv_a7"
# LimeSurvey Field type: F
data[, 103] <- as.numeric(data[, 103])
attributes(data)$variable.labels[103] <- "[I do not use it (use other to write why)] At which places in the code would you use a getenv*?* the C-API getenv(3) or other means of configuration/environment access"
data[, 103] <- factor(data[, 103], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[103] <- "getenv_a8"
# LimeSurvey Field type: F
data[, 104] <- as.numeric(data[, 104])
attributes(data)$variable.labels[104] <- "[via a web interface] Imagine you have one or multiple machines that you want to configure/setup without having physical access.In which remote configuration scenarios would you be interested?"
data[, 104] <- factor(data[, 104], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[104] <- "clusterconf_a1"
# LimeSurvey Field type: F
data[, 105] <- as.numeric(data[, 105])
attributes(data)$variable.labels[105] <- "[via ssh] Imagine you have one or multiple machines that you want to configure/setup without having physical access.In which remote configuration scenarios would you be interested?"
data[, 105] <- factor(data[, 105], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[105] <- "clusterconf_a2"
# LimeSurvey Field type: F
data[, 106] <- as.numeric(data[, 106])
attributes(data)$variable.labels[106] <- "[in groups/clusters of devices with similar configuration (e.g. multiple instances of web servers)] Imagine you have one or multiple machines that you want to configure/setup without having physical access.In which remote configuration scenarios would you be interested?"
data[, 106] <- factor(data[, 106], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[106] <- "clusterconf_a3"
# LimeSurvey Field type: F
data[, 107] <- as.numeric(data[, 107])
attributes(data)$variable.labels[107] <- "[in non-clustered devices with independent configurations] Imagine you have one or multiple machines that you want to configure/setup without having physical access.In which remote configuration scenarios would you be interested?"
data[, 107] <- factor(data[, 107], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[107] <- "clusterconf_a4"
# LimeSurvey Field type: F
data[, 108] <- as.numeric(data[, 108])
attributes(data)$variable.labels[108] <- "[in a single computer (e.g. configuring your home server)] Imagine you have one or multiple machines that you want to configure/setup without having physical access.In which remote configuration scenarios would you be interested?"
data[, 108] <- factor(data[, 108], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[108] <- "clusterconf_a5"
# LimeSurvey Field type: F
data[, 109] <- as.numeric(data[, 109])
attributes(data)$variable.labels[109] <- "[not interested] Imagine you have one or multiple machines that you want to configure/setup without having physical access.In which remote configuration scenarios would you be interested?"
data[, 109] <- factor(data[, 109], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[109] <- "clusterconf_a6"
# LimeSurvey Field type: A
data[, 110] <- as.character(data[, 110])
attributes(data)$variable.labels[110] <- "[documentation shipped with the applications] You want to configure a FLOSS application.How important are the following ways for you?"
data[, 110] <- factor(data[, 110], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[110] <- "informaboutcfg_a1"
# LimeSurvey Field type: A
data[, 111] <- as.character(data[, 111])
attributes(data)$variable.labels[111] <- "[configuration examples shipped with the applications] You want to configure a FLOSS application.How important are the following ways for you?"
data[, 111] <- factor(data[, 111], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[111] <- "informaboutcfg_a2"
# LimeSurvey Field type: A
data[, 112] <- as.character(data[, 112])
attributes(data)$variable.labels[112] <- "[website of the applications] You want to configure a FLOSS application.How important are the following ways for you?"
data[, 112] <- factor(data[, 112], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[112] <- "informaboutcfg_a3"
# LimeSurvey Field type: A
data[, 113] <- as.character(data[, 113])
attributes(data)$variable.labels[113] <- "[google, stackoverflow… (looking for my problem)] You want to configure a FLOSS application.How important are the following ways for you?"
data[, 113] <- factor(data[, 113], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[113] <- "informaboutcfg_a4"
# LimeSurvey Field type: A
data[, 114] <- as.character(data[, 114])
attributes(data)$variable.labels[114] <- "[wiki, tutorials… (looking for complete solutions)] You want to configure a FLOSS application.How important are the following ways for you?"
data[, 114] <- factor(data[, 114], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[114] <- "informaboutcfg_a5"
# LimeSurvey Field type: A
data[, 115] <- as.character(data[, 115])
attributes(data)$variable.labels[115] <- "[ask colleagues and friends] You want to configure a FLOSS application.How important are the following ways for you?"
data[, 115] <- factor(data[, 115], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[115] <- "informaboutcfg_a6"
# LimeSurvey Field type: A
data[, 116] <- as.character(data[, 116])
attributes(data)$variable.labels[116] <- "[look into the source code] You want to configure a FLOSS application.How important are the following ways for you?"
data[, 116] <- factor(data[, 116], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[116] <- "informaboutcfg_a7"
# LimeSurvey Field type: A
data[, 117] <- as.character(data[, 117])
attributes(data)$variable.labels[117] <- "[look into the configuration specification (e.g. XSD)] You want to configure a FLOSS application.How important are the following ways for you?"
data[, 117] <- factor(data[, 117], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[117] <- "informaboutcfg_a8"
# LimeSurvey Field type: A
data[, 118] <- as.character(data[, 118])
attributes(data)$variable.labels[118] <- "[use UI that will help me] You want to configure a FLOSS application.How important are the following ways for you?"
data[, 118] <- factor(data[, 118], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[118] <- "informaboutcfg_a9"
# LimeSurvey Field type: F
data[, 119] <- as.numeric(data[, 119])
attributes(data)$variable.labels[119] <- "[binary files in git repository or other VCS] What is your preferred way to backup, sync or share configurations?"
data[, 119] <- factor(data[, 119], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[119] <- "syncconfig_a1"
# LimeSurvey Field type: F
data[, 120] <- as.numeric(data[, 120])
attributes(data)$variable.labels[120] <- "[configuration files in git repository or other VCS] What is your preferred way to backup, sync or share configurations?"
data[, 120] <- factor(data[, 120], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[120] <- "syncconfig_a2"
# LimeSurvey Field type: F
data[, 121] <- as.numeric(data[, 121])
attributes(data)$variable.labels[121] <- "[timed or scripted trough file system backup (e.g. rsync)] What is your preferred way to backup, sync or share configurations?"
data[, 121] <- factor(data[, 121], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[121] <- "syncconfig_a3"
# LimeSurvey Field type: F
data[, 122] <- as.numeric(data[, 122])
attributes(data)$variable.labels[122] <- "[manual sync of selected folder online, on external or network media] What is your preferred way to backup, sync or share configurations?"
data[, 122] <- factor(data[, 122], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[122] <- "syncconfig_a4"
# LimeSurvey Field type: F
data[, 123] <- as.numeric(data[, 123])
attributes(data)$variable.labels[123] <- "[synchronization services (e.g. chrome synchronization, dropbox)] What is your preferred way to backup, sync or share configurations?"
data[, 123] <- factor(data[, 123], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[123] <- "syncconfig_a5"
# LimeSurvey Field type: F
data[, 124] <- as.numeric(data[, 124])
attributes(data)$variable.labels[124] <- "[I do not backup, sync or share configurations] What is your preferred way to backup, sync or share configurations?"
data[, 124] <- factor(data[, 124], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[124] <- "syncconfig_a6"
# LimeSurvey Field type: A
data[, 125] <- as.character(data[, 125])
attributes(data)$variable.labels[125] <- "[must be lightweight and efficient] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 125] <- factor(data[, 125], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[125] <- "importantbenefits_a1"
# LimeSurvey Field type: A
data[, 126] <- as.character(data[, 126])
attributes(data)$variable.labels[126] <- "[must be available anywhere and anytime (e.g. package managers or platforms)] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 126] <- factor(data[, 126], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[126] <- "importantbenefits_a2"
# LimeSurvey Field type: A
data[, 127] <- as.character(data[, 127])
attributes(data)$variable.labels[127] <- "[must be a trivial API (e.g. like getenv)] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 127] <- factor(data[, 127], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[127] <- "importantbenefits_a3"
# LimeSurvey Field type: A
data[, 128] <- as.character(data[, 128])
attributes(data)$variable.labels[128] <- "[must support context-features (e.g. firefox profiles, reconfiguration when in power-saving mode)] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 128] <- factor(data[, 128], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[128] <- "importantbenefits_a4"
# LimeSurvey Field type: A
data[, 129] <- as.character(data[, 129])
attributes(data)$variable.labels[129] <- "[must support integration of system configuration] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 129] <- factor(data[, 129], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[129] <- "importantbenefits_a5"
# LimeSurvey Field type: A
data[, 130] <- as.character(data[, 130])
attributes(data)$variable.labels[130] <- "[must support signatures and encryption (e.g. to protect passwords)] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 130] <- factor(data[, 130], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[130] <- "importantbenefits_a6"
# LimeSurvey Field type: A
data[, 131] <- as.character(data[, 131])
attributes(data)$variable.labels[131] <- "[must support (custom) human-readable configuration formats (e.g. XML/JSON/YAML)] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 131] <- factor(data[, 131], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[131] <- "importantbenefits_a7"
# LimeSurvey Field type: A
data[, 132] <- as.character(data[, 132])
attributes(data)$variable.labels[132] <- "[must support plugins for my use-cases (e.g. custom validation)] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 132] <- factor(data[, 132], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[132] <- "importantbenefits_a8"
# LimeSurvey Field type: A
data[, 133] <- as.character(data[, 133])
attributes(data)$variable.labels[133] <- "[migration must be effortless] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 133] <- factor(data[, 133], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[133] <- "importantbenefits_a9"
# LimeSurvey Field type: A
data[, 134] <- as.character(data[, 134])
attributes(data)$variable.labels[134] <- "[should implement the APIs I already use (e.g. GSettings)] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 134] <- factor(data[, 134], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[134] <- "importantbenefits_a10"
# LimeSurvey Field type: A
data[, 135] <- as.character(data[, 135])
attributes(data)$variable.labels[135] <- "[community must be active and supportive] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 135] <- factor(data[, 135], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[135] <- "importantbenefits_a11"
# LimeSurvey Field type: A
data[, 136] <- as.character(data[, 136])
attributes(data)$variable.labels[136] <- "[must be well-maintained (bugs are fixed promptly)] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 136] <- factor(data[, 136], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[136] <- "importantbenefits_a12"
# LimeSurvey Field type: A
data[, 137] <- as.character(data[, 137])
attributes(data)$variable.labels[137] <- "[should be usable without library installed on target system (e.g. header-only)] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 137] <- factor(data[, 137], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[137] <- "importantbenefits_a13"
# LimeSurvey Field type: A
data[, 138] <- as.character(data[, 138])
attributes(data)$variable.labels[138] <- "[other: (Please name it after making a selection)] Finally, which benefits do you think are essential in order to add a dependency to a configuration system/library/API? (e.g. Elektra)"
data[, 138] <- factor(data[, 138], levels=c("a1","a2","a3","a4","a5"),labels=c("not important", "slightly important", "moderately important", "important", "very important"), ordered=TRUE)
names(data)[138] <- "importantbenefits_a14"

summary(data)
