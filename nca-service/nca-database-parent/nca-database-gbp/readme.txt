mvn clean install -Pbuild -DskipTests

or

ruby ../nca-database-build/bin/Build.rb default.rb settings.rb --version=1.0-SNAPSHOT_${buildDateTime}_${buildRevision} --flags=validate,delete_setup_schema_and_redump,maven