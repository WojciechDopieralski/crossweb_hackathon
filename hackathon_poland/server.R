library(shiny)
library(DT)
library(tidyverse)
library(rvest)
#devtools::install_github("tidyverse/googlesheets4")
library(googlesheets4)
source("C:\\Users\\x\\Desktop\\Nauka\\studia\\uep\\WIGE_mgr\\Sem_8\\asi\\projekt\\it_projects\\hackathon_poland\\scrap_functions.R")

shinyServer(function(input, output) {
    
    google_sheet_db <- 'https://docs.google.com/spreadsheets/d/1DoGbrQuIWRApfNm2_og4V5-WYL1LoHPahVsozMAQgfk/edit#gid=519553656'

    token <- gs4_auth(cache = FALSE, ude_oob = TRUE)

    saveRDS(token, file = "googlesheets_token.rds")

    suppressMessages(gs4_auth(token = "googlesheets_token.rds"))
    #sheet_write(data = test,ss = google_sheet_db, sheet = "current")
    
    liveish_data <- reactive({
        get_data()
    })
  
    output$table <- DT::renderDataTable(
                        DT::datatable(data <- liveish_data(), 
                                      rownames =  F,
                                      class = 'cell-border stripe',
                                      options = list(
                                          columnDefs = list(list(className = 'dt-center', targets = "_all"))
                                      )
                        )
                    )
})
