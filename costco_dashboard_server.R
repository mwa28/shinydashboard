source('costco_dashboard_body.R')

ui <- dashboardPage(header = header,
                    sidebar = sidebar,
                    body = body)



server <- function(input, output) {
  x <- reactive({
    df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% group_by(date_com) %>% arrange(date_com) %>% summarize(
      ventes = case_when(
        input$categorie == "Profit" ~ sum(profit),
        input$categorie == "Quantity" ~ sum(qtt),
        input$categorie == "Ventes" ~ sum(ventes),
        input$categorie == "Utilisateurs" ~ as.double(n_distinct(nom_client))
      )
    ) %>% mutate(year = format(date_com, "%Y")) %>% filter(year == input$yearCom) %>% select(date_com, ventes) %>% pull(-2)
  })
  
  y <- reactive({
    df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% group_by(date_com) %>% arrange(date_com) %>% summarize(
      ventes = case_when(
        input$categorie == "Profit" ~ sum(profit),
        input$categorie == "Quantity" ~ sum(qtt),
        input$categorie == "Ventes" ~ sum(ventes),
        input$categorie == "Utilisateurs" ~ as.double(n_distinct(nom_client))
      )
    ) %>% mutate(year = format(date_com, "%Y")) %>% filter(year == input$yearCom) %>% select(date_com, ventes) %>% pull(-1)
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
        x = ~ col1,
        y = ~ col2,
        type = 'scatter',
        mode = 'lines'
      ) %>% layout(
        xaxis = list(
          title = "Months",
          tickformat = "%b-%Y",
          color  = "#c9d1d9",
          gridcolor = "#c9d1d9"
        ),
        yaxis = list (
          title = paste(input$categorie, "in euros"),
          color  = "#c9d1d9",
          gridcolor = "#c9d1d9"
        ),
        paper_bgcolor = "#161b22",
        plot_bgcolor = "#161b22"
      )
    })
  
  x_cat <- reactive({
    df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% group_by(date_com, categorie) %>% arrange(date_com, categorie) %>% summarize(
      ventes = case_when(
        input$categorie == "Profit" ~ sum(profit),
        input$categorie == "Quantity" ~ sum(qtt),
        input$categorie == "Ventes" ~ sum(ventes),
        input$categorie == "Utilisateurs" ~ as.double(n_distinct(nom_client))
      )
    )  %>% mutate(year = format(date_com, "%Y")) %>% filter(year == input$yearCom, month(as.Date(date_com)) %in% input$dateCom) %>% select(categorie, ventes) %>% pull(-2)
  })
  
  y_cat <- reactive({
    df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% group_by(date_com, categorie) %>% arrange(date_com, categorie) %>% summarize(
      ventes = case_when(
        input$categorie == "Profit" ~ sum(profit),
        input$categorie == "Quantity" ~ sum(qtt),
        input$categorie == "Ventes" ~ sum(ventes),
        input$categorie == "Utilisateurs" ~ as.double(n_distinct(nom_client))
      )
    ) %>% mutate(year = format(date_com, "%Y")) %>% filter(year == input$yearCom, month(as.Date(date_com)) %in% input$dateCom) %>% select(categorie, ventes) %>%
      pull(-1)
  })
  
  xyCoords_cat <- reactive({
    x <- x_cat()
    y <- y_cat()
    
    data.frame(col1 = x, col2 = y)
  })
  
  output$plot2 <-
    renderPlotly({
      xyCoords <- xyCoords_cat()
      plot_ly(
        xyCoords,
        labels = ~ col1,
        values = ~ col2,
        type = 'pie'
      ) %>% layout(paper_bgcolor = "#161b22",
                   plot_bgcolor = "#161b22")
    })
  
  x_bar <- reactive({
    df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% group_by(date_com) %>% arrange(date_com) %>% mutate(year = format(date_com, "%Y")) %>% filter(year == input$yearCom, month(as.Date(date_com)) %in% input$dateCom) %>% group_by(categorie, pays_region) %>%  summarize(
      ventes = case_when(
        input$categorie == "Profit" ~ sum(profit),
        input$categorie == "Quantity" ~ sum(qtt),
        input$categorie == "Ventes" ~ sum(ventes),
        input$categorie == "Utilisateurs" ~ as.double(n_distinct(nom_client))
      )
    )
  })
  
  
  output$plot3 <-
    renderPlotly({
      xyCoords <- x_bar()
      plot_ly(
        xyCoords,
        x = ~ categorie,
        y = ~ ventes,
        color = ~ pays_region,
        type = "bar"
      ) %>% layout(
        xaxis = list(color  = "#c9d1d9",
                     gridcolor = "#c9d1d9"),
        yaxis = list (
          title = paste(input$categorie, "in euros"),
          color  = "#c9d1d9",
          gridcolor = "#c9d1d9"
        ),
        paper_bgcolor = "#161b22",
        plot_bgcolor = "#161b22"
      )
    })
  
  output$box1 <- renderValueBox({
    valueBox(
      format(df %>% select(nom_client, date_com) %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% mutate(year = format(date_com, "%Y")) %>% filter(year == input$yearCom) %>% summarise(count = n_distinct(nom_client)) %>% pull(), big.mark = " "),
      paste("Total number of users (", round((df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% mutate(year = format(date_com, "%Y")) %>% group_by(year) %>% filter(year == input$yearCom |
                                                                                                                                                                                           year == as.character(year(as.Date(input$yearCom , format="%Y")) - 1)) %>% summarize(ventes = n_distinct(nom_client)) %>% ungroup %>%
                                               mutate(change = 100 *
                                                        (ventes - lag(ventes)) / lag(ventes)) %>% select(change)
      )[2, ] %>% pull(), 1),
      "%)", sep=""),
      icon = icon("user")
    )
  })
  
  output$box2 <- renderValueBox({
    valueBox(
      paste(format(df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% mutate(year = format(date_com, "%Y")) %>% filter(year == input$yearCom) %>% summarize(ventes = sum(ventes)) %>% pull(), big.mark=" "), "€"),
      paste("Total Yearly Sales (",
            round((df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% mutate(year = format(date_com, "%Y")) %>% group_by(year) %>% filter(year == input$yearCom |
                                                                                                                                                                 year == as.character(year(as.Date(input$yearCom , format="%Y")) - 1)) %>% summarize(ventes = sum(ventes)) %>% ungroup %>%
                     mutate(change = 100 *
                              (ventes - lag(ventes)) / lag(ventes)) %>% select(change)
            )[2, ] %>% pull(), 1),
            "%)", sep=""),
      icon = icon("credit-card")
    )
  })
  
  output$box3 <- renderValueBox({
    valueBox(
      paste(format(df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% mutate(year = format(date_com, "%Y")) %>% filter(year == input$yearCom) %>% summarize(ventes = sum(profit)) %>% pull(), big.mark= " "), "€"),
     paste("Total Yearly Profit (" , round((df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% mutate(year = format(date_com, "%Y")) %>% group_by(year) %>% filter(year == input$yearCom |
                                                                                                                                                                                        year == as.character(year(as.Date(input$yearCom , format="%Y")) - 1)) %>% summarize(ventes = sum(profit)) %>% ungroup %>%
                                            mutate(change = 100 *
                                                     (ventes - lag(ventes)) / lag(ventes)) %>% select(change)
     )[2, ] %>% pull(), 1),
     "%)", sep=""),
      icon = icon("money-bill-alt")
    )
  })
  
  output$box4 <- renderValueBox({
    valueBox(
      format(df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% mutate(year = format(date_com, "%Y")) %>% filter(year == input$yearCom) %>% summarize(ventes = sum(qtt)) %>% pull(), big.mark =  " "),
      paste("Total Yearly Quantity Sold (", round((df %>% mutate(date_com = round_date(dmy(date_com), unit = "month")) %>% mutate(year = format(date_com, "%Y")) %>% group_by(year) %>% filter(year == input$yearCom |
                                                                                                                                                                                               year == as.character(year(as.Date(input$yearCom , format="%Y")) - 1)) %>% summarize(ventes = sum(qtt)) %>% ungroup %>%
                                                   mutate(change = 100 *
                                                            (ventes - lag(ventes)) / lag(ventes)) %>% select(change)
      )[2, ] %>% pull(), 1),
      "%)", sep=""),
      icon = icon("shopping-cart")
    )
  })
}
shinyApp(ui, server)
