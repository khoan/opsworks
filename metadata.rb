name         'issue-elastic'
version      '0.1.0'
#issues_url   'https://github.com/khoan/opsworks/issues'
#source_url   'https://github.com/khoan/opsworks'
supports     'ubuntu', '= 14.04'


provides     'issue-elastic'

depends      'java'
depends      'elasticsearch'


license          'MIT'
description      'Installs and configures elasticsearch'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

maintainer       'khoa'
maintainer_email 'khoa@issue.by'
