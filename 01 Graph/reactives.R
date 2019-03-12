###################################################
##########       Reactives       ##################
###################################################

values <- reactiveValues()

values$message <- NULL
values$withsymp <- data.frame(label_title = character())
values$diseaseCode = "117.7"
values$typeCode = "ICD-9-CM"
# Calls

values$diseases_with_codes <- function() {
    print("Calling diseases with codes")
    values$message <- "Retrieving diseases with codes..."
    return(get_data(urls.disnet, query3))
}

values$diseases_with_disnetconcepts_by_diseasename <- function() {
    values$message <- "Retrieving diseases with disnet concepts..."
    get_data(urls.disnet, query4_1)
}

values$diseases_with_disnetconcepts_by_code_and_type <- function() {
    values$message <- "Retrieving diseases with disnet concepts..."
    print(values$diseaseCode)
    print(values$typeCode)
    query4_2 <- paste0("/query/disnetConceptList?source=", source,
                 "&version=", version,
                 "&diseaseCode=", values$diseaseCode,
                 "&typeCode=", values$typeCode,
                 "&excludeSemanticTypes=", excludeSemanticTypes,
                 "&forceSemanticTypes=", forceSemanticTypes,
                 "&matchExactName=", matchExactName,
                 "&detectionInformation=", detectionInformation,
                 "&includeCode=", includeCode,
                 "&token=", token)

    get_data(urls.disnet, query4_2)
}

values$diseases_with_more_disnetconcepts <- function() {
    values$message <- "Retrieving diseases with more disnet concepts..."
    get_data(urls.disnet, query6)
}

values$diseases_with_less_disnetconcepts <- function() {
    values$message <- "Retrieving diseases with less disnet concepts..."
    get_data(urls.disnet, query7)
}

values$most_common_disnetconcepts <- function() {
    values$message <- "Retrieving most common disnet concepts..."
    get_data(urls.disnet, query8)
}

values$less_common_disnetconcepts <- function() {
    values$message <- "Retrieving less common disnet concepts..."
    get_data(urls.disnet, query9)
}