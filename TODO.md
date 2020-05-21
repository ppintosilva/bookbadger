# TODO

[] Write and execute script to cache badges as local svg files

[] Define writing cycle and iterations

[] Setup database
  - choose option, or combination of options, and implement:
    - dotfile in folder ".bookbadger" (json dump / csv file)
    - in memory database
    - sql lite (RSQLITE) -> it seems to be the best option
  - return tibble?

[] Implement functions to insert/get correct badge url/path 
   (which are then called by knitr or markdown url code):
  - inline badge: `r bookbadger::insert_badge(id = this)`
  - can we get id of the section that we're in from bookdown, so that id is 
    automatically filled?

[] Functions:
  - Used once (per project):
    - use_bookbadger (creates .bookbadger/bookeeper.db)
  - Used frequently
    - new/init (document version is increased by init, when applied the second 
            or more time to a section it requires the version argument,
            similar to usethis::use_version)
    - insert_badge / get_badge (id)
    - next_iteration(id)
    - get_ids and their state (cycle)
  - Used infrequently
    - use(id)

[] Document versioning
  
[] Optimise? It is expensive to connect to the database everytime insert_badge
   or next_cycle are called (this becomes very expensive in an R markdown
   file with many insert_badge calls). The package should typically start a new
   thread which has the pool object running in the background. Alternative seems
   to be to use pool as an alternative argument to the functions?
   So users can choose to mantain a pool object to speed up function calls
   (database queries).
  
[] Readme file:
  - diagram
  - example
  - main features (functions)
  - hexsticker

[] Create example
  - Vignette?
  - reprex?
