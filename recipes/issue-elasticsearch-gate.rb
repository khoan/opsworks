package 'nginx'

#user 'www-data' do
#  comment "Nginx User"
#  system true
#  shell "/bin/false"
#end
#
#group 'www-data' do
#  members 'www-data'
#end

# Create service for Nginx (/sbin/service nginx)
service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

## Create log directory
#directory "/var/log/nginx" do
#  mode 0755
#  owner 'root'
#  action :create
#  recursive true
#end

# Create Nginx main configuration file
template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  mode 0644
end


# Create proxy with HTTP authentication via Nginx
template "/etc/nginx/conf.d/elasticsearch_proxy.conf" do
  source "elasticsearch_proxy.conf.erb"
  owner 'www-data' and group 'www-data' and mode 0755
  notifies :reload, 'service[nginx]'
end

ruby_block "add users to passwords file" do
  block do
    require 'webrick/httpauth/htpasswd'
    @htpasswd = WEBrick::HTTPAuth::Htpasswd.new('/etc/nginx/htpasswd')

    Chef::Log.debug "Adding user '#{node.issue.user}' to #{node.issue.pass}\n"
    @htpasswd.set_passwd( 'Elasticsearch', node.issue.user, node.issue.pass )

    @htpasswd.flush
  end
end

# Ensure proper permissions and existence of the passwords file
file '/etc/nginx/htpasswd' do
  owner 'www-data' and group 'www-data' and mode 0755
  action :touch
end

directory '/etc/nginx/ssl' do
  owner 'www-data'
  group  'www-data'
  mode '0540'
end

file '/etc/nginx/ssl/es.issue.by.pem' do
  owner 'www-data'
  group  'www-data'
  mode '0440'
  content node.issue.ssl_key
end

file '/etc/nginx/ssl/es.issue.by.crt' do
  owner 'www-data'
  group  'www-data'
  mode '0440'
  content node.issue.ssl_cert
end
