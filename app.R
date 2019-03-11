###################################################
##########           Libraries     ################
###################################################

library(shiny)
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
    callModule(Wel_server, "Welcome")
    callModule(Gra_server, "Graph")
}

shinyApp(ui, server)