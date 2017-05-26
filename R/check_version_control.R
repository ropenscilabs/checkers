# To test this:
# gp(path=".", checks = "version_control",
#   extra_preps = list(version_control = prep_version_control),
#   extra_checks = list(version_control = check_version_control))


find_version_control <- function(path) {
    files <-  list.files(path = path,
                         all.files = TRUE,
                         recursive = TRUE)
    git_files <- length(grep(".git", files)) > 0
    svn_files <- length(grep(".svn", files)) > 0
    version_control <-  git_files | svn_files
    version_control
}



#' @export
#' @importFrom goodpractice make_prep
prep_version_control <- make_prep("version_control", function(path, quiet) {
    git_or_svn <- find_version_control(path)
  return(list(git_or_svn = git_or_svn))
})


#' @export
#' @importFrom goodpractice make_check
check_version_control <- make_check(

  description = "Project is under version control",
  tags = character(0),
  preps = c("version_control"),
  gp = function(state) {
    paste0(
      "Place your project under version control.",
      "You are using neither git nor svn."
    )
  },
  check = function(state) {
    return(state$version_control$git_or_svn)
  }
)



