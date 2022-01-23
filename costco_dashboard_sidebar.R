source('costco_dashboard_header.R')

sidebar <- dashboardSidebar(sidebarMenu(
  menuItem(text = "Dashboard",
           tabName = "dashboard"),
  menuItem(text = "Guide",
           tabName = "wiki"),
  selectInput(
    inputId = "dateCom",
    label = "Mois de commande",
    choices = setNames(c(1:12), month.name)
  ),
  selectInput(
    inputId = "categorie",
    label = "Categorie",
    choices = df %>% select(categorie) %>% distinct()
  )
))