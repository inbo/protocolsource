# one time setup

library(protocolhelper)
library(rprojroot)
path_to_from_docx <- find_root_file("from_docx", 
                                    criterion = is_git_root)

#debugonce(create_sfp)

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
           render = FALSE)

protocolhelper::render_protocol(
  protocol_folder_name = "sfp-401_vegopname-terrest_nl")







