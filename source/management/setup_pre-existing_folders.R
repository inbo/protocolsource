# one time setup

library(protocolhelper)
library(rprojroot)
path_to_from_docx <- find_root_file("from_docx", 
                                    criterion = is_git_root)

debugonce(create_sfp)

create_sfp(title = "Klassieke vegetatieopname in een proefvlak aan de hand van visuele inschattingen van bedekking van soorten in (semi-)terrestrische vegetatie",
           subtitle = "", 
           short_title = "vegopname terrest",
           authors = "Els De Bie", 
           date = "2016-07-19", 
           reviewers = c("Hans Van Calster", "Lieve Vriens", "Jan Wouters", "Wouter Van Gompel","Els Lommelen"), 
           file_manager = "Hans Van Calster", 
           version_number = "1.1.0.9000",
           theme = "vegetation",
           language = "nl",
           from_docx = 
             file.path(path_to_from_docx, 
                       "SVP_401_VegetatieOpnamePV_Terrestrisch_v1.1.docx"),
           protocol_number = "401", 
           render = TRUE)






# create_sfp(title = "Vegetatie-opname met behulp van de Tansley-schaal",
#            subtitle = "", 
#          short_title = "vegetatieopname tansley",
#          authors = "Patrik Oosterlynck, Hans Van Calster", 
#          date = "2017-04-01", 
#          reviewers = "Els Lommelen, Lieve Vriens, Jan Wouters, Bart Vandevoorde, Sam Provoost, Els De Bie, Steven Desaeger", 
#          file_manager = "Hans Van Calster", 
#          theme = "vegetatie"
# )
# 
# 
# create_sfp(title = "Vegetatieopname en LSVI-bepaling habitat 3260",
#          subtitle = "", 
#          short_title = "vegetatieopname habitat 3260",
#          authors = "An Leyssen", 
#          date = "2017-02-07", 
#          reviewers = "Luc Denys, Toon Westra, Hans Van Calster", 
#          file_manager = "Toon Westra", 
#          theme = "vegetatie"
# )
# 
# 
# create_sfp(title = "Beslisboom vegetatieopnames",
#          subtitle = "bepalen vegetatiesamenstelling en relatieve abundanties", 
#          short_title =  "beslisboom vegetatieprotocols",
#          authors = "Els De Bie, Hans Van Calster", 
#          date = "2016-09-15", 
#          reviewers = "", 
#          file_manager = "Hans Van Calster", 
#          theme = "vegetatie"
# )
# 
# 
# create_sfp(title = "Vegetatie-opname met behulp van de beheermonitoringschaal",
#          subtitel = "", 
#          korte_titel = "vegetatieopnamen beheermonitoring",
#          auteurs = "Patrik Oosterlynck, Hans Van Calster", 
#          datum = "2017-04-01", 
#          reviewers = "Els Lommelen, Lieve Vriens, Jan Wouters, Bart Vandevoorde, Sam Provoost, Els De Bie, Steven De Saeger", 
#          documentbeheerder = "Hans Van Calster", 
#          revisie = "0.3", 
#          thematiek = "vegetatie"
# )




