add_build_constants

cluster_tables

run_sql "general.sql"

unless has_build_flag :no_testdata then
  run_sql_folder "test_data"
end


synchronize_serials

$do_validate_contents = true if has_build_flag :validate
