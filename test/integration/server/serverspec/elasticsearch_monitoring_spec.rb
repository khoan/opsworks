require 'serverspec'

set :backend, :exec

describe 'Elasticsearch monitoring' do
  it 'is listening on port 9200'
  it 'is listening on port 9300'
  it 'is run as a service'

  it 'is 1.7.3 version'

  describe 'Plugin' do
    it 'has aws cloud 2.7.1 plugin'
    it 'has marvel 1.3.1 plugin'
  end

  describe 'Configuration' do
    it 'accepts stats data from elasticsearch cluster'
    it 'clusters within elasticsearch group'
    it 'supports CORS requests'

    it 'stores data at /data/db/elasticsearch'
    it 'stores log at /data/log/elasticsearch'

    # TODO
    # tuning JVM
  end
end

