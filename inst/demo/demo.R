#' @import shiny
library(shiny)

ui <- fluidPage( titlePanel("Widget Demo")
               , fluidRow( column( offset = 1, width = 10
                                 , dropdownButtonInput( inputId  = 'exampleButton'
                                                      , label    = "Demo"
                                                      , elements = list( value1 = 1
                                                                       , value2 = "Demo"
                                                                       , NA
                                                                       , textAreaInput( 'exampleText'
                                                                                      , "Another input"
                                                                                      )
                                                                       )
                                                      )
                                 )
                         )
               , fluidRow( column (offset =1, width = 10
                                  , verbatimTextOutput(outputId = "selectedValue")
                                  )
                         )
               )

server <- function(input, output, session) {
  output$selectedValue <- renderText({ input$exampleButton })
}

shinyApp(ui, server)
