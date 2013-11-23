user = node[:rbenv][:user]
home_dir = node[:rbenv][:home_dir]
rbenv_dir = "#{home_dir}/.rbenv"

# rbenv repo
git rbenv_dir do
  repository 'https://github.com/sstephenson/rbenv.git'
  reference 'master'
  action :sync
end

directory "#{rbenv_dir}/shims" do
  user user
  group user

  action :create
end

directory "#{rbenv_dir}/versions" do
  user user
  group user

  action :create
end

directory "#{rbenv_dir}/plugins" do
  user user
  group user

  action :create
end

# ruby-build plugin (gives you `rbenv install 2.0.0-p195`)
git "#{rbenv_dir}/plugins/ruby-build" do
  repository 'https://github.com/sstephenson/ruby-build.git'
  reference 'master'
  action :sync
end

bash 'installing bundler...' do
  code "sudo gem install bundler"
end

cookbook_file "#{home_dir}/.ruby-version" do
  owner user
  group user
end

