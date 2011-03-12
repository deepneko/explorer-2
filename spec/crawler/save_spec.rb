# -*- coding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'crawler'
require 'const'

describe Crawler do
  before do
    @const = Const.init
    @model = Crawler::Model.new
    @model.connect
  end

  it "save complete" do
    file = "["
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "]"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "("
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = ")"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = ","
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "!"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "?"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "<"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = ">"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "#"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "+"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "-"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    @model.save(@const.CRAWL_PATH, file, fullpath)
  end

  #after do 
  #  `rm -rf #{@const.CRAWL_PATH + "*"}`
  #end
end
