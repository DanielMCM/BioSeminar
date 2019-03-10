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

# Preprocessing

values$nodes <- c()
values$edges <- c()

values$calculate_nodes_and_edges <- function() {

    print("Retrieving data to visualize...")
    values$message <- "Retrieving data to visualize..."

    diseases_with_codes <- values$diseases_with_codes()$diseaseList
    diseases_with_concepts <- values$diseases_with_disnetconcepts_by_diseasename()$diseaseList

    # TODO: Remove truncation
    diseases_with_codes <- head(diseases_with_codes, n = 30)
    diseases_with_concepts <- head(diseases_with_concepts, n = 30)

    print("Preparing data...")
    values$message <- "Preparing data..."
    
    # Nodes
    ids <- c()
    labels <- c()
    shapes <- c()
    colors <- c()
    titles <- c()

    # Edges
    edges_from <- c()
    edges_to <- c()

    # Disease with codes processing

    for (row in 1:nrow(diseases_with_codes)) {
        id <- diseases_with_codes[row, "diseaseId"]
        if (!(id %in% ids)) {
            # Add disease node
            name <- diseases_with_codes[row, "name"]
            ids <- c(ids, id) # - id
            labels <- c(labels, name) # - label
            shapes <- c(shapes, "square")
            colors <- c(colors, "darkred")
            titles <- c(titles, paste0("<p><b>", name, "</b><br>!</p>"))
        }

        codes <- unlist(diseases_with_codes[row, "codes"], use.names = FALSE)
        half_idx <- length(codes) / 2
        for (code_row in 1:half_idx) {
            code <- codes[code_row]
            type_code <- codes[code_row + half_idx]
            if (!is.null(code)) {
                if (!(code %in% ids)) {
                    # Add concept node
                    ids <- c(ids, code)
                    labels <- c(labels, code)
                    shapes <- c(shapes, "triangle")
                    colors <- c(colors, "purple")
                    titles <- c(titles, paste0("<p><b>", code, "</b><br>!</p>"))

                    edges_from <- c(edges_from, id) # from disease
                    edges_to <- c(edges_to, code) # to code
                }
                #TODO: Something to do with type code?
            }
        }
    }

    # Disease with codes processing

    for (row in 1:nrow(diseases_with_concepts)) {
        id <- diseases_with_concepts[row, "diseaseId"]
        if (!(id %in% ids)) {
            # Add disease node
            name <- diseases_with_concepts[row, "name"]
            ids <- c(ids, id) # - id
            labels <- c(labels, name) # - label
            shapes <- c(shapes, "square")
            colors <- c(colors, "darkred")
            titles <- c(titles, paste0("<p><b>", name, "</b><br>!</p>"))
        }

        concepts <- unlist(diseases_with_concepts[row, "disnetConceptList"], use.names = FALSE)
        for (concept_row in 1:length(concepts)) {
            concept <- concepts[concept_row]
            type_code <- concepts[concept_row + half_idx]
            if (!is.null(concept)) {
                if (!(concept %in% ids)) {
                    # Add concept node
                    ids <- c(ids, concept)
                    labels <- c(labels, concept)
                    shapes <- c(shapes, "circle")
                    colors <- c(colors, "blue")
                    titles <- c(titles, paste0("<p><b>", concept, "</b><br>!</p>"))

                    edges_from <- c(edges_from, id) # from disease
                    edges_to <- c(edges_to, code) # to code
                }
                #TODO: Something to do with type code?
            }
        }
    }

    # Aggregates

    print("Assigning nodes and edges...")
    values$message <- "Assigning nodes and edges..."
    values$nodes <- data.frame(id = ids, label = labels, shape = shapes, title = titles, color = colors)
    values$edges <- data.frame(from = edges_from, to = edges_to)

    values$message <- "Loaded"
}