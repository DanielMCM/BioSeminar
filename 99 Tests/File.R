b <- unnest(a)

edges <- b[, c("diseaseId", "code")]
b$name2 <- paste(b$name, ", ", b$url)
nodes <- unique(b[,c("diseaseId", "name2")])
nodes$title <- "DISNET"
nodes$color <- "blue"
b$color <- "green"
temp <- unique(b[, c("code", "code", "typeCode", "color")])
colnames(temp) <- c("id", "label", "title", "color")
colnames(nodes) <- c("id", "label", "title", "color")
nodes <- rbind(nodes, temp)