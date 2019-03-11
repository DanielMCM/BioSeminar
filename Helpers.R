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