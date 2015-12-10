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

  describe command('curl -k https://bam:bam@localhost') do
    its(:stdout) { should match /502 Bad Gateway/ }

    #it 'authenticates via HTTP Basic' do
    #  hash = JSON.parse(subject.stdout)
    #  expect(hash['status']).to eq 200
    #end
  end

  # serves self signed SSL cert
  describe command('curl https://bam:bam@localhost') do
    its(:exit_status) { should eq 60 }
  end
  
  it 'proxies elasticsearch cluster'
  it 'proxies CORS headers to-and-fro elasticsearch cluster'

  it 'proxies monitoring cluster'
end
