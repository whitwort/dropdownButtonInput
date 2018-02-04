#' @import shiny
#' @import htmltools
NULL
library(shiny)
library(htmltools)

#' Dropdown button Shiny input widget
#'
#' @param inputId  The input slot that will be used to access the value.
#' @param label    The contents of the button or link–usually a text label, but
#'   you could also use any other HTML, like an image.
#' @param elements A list of elements to display in the dropdown menu when the
#'   button is clicked.  Each element in the list can be one of 3 things:  (1) a
#'   named value, in which case the name will be displayed and the input bound
#'   to value when it is clicked, (2) a shiny.tag object, which is displayed
#'   as-is, or (3) NA which inserts a divider.
#' @param width    Forced width for the dropdown menu.
#' @param class    Additional element classes
#' @param icon     An optional \code{\link{shiny::icon}} to appear on the
#'   button.
#' @param ...      Additional attributes sent to \code{\link{shiny::div}}
#'
#' @return         Shiny tag list suitable for use in a Shiny UI.
#' @export
dropdownButtonInput <- function(inputId, label, elements, width = NULL, class = NULL, icon = NULL, ...) {

  elements <- as.list(elements)

  ui <- div( id     = inputId
           , class  = "btn-group shiny-input-container dropdown-button-input"
           , tags$button( type  = "button"
                        , class = paste("btn btn-default dropdown-toggle", class)
                        , `data-toggle`  = "dropdown"
                        , `aria-expanded` = "false"
                        , icon
                        , label
                        , tags$span(class = "caret")
                        )
           , tags$ul( class = "dropdown-menu"
                    , style = if (!is.null(width)) {
                                paste('"width:', width, '"')
                              } else {
                                '""'
                              }
                    , role  = "menu"
                    , lapply( 1:length(elements)
                            , function(i) {
                                name  <- names(elements[i])
                                value <- elements[[i]]
                                if (identical(value, NA)) {
                                  tags$li(class = "divider")
                                } else if (is(value, 'shiny.tag')) {
                                  column(width = 12, tags$li(value))
                                } else {
                                  tags$li(tags$a( href  = "#"
                                                , value = value
                                                , name
                                                )
                                         )
                                }
                              }
                            )
                    , ...
                    )
           )

  addResourcePath( prefix        = "dropdownButtonInput"
                 , directoryPath = system.file("www", package = "dropdownButtonInput")
                 )

  tagList( singleton(tags$head(tags$script(src = "dropdownButtonInput/dropdown-button-input.js")))
         , ui
         )

}

#' Update the value of a dropdown button input
#'
#' @param session Shiny server session object
#' @param inputId Input id for the dropdown button to update
#' @param value   New value for the button
#'
#' @export
updateDropdownButtonInput <- function(session, inputId, value = NULL) {
  if (!is.null(value)) {
    session$sendInputMessage(inputId, list(value = value))
  }
}

#' Run a demo Shiny app
#'
#' Launches a little Shiny app to demo the widget.
#'
#' @export
demoApp <- function() {
  runApp( file.path(system.file("demo", package = "dropdownButtonInput"), "demo.R")
        , display.mode = 'showcase'
        )
}

