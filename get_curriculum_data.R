check_dir <- function(path) {
  if (!dir.exists(dirname(path)))
    dir.create(dirname(path), recursive = TRUE)
}

get_env_var <- function(var) {
  res <- Sys.getenv(var)

  if (identical(var, "")) {
    stop(sQuote(var), " not set as environment variable.")
  }

  res
}

store_lesson_data <- function(path = tempdir()) {
  storr::storr_external(storr::driver_rds(path = path),
                        get_all_lesson_data)
}

get_all_lesson_data <- function(key, namespace) {
  get_env_var("AIRTABLE_API_KEY")
  airtable_base <- get_env_var("AIRTABLE_LESSONS_KEY")
  repos <- airtabler::airtable(base = airtable_base, table = key)
  repos[[key]]$select_all()
}

repo_data <- store_lesson_data()$get("Repositories")


generate_curricula <- function(path = "_data/carpentries_curricula.json", ...) {

  check_dir(path)

  res <- repo_data[!is.na(repo_data$curriculum) |
                     as.logical(repo_data$is_official), "curriculum"]

  jsonlite::write_json(
    list(curricula = unique(res)),
    path = path, ...
  )
}

generate_lesson_feed <- function(path = "_data/carpentries_lessons.json", ...) {

  check_dir(path)

  ## TODO: add lesson title
  res <- repo_data[!is.na(repo_data$curriculum),
                   c("repository", "curriculum", "life_cycle",
                     "URL")]

  jsonlite::write_json(
    res,
    path = path, ...
  )

}
