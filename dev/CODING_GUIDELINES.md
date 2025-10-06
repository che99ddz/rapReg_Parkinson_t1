# Coding Guidelines and Function Templates for rapRegTemplate

## 1. Documentation Style
- Use Roxygen2 comments (`#'`) above each function.
- Start with a short summary, followed by a blank line and a longer description if needed.
- Use tags for parameters (`@param`), return value (`@return`), and export (`@export`).

## 2. Naming Conventions
- Use `snake_case` for function and parameter names.
- Function names should be descriptive and action-oriented.

## 3. File Organization
- Place each function or related group of functions in its own `.R` file.
- Name files after their main function or purpose.

## 4. Shiny Modules
- Use the convention: `mod_<feature>_ui`, `mod_<feature>_server` for Shiny modules.

## 5. General Style
- Use consistent indentation (2 or 4 spaces).
- Avoid unnecessary blank lines.
- Keep function bodies concise and readable.
- Documentation and comments can be in Norwegian or English, but be consistent within a file.

---

# Function Templates

## 1. Simple Data Function
```r
#' Provide dataframe of fake registry data
#'
#' Provides a dataframe containing built-in data (not from registry) for demo purposes.
#'
#' @return regData data frame
#' @export
get_fake_reg_data <- function() {
  # ...function body...
}
```

## 2. Data Processing Function
```r
#' Prepare data for distribution analysis
#'
#' Preprocesses the input data for further analysis.
#'
#' @param data Input data frame
#' @return Processed data frame
#' @export
prepare_data_distribution <- function(data) {
  # ...function body...
}
```

## 3. Plotting Function
```r
#' Create distribution plot
#'
#' Generates a plot based on the provided data and variable.
#'
#' @param data Data frame
#' @param var Variable to plot
#' @return Plot object
#' @export
create_distribution_plot <- function(data, var) {
  # ...function body...
}
```

## 4. Shiny Module UI
```r
#' UI for distribution module
#'
#' Generates the UI for the distribution module.
#'
#' @param id Shiny module ID
#' @return Shiny UI element
#' @export
mod_distribution_ui <- function(id) {
  # ...function body...
}
```

## 5. Shiny Module Server
```r
#' Server logic for distribution module
#'
#' Implements the server-side logic for the distribution module.
#'
#' @param id Shiny module ID
#' @param data Data frame
#' @return Server function
#' @export
mod_distribution_server <- function(id, data) {
  # ...function body...
}
```

## 6. Longer Function Template (with UI and Server logic)
```r
#' Shiny module providing GUI and server logic for the report tab
#'
#' @param id Character string module namespace
#' @return A list containing UI and server logic
#' @export

mod_report_ui <- function(id) {
  ns <- shiny::NS(id)

  shiny::tabPanel(
    "Report Title",
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        width = 3,
        shiny::selectInput(
          inputId = ns("var"),
          label = "Variable:",
          choices = c("mpg", "disp", "hp")
        ),
        shiny::sliderInput(
          inputId = ns("bins"),
          label = "Number of bins:",
          min = 1,
          max = 10,
          value = 5
        ),
        shiny::selectInput(
          inputId = ns("format"),
          label = "Download format:",
          choices = list(PDF = "pdf", HTML = "html")
        ),
        shiny::downloadButton(
          outputId = ns("downloadReport"),
          label = "Download!"
        )
      ),
      shiny::mainPanel(
        shiny::uiOutput(ns("report"))
      )
    )
  )
}

#' Server logic for report module
#'
#' @param id Character string module namespace
#' @export
mod_report_server <- function(id) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      # Render report UI
      output$report <- shiny::renderUI({
        # ...render logic...
      })
      # Download handler
      output$downloadReport <- shiny::downloadHandler(
        filename = function() {
          # ...filename logic...
        },
        content = function(file) {
          # ...content logic...
        }
      )
    }
  )
}
```

---

Follow these templates and guidelines to maintain consistency and quality in your codebase.
