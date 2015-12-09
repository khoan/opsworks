include_recipe 'apt'

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
  path_data(
    package: '/data/db/elasticsearch',
    tarball: '/data/db/elasticsearch'
  )

  path_logs(
    package: '/data/log/elasticsearch',
    tarball: '/data/log/elasticsearch'
  )

  configuration(
    'cluster.name' => 'issue-elasticsearch',

    'http.cors.enabled' => true,
    'http.cors.allow-origin' => '/.*/',
    'http.cors.allow-headers' => 'X-Requested-With, Content-Type, Content-Length, Authorization',
    'http.cors.allow-credentials' => true,

    'discover.type' => 'ec2',
    'cloud.aws.access_key' => node.issue.aws_secret_key,
    'cloud.aws.secret_key' => node.issue.aws_secret_key,
    'cloud.ec2.security_group' => 'elasticsearch',
    #'cloud.ec2.groups' => 'elasticsearch',

    'marvel.agent.exporter.es.hosts' => node.issue.elasticsearch_monitoring_cluster,
    'marvel.agent.exporter.es.ssl.hostname_verification' => false
  )
end

elasticsearch_service 'elasticsearch' do
  service_actions([:enable, :start])
end
