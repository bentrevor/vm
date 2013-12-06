package "vim-nox"

user = node[:vim][:user]
home_dir = node[:vim][:home_dir]
vim_dir = "#{home_dir}/.vim"

git vim_dir do
  repository "https://github.com/bentrevor/vimfiles.git"
  reference "master"
  action :sync
end

bash "update bundle" do
  environment({"HOME" => home_dir})
  code <<-EOF
    cd #{vim_dir}
    ruby update_bundles
  EOF
end

cookbook_file "#{vim_dir}/bundle/Colour-Sampler-Pack/colors/tomorrownight.vim" do
  owner user
  group user
end

link "#{home_dir}/.vimrc" do
  to "#{vim_dir}/.vimrc"
  owner user
  group user
end

bash "chown vimdir, because of CHEF-3940" do
  code "chown -R #{user}:#{user} #{vim_dir}"
end

