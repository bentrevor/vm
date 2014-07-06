package 'tmux'

user = node[:user]
home_dir = node[:home_dir]

cookbook_file "#{home_dir}/.tmux.conf" do
  owner user
  group user
end

remote_directory "#{home_dir}/.tmux" do
  source "scripts"
  owner user
  group user
end
