source('costco_dashboard_sidebar.R')

body <-
  dashboardBody(tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "main.css"),
    tags$style("@import url(https://use.fontawesome.com/releases/v5.7.2/css/all.css);")
  ),
  fluidPage(
    fluidRow(
      valueBoxOutput("box1", width = 3),
      valueBoxOutput("box2", width = 3),
      valueBoxOutput("box3", width = 3),
      valueBoxOutput("box4", width = 3)
    ),
    fluidRow(box(
      title = "Month-to-Month Progress",
      plotlyOutput("plot1"), width = 12
    )),
    fluidRow(
      box(title = "Percent by categorie",
          plotlyOutput("plot2"),
          width = 6),
      box(title = "Histogram",
          plotlyOutput("plot3"),
          width = 6)
    )
  ))
