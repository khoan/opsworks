name         'idata'
version      '0.3.0'
#issues_url   'https://github.com/khoan/opsworks/issues'
#source_url   'https://github.com/khoan/opsworks'
supports     'ubuntu', '= 14.04'


provides     'elasticsearch'
provides     'monitor'

depends      'apt'
depends      'elasticsearch'
depends      'nginx'
depends      'java'


license          'MIT'
description      'Elasticsearch with access control and monitoring'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

maintainer       'khoa'
maintainer_email 'khoa@issue.by'
