require 'spec_helper'

# Rubyのバージョンが3.1.2か確認する
describe command('ruby -v') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /ruby 3\.1\.2/ }
end

# 複数のパッケージがインストールされているかまとめて確認する
%w{git make gcc-c++ patch curl openssl-devel libcurl-devel libyaml-devel libffi-devel libicu-devel libxml2 libxslt libxml2-devel libxslt-devel zlib-devel readline-devel ImageMagick ImageMagick-devel }.each do |pkg|  
  describe package(pkg) do
    it { should be_installed }
  end
end