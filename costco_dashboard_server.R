source('costco_dashboard_body.R')

ui <- dashboardPage(header = header,
                    sidebar = sidebar,
                    body = body)



server <- function(input, output) {
  x <- reactive({
    df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% group_by(date_com) %>% arrange(date_com) %>% select(date_com, ventes) %>% summarize(ventes = sum(ventes)) %>% filter(month(as.Date(date_com)) %in% input$dateCom) %>% pull(-2)
  })
  
  y <- reactive({
    df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% group_by(date_com) %>% arrange(date_com) %>% select(date_com, ventes) %>% summarize(ventes = sum(ventes)) %>% filter(month(as.Date(date_com)) %in% input$dateCom) %>% pull(-1)
  })
  
  xyCoords <- reactive({
    x <- x()
    y <- y()
    
    data.frame(col1 = x, col2 = y)
  })
  
  output$plot1 <-
    renderPlotly({
      xyCoords <- xyCoords()
      plot_ly(
        xyCoords,
        x0 = ~ col1,
        y = ~ col2,
        name = "Ventes par période",
        type = 'scatter',
        mode = 'lines'
      ) %>% layout(
        xaxis = list(
          title = "Months",
          dtick = "M12",
          tickformat = "%b-%Y",
          color  = "#c9d1d9",
          gridcolor = "#c9d1d9"
        ),
        yaxis = list (
          title = "Ventes in euros",
          color  = "#c9d1d9",
          gridcolor = "#c9d1d9"
        ),
        paper_bgcolor = "#161b22",
        plot_bgcolor = "#161b22"
      )
    })
  
  output$plot2 <-
    renderPlotly({
      xyCoords <- xyCoords()
      plot_ly(
        xyCoords,
        x0 = ~ col1,
        y = ~ col2,
        name = "Ventes par période",
        type = 'scatter',
        mode = 'lines'
      ) %>% layout(
        xaxis = list(
          title = "Months",
          dtick = "M12",
          tickformat = "%b-%Y",
          color  = "#c9d1d9",
          gridcolor = "#c9d1d9"
        ),
        yaxis = list (
          title = "Ventes in euros",
          gridcolor = "#c9d1d9" ,
          color  = "#c9d1d9"
        ),
        paper_bgcolor = "#161b22",
        plot_bgcolor = "#161b22"
      )
    })
  
  output$plot3 <-
    renderPlotly({
      xyCoords <- xyCoords()
      plot_ly(
        xyCoords,
        x0 = ~ col1,
        y = ~ col2,
        name = "Ventes par période",
        type = 'scatter',
        mode = 'lines'
      ) %>% layout(
        xaxis = list(
          title = "Months",
          dtick = "M12",
          tickformat = "%b-%Y",
          color  = "#c9d1d9",
          gridcolor = "#c9d1d9"
        ),
        yaxis = list (
          title = "Ventes in euros",
          color  = "#c9d1d9",
          gridcolor = "#c9d1d9"
        ),
        paper_bgcolor = "#161b22",
        plot_bgcolor = "#161b22"
      )
    })
  
  output$box1 <- renderValueBox({
    valueBox(
      df %>% select(nom_client, date_com) %>% filter(month(as.Date(date_com)) %in% input$dateCom) %>% n_distinct(),
      "Number of new users",
      icon = icon("user")
    )
  })
  
  output$box2 <- renderValueBox({
    valueBox(
      df %>% select(nom_client, date_com) %>% filter(month(as.Date(date_com)) %in% input$dateCom) %>% n_distinct(),
      "Number of new users",
      icon = icon("user")
    )
  })
  
  output$box3 <- renderValueBox({
    valueBox(
      df %>% select(nom_client, date_com) %>% filter(month(as.Date(date_com)) %in% input$dateCom) %>% n_distinct(),
      "Number of new users",
      icon = icon("user")
    )
  })
  
  output$box4 <- renderValueBox({
    valueBox(
      df %>% select(nom_client, date_com) %>% filter(month(as.Date(date_com)) %in% input$dateCom) %>% n_distinct(),
      "Number of new users",
      icon = icon("user")
    )
  })
}
shinyApp(ui, server)
