#' Shiny module providing GUI and server logic for the report tab
#'
#' @param id Character string module namespace
#' @return An shiny app ui object
#' @export

samlerapport_ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::tabPanel(
    "Fordeling av mpg",
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        width = 3,
        shiny::selectInput(
          inputId = ns("varS"),
          label = "Variabel:",
          c("mpg", "disp", "hp", "drat", "wt", "qsec")
        ),
        shiny::sliderInput(
          inputId = ns("binsS"),
          label = "Antall grupper:",
          min = 1,
          max = 10,
          value = 5
        ),
        shiny::selectInput(
          inputId = ns("formatS"),
          label = "Velg format for nedlasting:",
          choices = list(PDF = "pdf", HTML = "html")
        ),
        shiny::downloadButton(
          outputId = ns("downloadSamlerapport"),
          label = "Last ned!"
        )
      ),
      shiny::mainPanel(
        shiny::uiOutput(ns("samlerapport"))
      )
    )
  )
}

#' Server logic for samlerapport
#' @return A Shiny app server object
#' @export

samlerapport_server <- function(id) {
  shiny::moduleServer(
    id,
    function(input, output, session) {

      # Safe renderer that shows a friendly message if pandoc is missing
      safe_render_fragment <- function(srcFile, outputType = "html_fragment", params = list()) {
        if (!requireNamespace("rmarkdown", quietly = TRUE) || !rmarkdown::pandoc_available()) {
          htmltools::HTML(
            "<div class='alert alert-warning'><strong>Pandoc not found.</strong> Install Pandoc (or RStudio) to enable report rendering.</div>"
          )
        } else {
          tryCatch(
            rapbase::renderRmd(srcFile, outputType = outputType, params = params),
            error = function(e) {
              htmltools::HTML(sprintf(
                "<div class='alert alert-danger'><strong>Report rendering failed:</strong> %s</div>",
                htmltools::htmlEscape(conditionMessage(e))
              ))
            }
          )
        }
      }

      # Samlerapport
      ## vis
      output$samlerapport <- shiny::renderUI({
        src <- system.file("samlerapport.Rmd", package = "rapRegTemplate")
        safe_render_fragment(src, outputType = "html_fragment",
                             params = list(type = "html",
                                           var = input$varS,
                                           bins = input$binsS))
      })

      ## last ned
      output$downloadSamlerapport <- shiny::downloadHandler(
        filename = function() {
          basename(tempfile(pattern = "rapRegTemplateSamlerapport",
                            fileext = paste0(".", input$formatS)))
        },
        content = function(file) {
          if (!requireNamespace("rmarkdown", quietly = TRUE) || !rmarkdown::pandoc_available()) {
            stop("Pandoc not available; cannot build downloadable report. Install Pandoc or use RStudio.")
          }

          srcFile <-
            normalizePath(system.file("samlerapport.Rmd", package = "rapRegTemplate"))
          fn <- rapbase::renderRmd(srcFile, outputType = input$formatS,
                                   params = list(type = input$formatS,
                                                 var = input$varS,
                                                 bins = input$binsS))
          file.rename(fn, file)
        }
      )
    }
  )
}
