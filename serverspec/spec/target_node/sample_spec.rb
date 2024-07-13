require 'spec_helper'

RBENV_PATH = '/home/ec2-user/.rbenv/bin:/home/ec2-user/.rbenv/shims:$PATH'
NVM_SOURCE = 'source /home/ec2-user/.nvm/nvm.sh'

# gitがインストールされているか確認する
describe package('git') do
  it { should be_installed }
end

# 他の複数のパッケージがインストールされているかまとめて確認する
%w{
  make gcc-c++ patch curl openssl-devel libcurl-devel libyaml-devel libffi-devel libicu-devel libxml2 libxslt 
  libxml2-devel libxslt-devel zlib-devel readline-devel ImageMagick ImageMagick-devel mysql-community-devel nginx
}.each do |pkg|  
  describe package(pkg) do
    it { should be_installed }
  end
end

# Node のバージョン確認
describe command("#{NVM_SOURCE} && node -v") do
  its(:stdout) { should match /v17\.9\.1/ }
end

# Yarn のバージョン確認
describe command("#{NVM_SOURCE} && yarn -v") do
  its(:stdout) { should match /1\.22\.19/ }
end

# Ruby のバージョン確認
describe command("bash -lc 'ruby -v'") do
  let(:path) { "#{RBENV_PATH}" }
  its(:stdout) { should match /ruby 3\.2\.3 \(2024-01-18 revision 52bb2ac0a6\) \[x86_64-linux\]/ }
end

# Rails のバージョン確認
describe command("bash -lc 'rails -v'") do
  let(:path) { "#{RBENV_PATH}" }
  its(:stdout) { should match /Rails 7\.1\.3\.2/ } 
end

# Bundler のバージョン確認 
describe command('gem list bundler --all') do
  let(:path) { "#{RBENV_PATH}" }
  its(:stdout) { should match /bundler\s*\(default:\s*2\.4\.19,\s*2\.3\.14\)/ }
end

# MySQL のバージョン確認
describe command('mysql --version') do
  its(:stdout) { should match /mysql\s+Ver\s+8\.4\.1/ }
end

# Puma サーバーのワーカープロセスが少なくとも 1 つは起動していることを確認
describe command('ps aux | grep "puma: cluster worker" | wc -l') do  # wc -l はプロセスの数を数える
  its(:stdout) { should match /[1-9]/ } 
end

# Nginx の起動確認
describe service('nginx') do
  it { should be_running }
  it { should be_enabled }
end

# Nginx の設定ファイルの確認
describe file('/etc/nginx/conf.d/rails.conf') do
  it { should be_file }
end

# 80 番のポート
describe port(80) do
  it { should be_listening }
end

# ALB の接続確認
describe command("curl http://#{ENV['ALB_DNS_NAME']}/ -o /dev/null -w '%{http_code}\n' -s") do
  its(:stdout) { should match /^200$/ }
end

# MySQL の接続確認
describe 'RDS MySQL Connection' do
  host = ENV['DB_HOST']
  user = ENV['DB_USERNAME']
  password = ENV['DB_PASSWORD']

  describe command("mysql -h #{host} -u #{user} -p#{password} -e 'SHOW DATABASES;'") do
    its(:exit_status) { should eq 0 }
  end
end

# S3 の接続確認
describe command("aws s3 ls s3://#{ENV['S3_BUCKET_NAME']}") do  # 指定した S3 バケットの内容をリストする
  its(:exit_status) { should eq 0 }
end