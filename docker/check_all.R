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
    stop(
      sprintf("\nThe source code failed some checks.
              Please check the error messages:
              error in check_frontmatter: %1$s
              error in check_structure: %2$s",
              check_fm$message,
              check_str$message
      )
    )
  }
}
check_all(Sys.getenv("GITHUB_HEAD_REF"))  
