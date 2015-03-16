file node.elasticsearch[:nginx][:ssl][:key_file] do
  owner node.elasticsearch[:nginx][:user]
  group  node.elasticsearch[:nginx][:user]
  mode '0440'
  content node.elasticsearch[:nginx][:ssl][:key]
end

file node.elasticsearch[:nginx][:ssl][:cert_file] do
  owner node.elasticsearch[:nginx][:user]
  group  node.elasticsearch[:nginx][:user]
  mode '0440'
  content node.elasticsearch[:nginx][:ssl][:cert]
end

include_recipe 'java'
include_recipe 'elasticsearch'
include_recipe 'elasticsearch::aws'
include_recipe 'elasticsearch::plugins'
include_recipe 'elasticsearch::proxy'
