###################################################
#########        Welcome   Module       ###########
###################################################

Wel_menuItem <- function(id) {
    ns <- NS(id)
    menuItem("Welcome", tabName = str_c(id, "Wel1"), icon = icon("thumbs-up"))
}

# UI (tabs)

Wel_ui <- function(id) {
    ns <- NS(id)
    list(tabItem(tabName = str_c(id, "Wel1"),
        fluidPage(
            column(12, align = "Center", h2(HTML("<b> Welcome to DISNET dashboard!! </b>")),
            p(HTML("<b> Daniel Minguez Camacho </b>")),
            p(HTML("<b> Javier de la Rua Martinez </b>")),
            p(HTML("<b> Filip Finfando </b>")))
            )))
}

# Server

Wel_server <- function(input, output, session) {
}