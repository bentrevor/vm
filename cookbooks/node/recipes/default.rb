%w(nodejs npm).each do |p|
  package p
end

bash 'setting npm registry' do
  code 'npm config set registry http://registry.npmjs.org/'
end

