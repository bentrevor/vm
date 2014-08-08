bash "installing vim-nox package..." do
  code <<-EOF
    sudo apt-get update
    sudo apt-get install vim-nox --yes
  EOF
end

user = node[:user]
home_dir = node[:home_dir]
vim_dir = "#{home_dir}/.vim"

git vim_dir do
  user user
  group user
  repository "https://github.com/bentrevor/vimfiles.git"
  reference "master"
  action :sync
end

bash "update bundle" do
  user user
  group user
  environment({"HOME" => home_dir})
  code <<-EOF
    cd #{vim_dir}
    ./update_bundles
  EOF
end

bash "chown vimdir, because of CHEF-3940" do
  code "chown -R #{user}:#{user} #{vim_dir}"
end
