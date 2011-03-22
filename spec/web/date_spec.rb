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
      `mkdir "#{@const.CRAWL_PATH + dir + "/" + dir}"`

      test1 = @const.CRAWL_PATH + dir + "/6"
      `touch "#{test1}"`
      File.utime(File.atime(test1), File.mtime(test1)-6*60*60*24, test1)

      test2 = @const.CRAWL_PATH + dir + "/" + dir + "/8"
      `touch "#{test2}"`
      File.utime(File.atime(test2), File.mtime(test2)-8*60*60*24, test2)

      test1 = @const.CRAWL_PATH + dir + "/29"
      `touch "#{test1}"`
      File.utime(File.atime(test1), File.mtime(test1)-29*60*60*24, test1)

      test2 = @const.CRAWL_PATH + dir + "/" + dir + "/31"
      `touch "#{test2}"`
      File.utime(File.atime(test2), File.mtime(test2)-31*60*60*24, test2)

      test1 = @const.CRAWL_PATH + dir + "/364"
      `touch "#{test1}"`
      File.utime(File.atime(test1), File.mtime(test1)-364*60*60*24, test1)

      test2 = @const.CRAWL_PATH + dir + "/" + dir + "/366"
      `touch "#{test2}"`
      File.utime(File.atime(test2), File.mtime(test2)-366*60*60*24, test2)
    end
  end

  it "crawl complete" do
    Model.crawl
  end

  after do 
  end
end
