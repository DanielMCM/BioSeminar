calculate_nodes <- function(selection) {
    ## Links que salen de la seleccion
    print(selection)
    node_1a <- unique(merge(values$nodes[values$nodes[, "id"] %in%
                        selection,],
                    values$edges[, c("from", "to")],
                    by.x = "id",
                    by.y = "from",
                    all.y = FALSE)[, c("id", "label", "title", "color")])
    print(node_1a)
    ## Links que llegan a la seleccion
    node_1b <- unique(merge(values$nodes[values$nodes[, "id"] %in%
                        selection,],
                    values$edges[, c("from", "to")],
                    by.x = "id",
                    by.y = "to",
                    all.y = FALSE)[, c("id", "label", "title", "color")])
    ## Unidos
    node_1 <- unique(rbind(node_1a, node_1b))

    #Selecciono los nodos a los que les llegan entradas

    ## Cojo los nodos asociados a los links que salen
    node_2a <- unique(merge(values$nodes,
                    values$edges[edges[, "from"] %in% node_1[, c("id")],][, c("from", "to")],
                    by.x = "id",
                    by.y = "to")[, c("id", "label", "title", "color")])
    ## Cojo los nodos asociados a los links que llegan
    node_2b <- unique(merge(values$nodes,
                    values$edges[edges[, "to"] %in% node_1[, c("id")],][, c("from", "to")],
                    by.x = "id",
                    by.y = "from")[, c("id", "label", "title", "color")])

    node_2 <- unique(rbind(node_2a, node_2b))
    node_3a <- unique(rbind(node_1, node_2))
    return(node_3a)
}

lookfor_links <- function(select) {
    ## Input are the nodes currently displayed
    ## We pick those nodes that are not from DISNET (
    look_0 <- select[(select[, "title"] != "DISNET") &
                    (select[, "title"] != "Symptom"),]
                    #(select[, "title"] != "eMedicine") &
                    #(select[, "title"] != "OMIM") &
                    #(select[, "title"] != "ICD-O"),
    #print(look_0)
    if ((nrow(look_0) > 0) & (ncol(look_0) > 0)) {
        look_0$label_title <- paste(look_0$label, " - ", look_0$title)
        #print(look_0[, "label_title"])
        #print(values$withsymp[, "label_title"])
        #print(look_0[,"label_title"] %in% values$withsymp[, "label_title"])
        look <- subset(look_0, !(look_0$label_title %in% values$withsymp[,"label_title"]))
        look[, "label"] <- sapply(look[, "label"], as.character)
    } else {
        return (select)
    }
    #print(look)
    bind <- data.frame(look[, "label_title"])
    colnames(bind) <- c("label_title")
    #print(bind)
    values$withsymp <- rbind(values$withsymp, bind)
    #print(values$withsymp)
    ## We check if we already extracted them

    if ((nrow(look) > 0) & (ncol(look)>0)) {
        ## For those that not, we extract them and add them to the list
        for (i in row.names(look)) {
            if (i == row.names(look)[1]) {
                values$diseaseCode <- substr(look[i, "label"], unlist(gregexpr(pattern = '- .*', look[i, "label"])) + 2, nchar(look[i, "label"]))

                values$typeCode <- look[i, "title"]
                temp1 <- tryCatch(isolate(values$diseases_with_disnetconcepts_by_code_and_type()$diseaseList), error = function(e) return(1))

                if (typeof(temp1) == "list") {
                    cuis <- tryCatch(tidyr::unnest(temp1),
                            error = function(e) return(data.frame(to = character(),
                                                                    cui = character(),
                                                                    name1 = character(),
                                                                    title = character(),
                                                                    color = character())))
                } else {
                    cuis <- data.frame(to = character(),
                                    cui = character(),
                                    name1 = character(),
                                    title = character(),
                                    color = character())
                }
                if (nrow(cuis) > 0 & ncol(cuis) > 0) {
                    cuis$to <- look_0[i, "id"]
                } else {
                    to <- data.frame(to = character(),
                                    cui = character(),
                                    name1 = character(),
                                    title = character(),
                                    color = character())
                    cuis <- cbind(cuis, to)
                }
                #print(cuis)
            }
            else {
                values$diseaseCode <- substr(look[i, "label"], unlist(gregexpr(pattern = '- .*', look[i, "label"])) + 2, nchar(look[i, "label"]))
                #print(values$diseaseCode)
                values$typeCode <- look[i, "title"]
                temp1 <- tryCatch(isolate(values$diseases_with_disnetconcepts_by_code_and_type()$diseaseList), error = function(e) return(1))
                if (typeof(temp1) == "list") {
                    precuis <- tryCatch(tidyr::unnest(temp1),
                        error = function(e) return(data.frame(to = character(),
                                                            cui = character(),
                                                            name1 = character(),
                                                            title = character(),
                                                            color = character())))
                } else {
                    precuis <- data.frame(to = character(),
                                    cui = character(),
                                    name1 = character(),
                                    title = character(),
                                    color = character())
                }
                if (nrow(precuis) > 0 & ncol(precuis) > 0) {
                    precuis$to <- look_0[i, "id"]
                    cuis <- rbind(cuis, precuis)
                }
                #print(cuis)
            }
        }


        ## We select the the edges to add
        pre_edge <- cuis[, c("cui", "to")]
        colnames(pre_edge) <- c("from", "to")

        ## We select the ndoes to add
        if (nrow(cuis) > 0) {
            pre_node <- unique(cuis[, c("cui", "name1")])
            pre_node$title <- "Symptom"
            pre_node$color <- "black"
        } else {
            pre_node <- unique(cuis[, c("cui", "name1", "title", "color")])
        }
        colnames(pre_node) <- c("id", "label", "title", "color")
        pre_node <- pre_node[, c("title", "id", "label", "color")]
        pre_node <- subset(pre_node, !(pre_node[, "id"] %in% values$nodes[, "id"]))
        #print(!(pre_node$id %in% values$nodes$id))
        ## We add them to the global
        values$nodes <- unique(rbind(isolate(values$nodes), pre_node))
        values$edges <- unique(rbind(isolate(values$edges), pre_edge))

        ## We add them to the current selection

        select1 <- rbind(select, pre_node)
    }
    else {
        select1 <- select
    }

    return(select1)

    ## Mirar si estan ya buscados

    ## Llamar a los que no

    ## Guardar en nodes y edges

}