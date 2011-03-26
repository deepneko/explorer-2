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

  it "delete complete" do
    Model.delete_if_not_exist
  end

  it "crawl complete" do
    Model.crawl
  end

  after do 
  end
end
