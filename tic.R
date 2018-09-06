get_stage("before_install") %>%
  add_code_step(update.packages(ask = FALSE))

get_stage("install") %>%
  add_code_step(install.packages(requirements::req_file("get_curriculum_data.R")))

get_stage("deploy") %>%
  add_code_step(source("get_curriculum_data.R")) %>%
  add_code_step(generate_curricula()) %>%
  add_code_step(generate_lesson_feed())


if (Sys.getenv("id_rsa") != "") {
  # pkgdown documentation can be built optionally. Other example criteria:
  # - `inherits(ci(), "TravisCI")`: Only for Travis CI
  # - `ci()$is_tag()`: Only for tags, not for branches
  # - `Sys.getenv("BUILD_PKGDOWN") != ""`: If the env var "BUILD_PKGDOWN" is set
  # - `Sys.getenv("TRAVIS_EVENT_TYPE") == "cron"`: Only for Travis cron jobs
  get_stage("before_deploy") %>%
    add_step(step_setup_ssh())

  get_stage("deploy") %>%
    add_step(step_push_deploy(path = "_data", branch = "gh-pages"))
}
