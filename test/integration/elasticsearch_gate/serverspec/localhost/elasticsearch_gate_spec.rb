require 'serverspec'

set :backend, :exec

describe 'Elasticsearch gate' do
  # has valid nginx config
  describe command('nginx -t') do
    its(:exit_status) { should eq 0 }
  end

  describe port(443) do
    it { should be_listening }
  end

  it 'authenticates via HTTP Basic'
  it 'serves self signed SSL cert'

  it 'proxies elasticsearch cluster'
  it 'proxies CORS headers to-and-fro elasticsearch cluster'

  it 'proxies monitoring cluster'
end
