source('costco_dashboard_sidebar.R')

############################################################
#                                                          #
#   Fichier didié au body de la page                       #
#                                                          #
#                                                          #
############################################################

body <-
  dashboardBody(tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "main.css") # custom css for dark theme styling
  ),
  tabItems(
    tabItem(tabName = "dashboard",
            fluidPage(
              # Upper Info Card Section
              fluidRow(
                valueBoxOutput("box1", width = 3),
                valueBoxOutput("box2", width = 3),
                valueBoxOutput("box3", width = 3),
                valueBoxOutput("box4", width = 3)
              ),
              # First Visual (Monthly evolution)
              fluidRow(box(
                title = "Evolution annuelle",
                plotlyOutput("plot1"), width = 12
              )),
              # Second Visual (Percent per category)
              fluidRow(
                box(title = "Repartition par categorie",
                    plotlyOutput("plot2"),
                    width = 6),
                # Third Visual (Distribution per country map)
                box(title = "Cartographie",
                    plotlyOutput("plot3"),
                    width = 6)
              )
            )),
    tabItem(tabName = "wiki",
            includeMarkdown("guide.md"))
    
  ))
