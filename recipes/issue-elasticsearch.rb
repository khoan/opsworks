#include_recipe 'apt'

include_recipe 'java'

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch 1.7'

elasticsearch_plugin 'marvel' do
  url 'elasticsearch/marvel/1.3.1'
end

elasticsearch_plugin 'elasticsearch-cloud-aws' do
  url 'elasticsearch/elasticsearch-cloud-aws/2.7.1'
end

elasticsearch_configure 'elasticsearch' do
  configuration(
    'cluster.name' => 'issue-elasticsearch',

    'path.data' => '/data/db/elasticsearch',
    'path.logs' => '/data/log/elasticsearch',

    'http.cors.enabled' => true,
    'http.cors.allow-origin' => '/.*/',
    'http.cors.allow-headers' => 'X-Requested-With, Content-Type, Content-Length, Authorization',
    'http.cors.allow-credentials' => true,

    'discover.type' => 'ec2',
    'cloud.aws.access_key' => '12345',
    'cloud.aws.secret_key' => '12345',
    'cloud.ec2.security_group' => 'elasticsearch',

    'marvel.agent.exporter.es.hosts' => [
      'https://bam:bam@es-mon:9200'
    ],
    'marvel.agent.exporter.es.ssl.hostname_verification' => false
  )
end

elasticsearch_service 'elasticsearch' do
  action :start
end

# FIXME access control with nginx
#
# install nginx
# configure nginx
#   install self signed SSL certificate
#   setup reverse proxy to elasticsearch
#
package 'nginx'

user node[:nginx][:user] do
  comment "Nginx User"
  system true
  shell "/bin/false"
  action :create
end
group node[:nginx][:user] do
  members node[:nginx][:user]
  action :create
end

# Create service for Nginx (/sbin/service nginx)
#
service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

# Create log directory
#
directory node[:nginx][:log_dir] do
  mode 0755
  owner 'root'
  action :create
  recursive true
end

# Create Nginx main configuration file
#
template "nginx.conf.erb" do
  path "#{node[:nginx][:dir]}/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  mode 0644
  notifies :restart, 'service[nginx]', :immediately
end

# start nginx
