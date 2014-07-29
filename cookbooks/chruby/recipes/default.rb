user = node[:user]
home_dir = node[:home_dir]

chruby_version = '0.3.8'
chruby_url = "https://github.com/postmodern/chruby/archive/v#{chruby_version}.tar.gz"
chruby_tar = "#{home_dir}/v#{chruby_tar}.tar.gz"
chruby_unpacked_path = "#{home_dir}/chruby-#{chruby_version}"

remote_file chruby_tar do
  source chruby_url
  mode '0644'
end

bash 'unpacking chruby...' do
  code "tar -xzvf #{chruby_tar} -C #{home_dir}"
end

file chruby_tar do
  action :delete
end

bash 'installing chruby...' do
  code <<-EOH
  cd #{chruby_unpacked_path}/
  sudo make install
EOH
end
