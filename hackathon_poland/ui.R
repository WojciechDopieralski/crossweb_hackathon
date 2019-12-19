
library(shiny)
library(shinydashboard)


shinyUI(
    dashboardPage(
        
        
        dashboardHeader(title = "IT events"),
        
        
        
        # Sidebar with a slider input for number of bins
        dashboardSidebar(

        ),
            
            
            # Show a plot of the generated distribution
            dashboardBody(
               
                dataTableOutput("table"),
                
            )
            
    )
)

