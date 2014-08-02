node.default[:elasticsearch][:custom_config] =  {
  'node.region' => node[:opsworks][:instance][:availability_zone]
}
