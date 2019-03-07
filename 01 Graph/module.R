###################################################
#########        Graph   Module       ###########
###################################################

Gra_menuItem <- function(id) {
    ns <- NS(id)
    menuItem("Grap", tabName = str_c(id, "Gra1"), icon = icon("thumbs-up"))
}

# UI (tabs)

Gra_ui <- function(id) {
    ns <- NS(id)
    list(tabItem(tabName = str_c(id, "Gra1"),
        fluidPage(
            column(12, align = "Center", h2(HTML("<b> Here comes the graph!! </b>"))
            ))))
}

# Server

Gra_server <- function(input, output, session) {
}