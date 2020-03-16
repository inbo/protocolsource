#' @title Create a folder with a markdown template to start working on a new fieldwork protocol
#'
#' @description This function will create a new folder based on values that are passed on via the parameters and creates a R-markdown skeleton based on a template file to start working on a new protocol.
#'
#' @param titel
#' @param subtitel
#' @param auteurs
#' @param datum
#' @param reviewers
#' @param documentbeheerder
#' @param revisie
#' @param projectnaam
#' @param thematiek
#'
#' @return A new subfolder beneath src with an Rmarkdown file
#'
#' @importFrom rprojroot find_root
#' @importFrom rprojroot is_git_root
#' @importFrom whisker whisker.render
#' @importFrom purrr map_chr
#' @importFrom stringr str_replace_all
#' @importFrom assertthat
#' assert_that
#' is.string
#' is.date
#' @examples
#' maak_protocol()
#'
maak_svp <- function(
  titel = "Titel",
  subtitel = "",
  korte_titel = "korte titel",
  auteurs = "voornaam1 naam1, voornaam2 naam2, ...",
  datum = Sys.Date(),
  reviewers = "voornaam1 naam1, voornaam2 naam2, ...",
  documentbeheerder = "voornaam naam",
  revisie = "0.1",
  projectnaam,
  thematiek = c("generiek", "water", "lucht", "bodem", "vegetatie", "soorten")) {
  
  # needed for as long as this function is not part of a package
  require(assertthat)
  require(rprojroot)
  require(whisker)
  require(purrr)
  require(stringr)
 
  
  # check parameters
  assert_that(is.string(titel))
  assert_that(is.string(subtitel))
  assert_that(is.string(korte_titel) & length(korte_titel) <= 20)
  assert_that(is.date(as.Date(datum)))
  assert_that(is.string(auteurs))
  assert_that(is.string(reviewers))
  assert_that(is.string(documentbeheerder))
  assert_that(is.string(revisie))
  if (!missing(projectnaam)) {
    assert_that(is.string(projectnaam))
  }
  thematiek <- match.arg(thematiek)
  assert_that(is.string(thematiek))
  
  # template folder
  project_root <- find_root(is_git_root)
  path_to_template <- file.path(project_root, "src", "utils", "template")
  
  # create protocol name
  
  protocol_type <- "svp"
  
  protocol_hoofdnummer <- switch(thematiek,
                                 generiek = "0",
                                 water = "1",
                                 bodem = "2",
                                 lucht = "3",
                                 vegetatie = "4",
                                 soorten = "5"
  )
  
  alle_nummers <- geef_protocolnummers(protocol_type = protocol_type)
  
  if (length(alle_nummers) == 0) {
    protocol_volgnummer <- "01"
  } else {
    nummers <- alle_nummers[
      str_detect(alle_nummers, 
                 pattern = paste0("^", protocol_hoofdnummer)
      )]
    protocol_volgnummer <- max(
      as.integer(
        str_extract(nummers, "\\d{2}$"))
    ) + 1
    protocol_volgnummer <- formatC(protocol_volgnummer, 
                                   width = 2, format = "d", flag = "0")
  }
  
  protocol_nummer <- paste0(protocol_hoofdnummer,
                            protocol_volgnummer)
  
  korte_titel <- tolower(korte_titel)
  korte_titel <- str_replace_all(korte_titel, " ", "-")
  korte_titels <- geef_korte_titels(protocol_type = protocol_type)
  assert_that(!(korte_titel %in% korte_titels), 
              msg = "De opgegeven korte titel bestaat al. Geef een korte titel die nog niet bestaat.")
  
  protocol_code <- paste0(protocol_type, "-", protocol_nummer)
  folder_name <- paste0(protocol_code, "_", korte_titel)
  folder_name <- tolower(folder_name)
  
  # directory setup
  if (missing(projectnaam)) {
    path_to_protocol <- file.path(project_root, "src", "thematic", thematiek, 
                                  folder_name)
  } else {
    path_to_protocol <- file.path(project_root, "src", "project", projectnaam, 
                                  thematiek, folder_name)
  }
  
  # check for existence of the folder
  if (dir.exists(path_to_protocol)) {
    stop(sprintf(paste0("De protocol repository bevat reeds ",
                        "een map voor %s!"), path_to_protocol))
  }
    # create a new directory
    dir.create(file.path(path_to_protocol), 
               recursive = TRUE)
  
  # move all files from the template folder and add info
  files <- list.files(path = path_to_template, 
                      full.names = FALSE,
                      recursive = FALSE, 
                      pattern = protocol_type)
  
  for (filename in files) {
    message("Preparing: ", filename)
    new_file_path <- file.path(path_to_protocol, filename)
    original_file_path <- file.path(path_to_template, filename)
   
    # create new file
    file.create(new_file_path)
    file.rename(from = new_file_path, 
                to = file.path(path_to_protocol, paste0(folder_name, ".Rmd")))
    new_file_path <- file.path(path_to_protocol, paste0(folder_name, ".Rmd"))
    
    # add original file content from reference, changing values
    original_file <- file(original_file_path, "r")
    original_file_content <- readLines(original_file)
    data <- list(titel = titel,
                 subtitel = subtitel,
                 auteurs = auteurs,
                 datum = datum,
                 reviewers = reviewers,
                 documentbeheerder = documentbeheerder,
                 revisie = revisie,
                 procedure = protocol_code
                 )
    writeLines(purrr::map_chr(original_file_content,
                              whisker::whisker.render,
                              data),
               new_file_path)
    close(original_file)
  }
}




#' @title Hulpfunctie voor het oplijsten van bestaande protocolnummers
#'
#' @param protocol_type
#'
#' @return Een vector met in gebruik zijnde protocolnummers (als character) voor een bepaald protocoltype.
#'
#' @importFrom rprojroot find_root
#' @importFrom rprojroot is_git_root
#' @importFrom assertthat
#' assert_that
#' is.string
#' @importFrom stringr
#' str_detect
#' str_extract
#' @examples
#' geef_protocolnummers()
#'
geef_protocolnummers <- function(protocol_type = c("svp", "sip", "sap", "sop")) {
  stopifnot(require(rprojroot))
  stopifnot(require(stringr))
  
  protocol_type <- match.arg(protocol_type)
  assert_that(is.string(protocol_type))
  
  project_root <- find_root(is_git_root)
  path_to_src <- file.path(project_root, "src")
  lf <- list.files(path = path_to_src, 
                   recursive = TRUE,
                   full.names = FALSE, 
                   ignore.case = TRUE
  )
  lf <- lf[str_detect(string = lf,
                      pattern = "^(.*)\\/(.*)(\\.Rmd)$")]
  lf <- gsub(pattern = "^(.*)\\/(.*)(\\.Rmd)$",
             replacement = "\\2",
             x = lf
  )
  lf <- lf[str_detect(string = lf,
                      pattern = protocol_type)]
  lf <- str_extract(string = lf, 
                    pattern = "(?<=p-)\\d{3}")
  lf <- lf[!is.na(lf)]
  
  return(lf)
}


#' @title Hulpfunctie voor het oplijsten van bestaande korte titels
#'
#' @param protocol_type
#'
#' @return Een vector met in gebruik zijnde korte titels (als character) voor een bepaald protocoltype.
#'
#' @importFrom rprojroot find_root
#' @importFrom rprojroot is_git_root
#' @importFrom assertthat
#' assert_that
#' is.string
#' @importFrom stringr
#' str_detect
#' str_extract
#' @examples
#' geef_korte_titels()
#'
geef_korte_titels <- function(protocol_type = c("svp", "sip", "sap", "sop")) {
  require(rprojroot)
  require(stringr)
  
  protocol_type <- match.arg(protocol_type)
  assert_that(is.string(protocol_type))
  
  project_root <- find_root(is_git_root)
  path_to_src <- file.path(project_root, "src")
  lf <- list.files(path = path_to_src, 
                   recursive = TRUE,
                   full.names = FALSE, 
                   ignore.case = TRUE
  )
  lf <- lf[str_detect(string = lf,
                      pattern = "^(.*)\\/(.*)(\\.Rmd)$")]
  lf <- gsub(pattern = "^(.*)\\/(.*)(\\.Rmd)$",
             replacement = "\\2",
             x = lf
  )
  lf <- lf[str_detect(string = lf,
                      pattern = protocol_type)]
  lf <- str_extract(string = lf, 
                    pattern = "(?<=\\d{3}_).*")
  lf <- lf[!is.na(lf)]
  
  return(lf)
}
