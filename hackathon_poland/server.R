library(shiny)
library(DT)
library(tidyverse)
library(rvest)
library(googlesheets4)
source("scrap_functions.R", local = TRUE)

options(
  gargle_oauth_email = "klojtek2@gmail.com",
  gargle_oob_default = TRUE,
  gargle_oauth_cache = ".secrets"
)

gs4_auth()

shinyServer(function(input, output, session) {
  
    google_sheet_db <- 'https://docs.google.com/spreadsheets/d/1DoGbrQuIWRApfNm2_og4V5-WYL1LoHPahVsozMAQgfk/edit?usp=sharing'

    scrap_data <- reactive({                   
      invalidateLater(86400000, session)    
      scrap_data <- get_data()
      googlesheets4::sheet_write(data = scrap_data ,ss = google_sheet_db, sheet = "current")
      scrap_data
    })
    
    g_sheet_data <- reactive({
      read_sheet(ss = google_sheet_db, sheet = "current")
    })
    
    output$table <- DT::renderDataTable(
                        DT::datatable(data <- g_sheet_data(), 
                                      rownames =  F,
                                      class = 'cell-border stripe',
                                      options = list(
                                          columnDefs = list(list(className = 'dt-center', targets = "_all"))
                                      )
                        )
                    )
})
