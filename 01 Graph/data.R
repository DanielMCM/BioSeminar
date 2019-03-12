# Preprocessing

###
# EXTRACT INFO FROM API (QUERY3)
###

diseases_with_codes <- isolate(values$diseases_with_codes()$diseaseList)
#diseases_with_concepts <- values$diseases_with_disnetconcepts_by_diseasename()$diseaseList

# TODO: Remove truncation
#diseases_with_codes <- head(diseases_with_codes, n = 30)
#diseases_with_concepts <- head(diseases_with_concepts, n = 30)

# Disease with codes processing

###
# EXTRACT REFERENCES FROM DIFFERENT SOURCES
###

diseases_master <- unnest(diseases_with_codes)


#diseases_master$name2 <- paste(diseases_master$name, " - ", diseases_master$url)

###
# GENERATE NODES
###

nodes <- as.data.frame(unique(paste(diseases_master[, "diseaseId"], " - ", diseases_master[, "name"])))
nodes$title <- "DISNET"
colnames(nodes) <- c("label", "title")

uniq <- as.data.frame(unique(diseases_master[,c("code", "typeCode")]))
colnames(uniq) <- c("label", "title")
nodes <- rbind(nodes, uniq)
nodes$id <- seq.int(nrow(nodes))
colnames(nodes) <- c("label", "title", "id")

nodes <- nodes[,c(3,1,2)]

###
# LINK NODE ID TO MASTER
###

diseases_master$label1 <- paste(diseases_master[, "diseaseId"], " - ", diseases_master[, "name"])

diseases_master <- merge(diseases_master,nodes[,c("label", "id")], by.x="label1", by.y = "label")

diseases_master <- merge(diseases_master, nodes[, c("label", "title", "id")], by.x = c("code","typeCode"), by.y = c("label", "title"))

### 
# CREATE EDGES
###
edges <- diseases_master[, c("id.x", "id.y")]
colnames(edges) <- c("from", "to")

###
# ASSIGN COLORS TO NODES
###

uniq <- as.data.frame(unique(nodes[,"title"]))
uniq$colors <- distinctColorPalette(nrow(uniq))


colnames(uniq) <- c("title", "color")

nodes <- merge(nodes,
                    uniq,
                    by = "title")

#diseases_master$color <- "green"
###
# ASSIGN TO VALUES
###
values$nodes <- nodes
values$edges <- edges

