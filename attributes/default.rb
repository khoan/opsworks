# java 8
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['oracle']['accept_oracle_download_terms'] = true

# elasticsearch
default['elasticsearch']['version'] = '1.7.3'

# nginx
default[:nginx][:dir]     = "/etc/nginx"
default[:nginx][:log_dir] = "/var/log/nginx"
default[:nginx][:binary]  = "/usr/sbin/nginx"
default[:nginx][:root]    = "/var/www/nginx"

default[:nginx][:user]    = case node[:platform]
  when 'debian', 'ubuntu' then 'www-data'
  when 'redhat', 'centos', 'scientific', 'amazon', 'oracle', 'fedora' then 'nginx'
  else 'nginx'
end

default[:nginx][:keepalive]          = "on"
default[:nginx][:keepalive_timeout]  = 65
default[:nginx][:worker_processes]   = node[:cpu][:total] rescue 1
default[:nginx][:worker_connections] = 2048

default[:nginx][:allow_cluster_api] = true
default[:nginx][:port] = '443'

default[:nginx][:users][0][:username] = 'bam'
default[:nginx][:users][0][:password] = 'bam'
default[:nginx][:ssl][:key_file] = '/etc/ssl/es.issue.by.pem'
default[:nginx][:ssl][:cert_file] = '/etc/ssl/es.issue.by.crt'
default[:nginx][:ssl][:key] = '-----BEGIN RSA PRIVATE KEY-----'
default[:nginx][:ssl][:cert] = '-----BEGIN CERTIFICATE-----'
