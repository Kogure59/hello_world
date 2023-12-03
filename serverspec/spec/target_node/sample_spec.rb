require 'spec_helper'

listen_port = 80

# gitがインストールされているか確認する
describe package('git') do
  it { should be_installed }
end

# 他の複数のパッケージがインストールされているかまとめて確認する
%w{make gcc-c++ patch curl openssl-devel libcurl-devel libyaml-devel libffi-devel libicu-devel libxml2 libxslt libxml2-devel libxslt-devel zlib-devel readline-devel ImageMagick ImageMagick-devel}.each do |pkg|  
  describe package(pkg) do
    it { should be_installed }
  end
end

# listen port で指定したポートを Listen しているか確認する
describe port(listen_port) do
  it { should be_listening }
end

# curl で HTTP アクセスして 200 OK が返ってくるか確認する
describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end
