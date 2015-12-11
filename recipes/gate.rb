include_recipe 'apt'
package 'nginx'

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

gate_configure 'nginx' do
  auth(user: node.idata.user, pass: node.idata.pass)
  ssl(key: node.idata.ssl_key, cert: node.idata.ssl_cert)
end
