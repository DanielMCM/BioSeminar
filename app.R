###################################################
##########           Libraries     ################
###################################################

library(shiny)
library(shinydashboard)
library(ggplot2)
library(visNetwork)
library(stringr)

###################################################
##########           Sources       ################
###################################################

source("Layout.R")
source("Global.R")
source("Helpers.R")

###################################################
##########           UI            ################
###################################################

ui <- dashboardPage(
  header("Header"),
  dashboardSidebar(
    sidebar("Sidebar")
  ),
  dashboardBody(
    #shinyDashboardThemes(
      #theme = "blue gradient"
    #),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css")
    ),
    content("Content")
  )
)

###################################################
##########           Server        ################
###################################################

server <- function(input, output, session) {
    callModule(Wel_server, "Welc")
    callModule(Gra_server, "Grap")
}

shinyApp(ui, server)