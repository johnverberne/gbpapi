add_build_constants

cluster_tables

run_sql "general.sql"

synchronize_serials

$do_validate_contents = true if has_build_flag :validate
