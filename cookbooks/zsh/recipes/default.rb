package 'zsh'

home_dir = node[:home_dir]
user = node[:user]

zsh_dir = "#{home_dir}/.zsh"

git zsh_dir do
  repository "https://github.com/bentrevor/zshfiles.git"
  reference "master"
  action :sync
end

bash "configure zsh" do
  user user
  group user
  environment({"HOME" => home_dir})
  code <<-EOF
    cd #{zsh_dir}
    ruby configure_zsh
  EOF
end

bash "chown zshdir, because of CHEF-3940" do
  code "chown -R #{user}:#{user} #{zsh_dir}"
end

bash 'make ZSH the default login shell' do
  code "chsh -s `which zsh` #{user}"
end

bash 'install tree' do
  code "apt-get install tree"
end

bash 'install acpi' do
  code "apt-get install acpi"
end

git "#{home_dir}/dotfiles" do
  user user
  group user
  repository "https://github.com/bentrevor/dotfiles.git"
  reference "master"
  action :sync
end

bash "link dotfiles" do
  user user
  group user
  environment({"HOME" => home_dir})
  code <<-EOF
    cd #{home_dir}/dotfiles
    source bootstrap.sh --username=#{user}
  EOF
end
