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
    it 'authenticates via HTTP Basic' do
      hash = JSON.parse(subject.stdout)
      expect(hash['status']).to eq 200
    end
  end

  # serves self signed SSL cert
  describe command('curl https://bam:bam@localhost') do
    its(:exit_status) { should eq 60 }
  end
  
  # proxies elasticsearch cluster
  #describe command('curl -k https://bam:bam@localhost') do
  #  its(:stdout) { should match /502 Bad Gateway/ }
  #end

  # proxies CORS headers to-and-fro elasticsearch cluster
  describe command('curl -H "Origin: http://bam.com" -H "User-Agent: Mozilla" -ik https://bam:bam@localhost') do
    its(:stdout) { should match %r{Access-Control-Allow-Origin: http://bam.com} }
  end

  describe command('curl -k https://bam:bam@localhost/monitor') do
    it 'proxies monitoring cluster' do
      hash = JSON.parse(subject.stdout)
      expect(hash['status']).to eq 404
    end
    #its(:stdout) { should match %r{something here} }
  end
end
