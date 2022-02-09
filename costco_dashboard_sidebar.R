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
    inputId = "yearCom",
    label = "Annee de commande",
    choices = df %>% mutate(year = format(dmy(date_com), "%Y")) %>% select(year) %>% arrange(desc(year)) %>% distinct() %>% pull()
  ),
  selectInput(
    inputId = "categorie",
    label = "Output Variable",
    choices = c("Profit", "Quantity", "Ventes", "Utilisateurs")
  )
))
