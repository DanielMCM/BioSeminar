###################################################
#########        Graph   Module       ###########
###################################################

source(str_c("01 Graph/", "reactives.R"), local = TRUE)

Gra_menuItem <- function(id) {
    ns <- NS(id)
    menuItem("Graph", tabName = str_c(id, "Graph"), icon = icon("thumbs-up"))
}

# UI (tabs)

Gra_ui <- function(id) {
    ns <- NS(id)
    list(tabItem(tabName = str_c(id, "Graph"),
        box(width = 3,
            h3("Query options"),
            selectizeInput(ns("select"), "Select any node", choices = NULL, options = NULL, multiple = TRUE),
            actionButton(ns("do"), "Generate 1 level conexions"),
            actionButton(ns("reset"), "Reset graph")),
        box(width = 9, align = "Center",
            h2("Diseases graph"), p(verbatimTextOutput(ns("message"))),
            visNetworkOutput(ns("network")))))
}

# Server

Gra_server <- function(input, output, session) {

    output$message <- renderPrint({
        req(values$message)
        values$message
    })

    observe({
        # Trigger graph computing
        values$calculate_nodes_and_edges()
    })

    output$network <- renderVisNetwork({
        req(values$nodes)
        req(values$edges)

        print("Rendering VisNetwork...")

        return(visNetwork(values$nodes, values$edges, height = "2600px", width = "100%"))
    })
}