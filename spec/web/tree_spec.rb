# -*- coding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))

require 'explorer'
require 'spec/spec_helper'

describe 'GET /tree' do
  before do
    @const = Const.init
    testdir = ["[", "]", "(", ")", ",", "!", "!", "?",
              "<", ">", "#", "+", "-",
              "魔法少女まどか☆マギカ 第09話 「そんなの、あたしが許さない」（1280x720 x264）"]
    testdir.each do |dir|
      `mkdir "#{@const.CRAWL_PATH + dir}"`
      `touch "#{@const.CRAWL_PATH + dir + "/" + "a"}"`
    end
  end

  it "[ status should be 200" do
    get '/tree?path=['
    last_response.ok?.should be_true
  end

  it "] status should be 200" do
    get '/tree?path=]'
    last_response.ok?.should be_true
  end

  it "( status should be 200" do
    get '/tree?path=('
    last_response.ok?.should be_true
  end

  it ") status should be 200" do
    get '/tree?path=)'
    last_response.ok?.should be_true
  end

  it ", status should be 200" do
    get '/tree?path=,'
    last_response.ok?.should be_true
  end

  it "! status should be 200" do
    get '/tree?path=!'
    last_response.ok?.should be_true
  end

  it "? status should be 200" do
    get '/tree?path=?'
    last_response.ok?.should be_true
  end

  it "< status should be 200" do
    get '/tree?path=<'
    last_response.ok?.should be_true
  end

  it "> status should be 200" do
    get '/tree?path=>'
    last_response.ok?.should be_true
  end

  it "# status should be 200" do
    get '/tree?path=#'
    last_response.ok?.should be_true
  end

  it "+ status should be 200" do
    get '/tree?path=+'
    last_response.ok?.should be_true
  end

  it "- status should be 200" do
    get '/tree?path=-'
    last_response.ok?.should be_true
  end

  after do 
    `rm -rf "#{@const.CRAWL_PATH + '*'}"`
  end
end
