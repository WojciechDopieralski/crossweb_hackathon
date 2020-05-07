library(shiny)
library(shinydashboard)


shinyUI(
    dashboardPage(
      
        dashboardHeader(title = "IT events"),
      
        # Sidebar
        dashboardSidebar(
        ),
            dashboardBody(
                DT::dataTableOutput("table")
            )
    )
)
