source('costco_dashboard_base.R')

############################################################
#                                                          #
#   Fichier didié au header de la page                     #
#                                                          #  
#                                                          #
############################################################

header <-
  dashboardHeader(
    # Add Costco logo
    title = tags$img(
      src = "2560px-Costco_Wholesale_logo_2010-10-26.png",
      height = 50,
      width = 150
    )
  )