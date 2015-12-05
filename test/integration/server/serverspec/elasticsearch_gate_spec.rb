require 'serverspec'

set :backend, :exec

describe 'Elasticsearch gate' do
  it 'listens to port 443'
  it 'authenticates via HTTP Basic'
  it 'proxies elasticsearch cluster'
  it 'proxies CORS headers to-and-fro elasticsearch cluster'
end
