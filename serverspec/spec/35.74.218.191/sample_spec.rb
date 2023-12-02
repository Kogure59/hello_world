require 'spec_helper'

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