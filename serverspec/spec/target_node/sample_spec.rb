require 'spec_helper'

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
describe command('node -v') do
  its(:stdout) { should match /v17\.9\.1/ }
end

# Yarn のバージョン確認
describe command('yarn -v') do
  its(:stdout) { should match /1\.22\.19/ }
end

# Ruby のバージョン確認
describe command('bash -lc "ruby -v"') do
  its(:stdout) { should match /ruby 3\.2\.3/ }
end

# Rails のバージョン確認
describe command('bash -lc "rails -v"') do
  its(:stdout) { should match /Rails 7\.1\.3\.2/ } 
end

# Bundler のバージョン確認
describe command('bash -lc "bundler -v"') do
  its(:stdout) { should match /Bundler version 2\.3\.14/ }
end

# MySQL のバージョン確認
describe command('mysql --version') do
  its(:stdout) { should match /mysql\s+Ver\s+8\.4\.1/ }
end

# Puma サーバーのマスタープロセスが正しく起動していることを確認
describe command('ps aux | grep "puma: cluster worker" | grep -v grep') do  # grep コマンド自身を除外
  its(:stdout) { should match /puma/ }
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

# ALB の接続確認
describe command("curl http://#{ENV['ALB_ENDPOINT']}/ -o /dev/null -w '%{http_code}\n' -s") do  # HTTPステータスコードのみを出力
  its(:stdout) { should match /^200$/ }  # 出力が 200 であること（正常な HTTP レスポンス）
end

# RDS のサーバー接続確認
describe 'MySQL Command' do
  command_string = "nc -zv #{ENV['RDS_ENDPOINT']} 3306"

  describe command(command_string) do
    its(:exit_status) { should eq 0 }  # コマンドの終了ステータスが 0 であること（正常に接続できたこと）
  end
end

# S3 の接続確認
describe command("aws s3 ls s3://#{ENV['S3_BUCKET_NAME']}") do  # 指定した S3 バケットの内容をリストする
  its(:exit_status) { should eq 0 }
end