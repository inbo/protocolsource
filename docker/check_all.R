# bundled checks for protocols
library(protocolhelper)
check_all <- function(protocol_code) {
  check_fm <-
    tryCatch(
      protocolhelper::check_frontmatter(protocol_code),
      error = function(e) e
    )
  check_str <-
    tryCatch(
      protocolhelper::check_structure(protocol_code),
      error = function(e) e
    )
  if (inherits(check_fm, "error") | inherits(check_str, "error")) {
    stop("\nThe source code failed some checks. Please check the error message above.\n")
  }
}
check_all(Sys.getenv("GITHUB_HEAD_REF"))  
