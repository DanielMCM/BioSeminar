calculate_nodes <- function(selection) {
    ## Links que salen de la seleccion
    node_1a <- unique(merge(values$nodes[values$nodes[, "label"] %in%
                        selection,],
                    values$edges[, c("from", "to")],
                    by.x = "id",
                    by.y = "from",
                    all.y = FALSE)[, c("id", "label", "title", "color")])
    ## Links que llegan a la seleccion
    node_1b <- unique(merge(values$nodes[values$nodes[, "label"] %in%
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
                    (select[, "title"] != "Wheeless Online") &
                    (select[, "title"] != "Patient UK"), 
                    #(select[, "title"] != "eMedicine") &
                    #(select[, "title"] != "OMIM") &
                    #(select[, "title"] != "ICD-O"),
    ]
    print(look_0)
    look_0$withsymp <- paste(look_0$label, " - ", look_0$title)

    ## We check if we already extracted them
    look <- subset(look_0, !(look_0$withsymp %in% values$withsymp$label_title))
    if ((nrow(look) > 0) & (ncol(look)>0)) {
        ## For those that not, we extract them and add them to the list
        for (i in 1:nrow(look)) {
            if (i == 1) {
                values$diseaseCode <- look[i, "label"]
                values$typeCode <- look[i, "title"]
                cuis <- isolate(unnest(values$diseases_with_disnetconcepts_by_code_and_type()$diseaseList))
                
                if (nrow(cuis) > 0 & ncol(cuis) > 0) {
                    cuis$to <- look_0[i, "id"]
                    values$withsymp <- rbind(isolate(values$withsymp), look_0[i, "withsymp"])
                } else {
                    to <- data.frame(to = character(), cui = character())
                    cuis <- cbind(cuis, to)
                }

            }
            else {
                values$diseaseCode <- look[i, "label"]
                values$typeCode <- look[i, "title"]
                precuis <- isolate(unnest(values$diseases_with_disnetconcepts_by_code_and_type()$diseaseList))
                if (nrow(precuis) > 0 & ncol(precuis) > 0) {
                    precuis$to <- look_0[i, "id"]
                    cuis <- rbind(cuis, precuis)
                    values$withsymp <- rbind(isolate(values$withsymp), look_0[i, "withsymp"])
                }
                print(cuis)
            }
        }


        ## We select the the edges to add
        pre_edge <- cuis[, c("cui", "to")]
        colnames(pre_edge) <- c("from", "to")

        ## We select the ndoes to add
        pre_node <- unique(cuis[, c("cui", "name1")])
        colnames(pre_node) <- c("id", "label")
        pre_node$title <- "Symptom"
        pre_node$color <- "black"
        pre_node <- pre_node[, c("title", "id", "label", "color")]

        ## We add them to the global
        values$nodes <- rbind(isolate(values$nodes), pre_node)
        values$edges <- rbind(isolate(values$edges), pre_edge)

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