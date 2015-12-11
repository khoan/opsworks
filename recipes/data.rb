# wait_for /data
bash 'wait until /data is mounted' do
  code <<-CODE
    while ( ! grep -qs /data /proc/mounts )
    do
      sleep 1
    done
  CODE
end

elasticsearch_user 'elasticsearch'

%w[
  /data

  /data/log
  /data/log/elasticsearch

  /data/db
  /data/db/elasticsearch
].each do |name|
  directory name do
    owner 'elasticsearch'
    group 'elasticsearch'
    mode 0755
  end
end
