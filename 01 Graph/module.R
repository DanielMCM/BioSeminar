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
        fluidRow(box("The idea is as follows: 
                        (i) instert diseases
                        (ii) click generate 1 level (each time you click you add adjacent nodes) 
                        (iii) if you click in add symptoms (then on generate 1 level), you will aggregate the symptoms to each non-DISNET node")), 
        fluidRow(box("ERRORS DETECTED:
                        (i) Some nodes produces error when calling to the API (Not responsive for some codes)
                        (ii) If all nodes have no CUI, it also return error
                        (iii) We recommend to start with a DISXXXXX node")),

        box(width = 3,
            h3("Query options"),
            selectizeInput(ns("select"), "Select any node", choices = NULL, options = NULL, multiple = TRUE),
            actionButton(ns("do_link"), "Add symptoms"),
            actionButton(ns("do"), "Generate 1 level conections"),
            actionButton(ns("reset"), "Reset graph")),
        box(width = 9, align = "Center",
            h2("Diseases graph"), p(verbatimTextOutput(ns("message"))),
            visNetworkOutput(ns("network")))))
}

# Server

Gra_server <- function(input, output, session) {
    updateSelectizeInput(session, "select", choices = isolate(values$nodes)[, "label"], server = TRUE)

    mark <- reactiveValues(counter = -1, counter_link = -1,
                            node_5 = data.frame(title = character(),
                                                id = character(),
                                                label = character(),
                                                color = character()))
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
        mark$counter_link <- 1
    })
    # Duplicar el concepto del boton para extraer sintomas


    node_4 <- eventReactive(input$do, {
        if (mark$counter_link == -1) {
            if (mark$counter == 0) {
                mark$node_5 <- node_3()
                return(mark$node_5)
            }
            else {
                mark$node_5 <- calculate_nodes(mark$node_5$label)
                return(mark$node_5)
            }
        }
        else {
            if (mark$counter < 0) {
                print("Nothing yet")
            }
            else {
                print(mark$counter_link)
                mark$node_5 <- lookfor_links(mark$node_5)
                mark$counter_link <- -1
                return(mark$node_5)
            }
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