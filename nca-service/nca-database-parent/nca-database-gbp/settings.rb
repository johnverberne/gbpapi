#
# Product specific settings. Can optionally override in app.User.rb (same location)
#

$product = :gbp    # The product these settings are for.

#-------------------------------------

sql_path = '/src/main/sql/'
data_path = '/src/data/sql/'
build_module = 'nca-database-build'
common_module = 'nca-database-common'
settings_file = 'NcaSettings.rb'

#-------------------------------------

$project_settings_file = File.expand_path(File.dirname(__FILE__) + '/../' + build_module + '/config/' + settings_file).fix_pathname

$common_sql_path = File.expand_path(File.dirname(__FILE__) + '/../' + common_module + '/' + sql_path).fix_pathname     # /nca-database-common/src/main/sql/
$product_sql_path = File.expand_path(File.dirname(__FILE__) + '/' + sql_path).fix_pathname                             # /src/main/sql/

$common_data_path = File.expand_path(File.dirname(__FILE__) + '/../' + common_module + '/' + data_path).fix_pathname    # /nca-database-common/src/data/sql/
$product_data_path = File.expand_path(File.dirname(__FILE__) + '/' + data_path).fix_pathname                            # /src/data/sql/
