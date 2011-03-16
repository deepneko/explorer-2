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
  end

  it "save complete" do
    file = "["
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "]"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "("
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = ")"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = ","
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "!"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "?"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "<"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = ">"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "#"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "+"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  it "save complete" do
    file = "-"
    fullpath = @const.CRAWL_PATH + file
    `touch "#{fullpath}"`
    Model.save(@const.CRAWL_PATH, file, fullpath)
  end

  after do 
    `rm -rf #{@const.CRAWL_PATH + "*"}`
    Model.delete_by_path(@const.CRAWL_PATH)
  end
end
