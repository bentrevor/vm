package 'emacs23-nox'

user = node[:user]
home_dir = node[:home_dir]
emacs_dir = "#{home_dir}/.emacs.d"

git emacs_dir do
  repository "https://github.com/bentrevor/.emacs.d.git"
  reference "master"
  action :sync
end
