###################################################
##########           Layout        ################
###################################################

source("00 Welcome/module.R")
source("01 Graph/module.R")

# Header

header <- function(id) {
    ns <- NS(id)
    dashboardHeader(title = "DISNET Graph")
}

# Menu

sidebar <- function(id) {
    ns <- NS(id)
    sidebarMenu(
        Wel_menuItem("Welc"),
        Gra_menuItem("Graph")
    )
}

# Content

content <- function(id) {
    ns <- NS(id)
    do.call(tabItems, c(Wel_ui("Welc"), Gra_ui("Graph")))
}