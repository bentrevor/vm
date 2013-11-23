user = node[:rbenv][:user]
home_dir = node[:rbenv][:home_dir]

# rbenv repo
git "#{home_dir}/.rbenv" do
  repository 'https://github.com/sstephenson/rbenv.git'
  reference 'master'
  action :sync
end

bash 'adding rbenv command...' do
  code "echo '' >> ~/.zshrc"
  code "echo '# add rbenv command' >> ~/.zshrc"
  code "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> ~/.zshrc"
end

bash 'adding rbenv init to shell...' do
  code "echo '' >> ~/.zshrc"
  code "echo '# add rbenv init to shell' >> ~/.zshrc"
  code "echo 'eval \"$(rbenv init -)\"' >> ~/.zshrc"
end

# ruby-build plugin (gives you `rbenv install 2.0.0-p195
git "#{home_dir}/.rbenv/plugins/ruby-build" do
  repository 'https://github.com/sstephenson/ruby-build.git'
  reference 'master'
  action :sync
end

bash 'installing ruby 2.0.0-p353...' do
  code "rbenv install 2.0.0-p353"
end

