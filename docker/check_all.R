# bundled checks for protocols
library(protocolhelper)
check_all <- function(protocol_code) {
  fail <- FALSE
  tryCatch(
    protocolhelper::check_frontmatter(protocol_code),
    error = function(e) e,
    finally = fail <- TRUE
  )
  tryCatch(
    protocolhelper::check_structure(protocol_code),
    error = function(e) e,
    finally = fail <- TRUE
  )
  if (fail) {
    stop("\nThe source code failed some checks. Please check the error message above.\n")
  }
}
check_all(Sys.getenv("GITHUB_HEAD_REF"))  
