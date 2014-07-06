
mysql_service node['mysql']['service_name'] do
  version  '5.5'
  port     '3306'
  data_dir '/var/lib/mysql'
  server_root_password   Secrets.mysql_server_root_password
  server_debian_password Secrets.mysql_server_debian_password
  server_repl_password   Secrets.mysql_server_repl_password
  allow_remote_root      false
  remove_anonymous_users true
  remove_test_database   nil
  root_network_acl       nil

  action :create
end
