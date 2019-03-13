###################################################
#########        Graph   Module       ###########
###################################################

source(str_c("01 Graph/", "Reactives.R"), local = TRUE)
source(str_c("01 Graph/", "data.R"), local = TRUE)

Gra_menuItem <- function(id) {
    ns <- NS(id)
    menuItem("Graph", tabName = str_c(id, "Graph"), icon = icon("thumbs-up"))
}

# UI (tabs)

Gra_ui <- function(id) {
    ns <- NS(id)
    list(tabItem(tabName = str_c(id, "Graph"),
        box(width = 2, style = "height:100%;",
            h3("Query options"),
            selectizeInput(ns("select"), "Select any node", choices = NULL, options = NULL, multiple = TRUE),
            actionButton(ns("do"), "Generate 1 level conections", style = "margin: 2px 0; width: 100%;"),
            #actionButton(ns("do_link"), "Call for symptoms", style = "margin: 2px 0; width: 100%;"),
            actionButton(ns("reset"), "Reset graph", style = "margin: 8px 0 24px 0; width: 100%;"),
            div(style="margin: 4px 0;", HTML("<b>INSTRUCTIONS:</b> Select a disease or code and click on 'Generate 1 level conections' to expand one level of conections from the existent nodes per click.")),
            div(HTML("<b>RESET:</b> In order to reset the values: Click on the 'reset' button, choose another value in the combobox and click on 'Generate 1 level conections' again."))),
        box(width = 10, align = "Center", style = "height:100%;",
            h2("Diseases graph"), p(verbatimTextOutput(ns("message"))),
            visNetworkOutput(ns("network")))))
}

# Server

Gra_server <- function(input, output, session) {
    updateSelectizeInput(session, "select", choices = isolate(values$nodes)[, "label"], server = TRUE)

    mark <- reactiveValues(counter = -1,
                            node_5 = data.frame(id = character(),
                                                label = character(),
                                                group = character()))
    node_3 <- reactive({
        calculate_nodes(input$select)
    })

    observeEvent(input$do, {
        mark$counter <- mark$counter + 1
    })

    observeEvent(input$reset, {
        mark$counter <- -1
    })

    observeEvent(input$do_link, {
        lookfor_links()
    })

    # Duplicar el concepto del boton para extraer sintomas


    node_4 <- eventReactive(input$do, {
        if (mark$counter == 0) {
            mark$node_5 <- node_3()
            return(mark$node_5)
        }
        else {
            mark$node_5 <- calculate_nodes(mark$node_5$label)
            return(mark$node_5)
        }
    })

    output$network <- renderVisNetwork({
    #ledges <- data.frame(color = c("#339933",
                                #rgb(252, 0, 0, max = 255), "lightblue"),
                                #label = c("European Contribution under 993K",
                                          #"European Contribution above 993K",
                                          #"Researcher"))
    # minimal example
        visNetwork(node_4(),
               values$edges[(values$edges[, "from"] %in% node_4()[, c("id")]) & (values$edges[, "to"] %in% node_4()[, c("id")]),],
               height = "1000px", width = "100%") %>%
               visOptions(highlightNearest = list(enabled = T, degree = 1, hover = T),
                            nodesIdSelection = T) %>%
        visIgraphLayout() %>%
        visPhysics(stabilization = FALSE) %>%
        visInteraction(hideEdgesOnDrag = TRUE) %>%
        visEdges(smooth = FALSE)
    })
    #observe({
        ## Trigger graph computing
        #values$calculate_nodes_and_edges()
    #})

    #output$network <- renderVisNetwork({
        #req(values$nodes)
        #req(values$edges)

        #print("Rendering VisNetwork...")

        #return(visNetwork(values$nodes,
                          #values$edges,
                          #height = "2600px",
                          #width = "100%",
                          #visIgraphLayout() %>%
                            #visPhysics(stabilization = FALSE) %>%
                            #visLegend(addEdges = ledges, useGroups = TRUE) %>%
                            #visInteraction(hideEdgesOnDrag = TRUE) %>%
                            #visEdges(smooth = FALSE)
                          #) #Visnetwork
              #) #Return
    #})
}