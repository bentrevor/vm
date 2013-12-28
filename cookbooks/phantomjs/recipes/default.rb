package 'libfontconfig1-dev'

home_dir = node[:phantomjs][:home_dir]
username = node[:phantomjs][:username]

phantom_package = 'phantomjs-1.9.0-linux-i686'
phantom_url = "https://phantomjs.googlecode.com/files/#{phantom_package}.tar.bz2"
phantom_tar = "#{home_dir}/phantomjs.tar.bz2"
phantom_home = "#{home_dir}/.phantomjs"
phantom_unpacked_path = "#{home_dir}/#{phantom_package}"

# TODO: encapsulate this download/unpack/move dance
remote_file phantom_tar do
  source phantom_url
  mode '0644'
  user username
  group username
end

directory phantom_home do
  action :delete
  recursive true
end

bash 'unpack phantomjs' do
  user username
  group username
  code "tar xvjf #{phantom_tar} -C #{home_dir}"
end

bash 'move phantomjs' do
  user username
  group username
  code "mv #{phantom_unpacked_path} #{phantom_home}"
end

link "/usr/local/bin/phantomjs" do
  to "#{phantom_home}/bin/phantomjs"
  owner user
  group user
end

file phantom_tar do
  action :delete
end

