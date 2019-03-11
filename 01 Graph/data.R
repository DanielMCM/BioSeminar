# Preprocessing

diseases_with_codes <- isolate(values$diseases_with_codes()$diseaseList)
#diseases_with_concepts <- values$diseases_with_disnetconcepts_by_diseasename()$diseaseList

# TODO: Remove truncation
#diseases_with_codes <- head(diseases_with_codes, n = 30)
#diseases_with_concepts <- head(diseases_with_concepts, n = 30)

# Disease with codes processing

diseases_master <- unnest(diseases_with_codes)

edges <- diseases_master[, c("diseaseId", "code")]
colnames(edges) <- c("from", "to")

#diseases_master$name2 <- paste(diseases_master$name, " - ", diseases_master$url)


nodes <- unique(diseases_master[, c("diseaseId", "name")])
nodes$title <- "DISNET"
colnames(nodes) <- c("id", "label","title")

uniq <- as.data.frame(unique(diseases_master$typeCode))
colors <- distinctColorPalette(nrow(uniq)+1)
nodes$color <- colors[1]
uniq$colors <- colors[2:length(colors)]
uniq$color2 <- sapply(uniq[, 2], color.id)

colnames(uniq) <- c("typeCode", "color", "color1")

diseases_master <- merge(diseases_master,
                    uniq,
                    by = "typeCode")

#diseases_master$color <- "green"

temp <- unique(diseases_master[, c("code", "code", "typeCode", "color")])
colnames(temp) <- c("id", "label", "title", "color")

nodes <- rbind(nodes, temp[,c("id","label", "title","color")])

values$nodes <- nodes
values$edges <- edges


diseases_with_concepts <- values$diseases_with_disnetconcepts_by_diseasename()$diseaseList