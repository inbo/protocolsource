library(protocolhelper)
library(dplyr)
install.packages("readr")
library(readr)
library(readxl)
# create_protocol(
#   protocol_type = "spp",
#   title = "Veldprotocol Kwaliteitsmeetnet Natura 2000 habitats partim heidehabitats",
#   short_title = "mhq heide",
#   authors = c("Oosterlynck, Patrik"),
#   orcids = c("0000-0002-5712-0770"),
#   reviewers = c("Hans Van Calster", "Toon Westra", "Leen Govaere"),
#   file_manager = "Patrik Oosterlynck",
#   project_name = "mhq",
#   language = "nl",
#   subtitle = "psammofiele heide (2310), buntgrasvegetaties (2330_bu), droge heide (4030), natte heide (4010)")

render_protocol(protocol_code = "spp-001-nl")
