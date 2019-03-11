###################################################
##########       Reactives       ##################
###################################################

values <- reactiveValues()

values$message <- NULL

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