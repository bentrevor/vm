include_recipe "java"

version = "2.2.0"
lein_user = node[:user]
lein_group = node[:user]
home_dir = node[:home_dir]

remote_file "/usr/local/bin/lein" do
  source "https://raw.github.com/technomancy/leiningen/#{version}/bin/lein"
  mode "0755"
  user lein_user
  group lein_group
  action :create_if_missing
end

directory "#{home_dir}/.lein" do
  user lein_user
  group lein_group
end

execute "lein_self_install" do
  command "export LEIN_ROOT=1; lein self-install; lein version"
  user lein_user
  group lein_group
  environment({"HOME" => home_dir})
  not_if { File.exists?("#{home_dir}/.lein/self-installs/leiningen-#{version}-standalone.jar") }
end
