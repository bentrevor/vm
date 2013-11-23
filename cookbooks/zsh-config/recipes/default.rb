home_dir = node[:zsh][:home_dir]
user = node[:zsh][:user]

zsh_files_dir = "#{home_dir}/.zsh"

directory zsh_files_dir do
  user user
  group user
end

git "#{home_dir}/.oh-my-zsh" do
  repository "git://github.com/robbyrussell/oh-my-zsh.git"
  reference "master"
  action :sync
end

git "#{zsh_files_dir}/zsh-syntax-highlighting" do
  repository 'https://github.com/zsh-users/zsh-syntax-highlighting.git'
  reference 'master'
  action :sync
end

cookbook_file "#{home_dir}/.zsh/zsh-syntax-highlighting.zsh" do
  owner user
  group user
end

cookbook_file "#{home_dir}/.zshrc" do
  owner user
  group user
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
