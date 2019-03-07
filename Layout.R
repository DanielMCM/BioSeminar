###################################################
##########           Layout        ################
###################################################

source("00 Welcome/module.R")
source("01 Graph/module.R")

# Header

header <- function(id) {
    ns <- NS(id)
    dashboardHeader(title = "DISNET Graph")
    #dropdownMenu(type = "notifications", icon = icon("warning"), badgeStatus = "warning",
                                 #notificationItem("Some tabs take a while to load")),
    # )
    #)
}

# Menu

sidebar <- function(id) {
    ns <- NS(id)
    sidebarMenu(
        Wel_menuItem("Welc"),
        Gra_menuItem("Grap")
    )
}

# Content

content <- function(id) {
    ns <- NS(id)
    do.call(tabItems, c(Wel_ui("Welc"), Gra_ui("Grap")))
}