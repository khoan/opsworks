# development

1. kitchen list
1. kitchen create
1. kitchen converge
1. kitchen verify

## dependencies

- berkshelf 3
- chef 12
- vagrant 1.6.3

## troubleshoot

- Vagrant
  default: Warning: Connection timeout. Retrying...
  http://stackoverflow.com/questions/22575261/vagrant-stuck-connection-timeout-retrying

- download Java JDK for vagrant/opsworks
  this may change from time to time
  curl -O -L --header 'Cookie: testSessionCookie=Enabled; s_cc=true; oraclelicense=accept-securebackup-cookie; JSESSIONID=1FspVGvKsnfLkQvHCCLT5vYF4ThPRYx0mrd2B6g1v7Lj1mt6rpmh!681530759!119126025; atgPlatoStop=1; AKSB=s=1426465900975&r=http%3A//www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html; s_nr=1424062154163; s_cc=true; gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk7-downloads-1880260.html' 'http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-x64.tar.gz'

# opsworks

## Packaging Cookbook Dependencies Locally

http://docs.aws.amazon.com/opsworks/latest/userguide/best-practices-packaging-cookbooks-locally.html

1. berks package
1. aws s3 cp cookbook* s3://bucket

## SSL generator

- http://www.selfsignedcertificate.com
- http://docs.aws.amazon.com/opsworks/latest/userguide/workingsecurity-ssl.html
