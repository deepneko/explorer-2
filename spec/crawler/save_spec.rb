# -*- coding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'crawler'
require 'const'

describe Model do
  before do
    @const = Const.init
    Model.connect

    testdir = ["bbb", "ccc", "dab", "a", "あはははは", "ぎゃー！", "ゴゴ午後午後", "aaa",
              "魔法少女まどか☆マギカ 第09話 「そんなの、あたしが許さない」（1280x720 x264）"]
    testdir.each do |dir|
      `mkdir "#{@const.CRAWL_PATH + dir}"`
      `touch "#{@const.CRAWL_PATH + dir + "/hohohoho"}"`
      `mkdir "#{@const.CRAWL_PATH + dir + "/" + dir}"`
      `touch "#{@const.CRAWL_PATH + dir + "/" + dir + "/きょきょきょ"}"`
    end
  end

  it "crawl complete" do
    Model.crawl
  end

  after do 
  end
end
