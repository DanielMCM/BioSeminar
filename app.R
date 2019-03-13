###################################################
##########           Libraries     ################
###################################################

library(shiny)
library(shinyjs)
library(shinydashboard)
library(ggplot2)
library(visNetwork)
library(stringr)
library(jsonlite)
library(plotrix)
library(randomcoloR)
library(tidyverse)

###################################################
##########           Sources       ################
###################################################

source("Global.R")
source("Layout.R")
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
    #tags$head(
      #tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")
    #),
    shinyjs::useShinyjs(debug = TRUE),
    tags$head(
        tags$style(HTML("
            .content {
                height: 92vh;
            }
            .tab-content, .tab-pane, full-height, .col-sm-2, .col-sm-10, .box, .box-body {
                height: 100% !important;
            }
            #Graph-network {
                height: 85% !important;
            }
        "))
      ),
    content("Content")
  )
)

###################################################
##########           Server        ################
###################################################

server <- function(input, output, session) {
    callModule(Wel_server, "Welcome")
    callModule(Gra_server, "Graph")
}

shinyApp(ui, server)