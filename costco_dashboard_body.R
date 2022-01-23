source('costco_dashboard_sidebar.R')

body <-
  dashboardBody(tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "main.css")
  ),
  fluidPage(
    fluidRow(
      valueBoxOutput("box1", width = 3),
      valueBoxOutput("box2", width = 3),
      valueBoxOutput("box3", width = 3),
      valueBoxOutput("box4", width = 3)
    ),
    fluidRow(box(
      title = "Histogram",
      plotlyOutput("plot1"), width = 8
    )),
    fluidRow(
      box(title = "Histogram",
          plotlyOutput("plot2"),
          width = 6),
      box(title = "Histogram",
          plotlyOutput("plot3"),
          width = 6)
    )
  ))
