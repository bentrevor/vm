package 'ruby'
package 'rubygems'

bash 'installing ruby-install...' do
  code <<-EOH
    wget -O ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz
    tar -xzvf ruby-install-0.4.3.tar.gz
    cd ruby-install-0.4.3/
    sudo make install
EOH
end

bash 'installing ruby 1.9.3-p547' do
  code 'ruby-install ruby 1.9.3-p547'
end

bash 'installing ruby 2.1.2' do
  code 'ruby-install ruby 2.1.2'
end
