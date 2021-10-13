library(shiny)

app <- shinyApp(
  ui = fluidPage(
    uiOutput("country_flag")
  ),
  server = function(input, output, session) {
    
    selected_iso2 <- reactive({
      query <- parseQueryString(session$clientData$url_search)
      
      if (!is.null(query[['iso2']])) tolower(query[['iso2']]  )
      else "br"
    })
    
    output$country_flag <- renderUI({
      
      country_flag <- sprintf("https://cdn.rawgit.com/lipis/flag-icon-css/master/flags/4x3/%s.svg", selected_iso2())
      
      tagList(
        tags$img(src=country_flag, width = 70)
      )
    })
  }
)

runApp(app, port = 2233, launch.browser = T)
# try it in another tab
"http://127.0.0.1:2233/?iso2=IT"
