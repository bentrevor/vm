home_dir = node[:zsh][:home_dir]
user = node[:zsh][:user]

zsh_dir = "#{home_dir}/.zsh"

git zsh_dir do
  repository "https://github.com/bentrevor/zshfiles.git"
  reference "master"
  action :sync
end

bash "configure zsh" do
  environment({"HOME" => home_dir})
  code <<-EOF
    cd #{zsh_dir}
    ruby configure_zsh
  EOF
end

link "#{home_dir}/.zshrc" do
  to "#{zsh_dir}/.zshrc"
  owner user
  group user
end

link "#{home_dir}/zsh-syntax-highlighting.zsh" do
  to "#{zsh_dir}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  owner user
  group user
end

# git "#{home_dir}/.oh-my-zsh" do
#   repository "git://github.com/robbyrussell/oh-my-zsh.git"
#   reference "master"
#   action :sync
# end

bash "chown zshdir, because of CHEF-3940" do
  code "chown -R #{user}:#{user} #{zsh_dir}"
end

bash 'add default .rspec config' do
  code "echo '--color' >> ~/.rspec"
end

bash 'make ZSH the default login shell' do
  code "sudo chsh -s `which zsh` #{user}"
end

bash 'install tree' do
  code "sudo apt-get install tree"
end

bash 'install acpi' do
  code "sudo apt-get install acpi"
end

bash 'install libssl-dev (so rbenv can install rubies)' do
  code "sudo apt-get -y install libssl-dev"
end

