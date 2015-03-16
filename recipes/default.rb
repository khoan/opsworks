include_recipe 'java'
include_recipe 'elasticsearch'
include_recipe 'elasticsearch::proxy'
include_recipe 'elasticsearch::aws'
include_recipe 'elasticsearch::plugins'

file node.elasticsearch[:nginx][:ssl][:key_file] do
  owner 'root'
  group 'root'
  mode '0660'
  content node.elasticsearch[:nginx][:ssl][:key]
end

file node.elasticsearch[:nginx][:ssl][:cert_file] do
  owner 'root'
  group 'root'
  mode '0660'
  content node.elasticsearch[:nginx][:ssl][:cert]
end
