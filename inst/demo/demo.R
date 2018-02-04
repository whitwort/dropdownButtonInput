#' @import shiny
library(shiny)

ui <- fluidPage( titlePanel("Widget Demo")
               , fluidRow( column( width = 12
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
               , fluidRow( column ( width = 12
                                  , verbatimTextOutput(outputId = "selectedValue")
                                  )
                         )
               )

server <- function(input, output, session) {
  output$selectedValue <- renderText({ input$exampleButton })
}

shinyApp(ui, server)
