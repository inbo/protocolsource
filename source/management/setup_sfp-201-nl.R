library(protocolhelper)

create_protocol(
  protocol_type = "sfp",
  title = "Bemonsteren aan de hand van oppervlaktemonsters",
  subtitle = "Manueel met steekguts",
  short_title = "Oppervlaktemonster",
  authors = c("Nathalie Cools", "Bruno De Vos"),
  date = Sys.Date(),
  reviewers = "Hans Van Calster",
  file_manager = "Hans Van Calster",
  version_number = paste0(format(Sys.Date(), "%Y"), ".00.dev"),
  theme = c("soil"),
  project_name,
  language = c("nl"),
  from_docx = "from_docx/SVP-201_Bemonstering bodem adhv oppervlaktemonsters_revisie_1.5.docx",
  protocol_number = "201",
  render = FALSE
)
