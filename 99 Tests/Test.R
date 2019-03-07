library(RCurl)
library(jsonlite)
library(Curl)

###################################################
##########           Parameters    ################
###################################################

## Possible Parameters

# Querys 1-11
token <- "Token here"
urls.disnet <- "http://disnet.ctb.upm.es/api/disnet/"

# Query 2-11
source = "wikipedia"
version = "2018-02-01"

# Query 4
diseaseCode = "117.7"
typeCode = "ICD - 9 - CM"
matchExactName = "false"
detectionInformation = "false"
includeCode = "false"

# Query 4,10
diseaseName = "Cancer"

# Querys 4,6-9
excludeSemanticTypes = "" #dsyn, sosy
forceSemanticTypes = "" #dsyn, sosy

# Query 6-7
detectionInformation = "false"
includeCode = "false"

# Query 6-9
validated = "true"

# Query 6-10
limit = "2"

###################################################
##########           Querys      ##################
###################################################


query1 <- paste0("/query/sourceList?token=", token)

query2 <- paste0("/query/versionList?source=", source,
                 "&token=", token)

query3 <- paste0("/query/diseaseList?source=", source, 
                 "&version=", version, 
                 "&token=", token)

query4 <- paste0("/query/disnetConceptList?source=", source, 
                 "&version=", version, 
                 "&diseaseName=", diseaseName, 
                 "&diseaseCode=", diseaseCode, 
                 "&typeCode=", typeCode, 
                 "&excludeSemanticTypes=", excludeSemanticTypes, 
                 "&forceSemanticTypes=", forceSemanticTypes, 
                 "&matchExactName=", matchExactName, 
                 "&detectionInformation=", detectionInformation, 
                 "&includeCode=", includeCode, 
                 "&token=", token)

query5 <- paste0("/query/diseaseCount?source=", source, 
                 "&version=", version, 
                 "&token=", token)
query6 <- paste0("/query/diseaseWithMoreDisnetConcepts?source=", source, 
                 "&version=", version, 
                 "&validated=", validated, 
                 "&limit=", limit, 
                 "&excludeSemanticTypes=", excludeSemanticTypes, 
                 "&forceSemanticTypes=", forceSemanticTypes, 
                 "&detectionInformation=", detectionInformation, 
                 "&includeCode=", includeCode, 
                 "&token=", token)

query7 <- paste0("/query/diseaseWithFewerDisnetConcepts?source=", source, 
                 "&version=", version, 
                 "&validated=", validated, 
                 "&limit=", limit, 
                 "&excludeSemanticTypes=", excludeSemanticTypes, 
                 "&forceSemanticTypes=", forceSemanticTypes, 
                 "&detectionInformation=", detectionInformation, 
                 "&includeCode=", includeCode, 
                 "&token=", token)

query8 <- paste0("/query/mostCommonDisnetConcepts?source=", source, 
                 "&version=", version, 
                 "&validated=", validated, 
                 "&limit=", limit, 
                 "&excludeSemanticTypes=", excludeSemanticTypes, 
                 "&forceSemanticTypes=", forceSemanticTypes, 
                 "&token=", token)

query9 <- paste0("/query/lessCommonDisnetConcepts?source=", source, 
                 "&version=", version, 
                 "&validated=", validated, 
                 "&limit=", limit, 
                 "&excludeSemanticTypes=", excludeSemanticTypes, 
                 "&forceSemanticTypes=", forceSemanticTypes, 
                 "&token=", token)

query10 <- paste0("/query/searchByDiseaseName?source=", source, 
                  "&version=", version, 
                  "&diseaseName=", diseaseName, 
                  "&limit=", limit, 
                  "&token=", token)

query11 <- paste0("/query/metadata?source=", source, 
                  "&version=", version, 
                  "&token=", token)


###################################################
##########       Get Data        ##################
###################################################


get_data <- function(url, query) {
    return(fromJSON(paste0(url,query)))
}