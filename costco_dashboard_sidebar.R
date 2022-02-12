source('costco_dashboard_header.R')

############################################################
#                                                          #
#   Fichier didié au sidebar de la page                    #
#                                                          #  
#                                                          #
############################################################

# The tabs are Dashboard and User Guide
sidebar <- dashboardSidebar(sidebarMenu(
  menuItem(text = "Tableau de bord",
           tabName = "dashboard"),
  menuItem(text = "Guide",
           tabName = "wiki"),
  # Month selection for filtering the respective visuals
  selectInput(
    inputId = "dateCom",
    label = "Mois de commande",
    choices = setNames(c(1:12), c("Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"))
  ),
  # Year selection for filtering the respective visuals
  selectInput(
    inputId = "yearCom",
    label = "Annee de commande",
    choices = df %>% mutate(year = format(dmy(date_com), "%Y")) %>% select(year) %>% arrange(desc(year)) %>% distinct() %>% pull()
  ),
  # Decision variable selection as output variable in the visuals
  selectInput(
    inputId = "categorie",
    label = "Variable observee",
    choices = c("Profit", "Quantite", "Ventes", "Utilisateurs")
  )
))
