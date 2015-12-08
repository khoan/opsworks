require 'spec_helper'
require 'json'

describe 'Elasticsearch' do
  describe port(9200) do
    it { should be_listening }
  end

  describe port(9300) do
    it { should be_listening }
  end

  describe service('elasticsearch') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('curl localhost:9200') do
    it 'is version 1.7.3' do
      hash = JSON.parse(subject.stdout)
      expect(hash['version']['number']).to eq '1.7.3'
    end
  end

  describe command('curl localhost:9200/_nodes') do
    let(:plugins) do
      hash = JSON.parse(subject.stdout)
      hash['nodes'].values.first['plugins']
    end

    it 'has aws cloud 2.7.1 plugin' do
      expect(plugins).to satisfy {|plugins|
        plugins.any? do |plugin|
          plugin['name'] == 'cloud-aws' && plugin['version'] == '2.7.1'
        end
      }
    end

    it 'has marvel 1.3.1 plugin' do
      expect(plugins).to satisfy {|plugins|
        plugins.any? do |plugin|
          plugin['name'] == 'marvel' && plugin['version'] == '1.3.1'
        end
      }
    end
  end

  describe 'Configuration' do
    it 'exports node stats to monitoring cluster'
    it 'exports node stats to monitoring cluster via https'
    it 'clusters within elasticsearch group'
    it 'supports CORS requests'

    it 'stores data at /data/db/elasticsearch'
    it 'stores log at /data/log/elasticsearch'

    # TODO
    # tuning JVM
  end
end
