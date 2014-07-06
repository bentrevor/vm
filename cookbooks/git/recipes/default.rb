package "git-core"

user = node[:user]
home_dir = node[:home_dir]

template "#{home_dir}/.gitconfig" do
  owner user
  group user
  variables :full_name => node[:full_name],
            :email => node[:email]
end

cookbook_file "#{home_dir}/.gitignore_global" do
  owner user
  group user
end
