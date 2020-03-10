library(rprojroot)
path_to_utils <- file.path(
  find_root(is_git_root),
  "src",
  "utils"
  )
source(file.path(path_to_utils, "maak_protocol.R"))

maak_svp(titel = "Klassieke vegetatieopname in een proefvlak aan de hand van visuele inschattingen van bedekking van soorten in (semi-)terrestrische vegetatie",
         subtitel = "", 
         korte_titel = "vegetatieopname terrestrisch",
         auteurs = "Els De Bie", 
         datum = "2016-07-19", 
         reviewers = "Hans Van Calster, Lieve Vriens, Jan Wouters, Wouter Van Gompel, Els Lommelen", 
         documentbeheerder = "Hans Van Calster", 
         revisie = "1.1", 
         thematiek = "vegetatie"
         )

maak_svp(titel = "Vegetatie-opname met behulp van de Tansley-schaal",
         subtitel = "", 
         korte_titel = "vegetatieopname tansley",
         auteurs = "Patrik Oosterlynck, Hans Van Calster", 
         datum = "2017-04-01", 
         reviewers = "Els Lommelen, Lieve Vriens, Jan Wouters, Bart Vandevoorde, Sam Provoost, Els De Bie, Steven Desaeger", 
         documentbeheerder = "Hans Van Calster", 
         revisie = "0.9.4", 
         thematiek = "vegetatie"
)


maak_svp(titel = "Vegetatieopname en LSVI-bepaling habitat 3260",
         subtitel = "", 
         korte_titel = "vegetatieopname habitat 3260",
         auteurs = "An Leyssen", 
         datum = "2017-02-07", 
         reviewers = "Luc Denys, Toon Westra, Hans Van Calster", 
         documentbeheerder = "Toon Westra", 
         revisie = "1.0", 
         thematiek = "vegetatie"
)


maak_svp(titel = "Beslisboom vegetatieopnames",
         subtitel = "bepalen vegetatiesamenstelling en relatieve abundanties", 
         korte_titel = "beslisboom vegetatieprotocols",
         auteurs = "Els De Bie, Hans Van Calster", 
         datum = "2016-09-15", 
         reviewers = "", 
         documentbeheerder = "Hans Van Calster", 
         revisie = "0.0", 
         thematiek = "vegetatie"
)


maak_svp(titel = "Vegetatie-opname met behulp van de beheermonitoringschaal",
         subtitel = "", 
         korte_titel = "vegetatieopnamen beheermonitoring",
         auteurs = "Patrik Oosterlynck, Hans Van Calster", 
         datum = "2017-04-01", 
         reviewers = "Els Lommelen, Lieve Vriens, Jan Wouters, Bart Vandevoorde, Sam Provoost, Els De Bie, Steven De Saeger", 
         documentbeheerder = "Hans Van Calster", 
         revisie = "0.3", 
         thematiek = "vegetatie"
)




