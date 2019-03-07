values <- reactiveValues()

###################################################
##########           Parameters    ################
###################################################

## Possible Parameters

# Querys 1-11
values$token <- "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJncmFyZG9sYWdhckBnbWFpbC5jb20iLCJhdWQiOiJ3ZWIiLCJuYW1lIjoiR2VyYXJkbyBMYWd1bmVzIEdhcmPDrWEiLCJ1c2VyIjp0cnVlLCJpYXQiOjE1MTM4MDY4MjB9.vGaQE6HHucr8DOM8MNnBWOCnV2dPE0r2qu_9NsYFEI-PCn5J6_iyhTUH4pwBoWCIVyvIjpNwk9vOnjQmS0-wXQ"
values$url <- "http://disnet.ctb.upm.es/api/disnet/"

# Query 2-11
values$source = "wikipedia"
values$version = "2018-02-01"

# Query 4
values$diseaseCode = "117.7"
values$typeCode = "ICD - 9 - CM"
values$matchExactName = "false"
values$detectionInformation = "false"
values$includeCode = "false"

# Query 4,10

# Querys 4,6-9
values$excludeSemanticTypes = "" #dsyn, sosy
values$forceSemanticTypes = "" #dsyn, sosy

# Query 6-7
values$detectionInformation = "false"
values$includeCode = "false"

# Query 6-9
values$validated = "true"

# Query 6-10
values$limit = "2"