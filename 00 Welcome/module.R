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
            column(12, align = "Center", h2(style = "font-size: 4em; margin: 60px 0 80px;", HTML("<b>Welcome to DISNET dashboard</b>"))),
            column(4, align = "Center", p(style = "font-size: 1.4em", "Daniel Minguez Camacho")),
            column(4, align = "Center", p(style = "font-size: 1.4em", "Javier de la Rua Martinez")),
            column(4, align = "Center", p(style = "font-size: 1.4em", "Filip Finfando")))))
}

# Server

Wel_server <- function(input, output, session) {
}