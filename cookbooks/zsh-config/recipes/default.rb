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

bash "chown zshdir, because of CHEF-3940" do
  code "chown -R #{user}:#{user} #{zsh_dir}"
end

bash 'add default .rspec config' do
  code "echo '--color' >> ~/.rspec"
end

bash 'make ZSH the default login shell' do
  code "sudo chsh -s `which zsh` #{user}"
end

bash 'install things' do
  code "sudo apt-get install tree"
  code "sudo apt-get install acpi"
  code "sudo apt-get -y install libssl-dev" # for rbenv to install rubies
end

