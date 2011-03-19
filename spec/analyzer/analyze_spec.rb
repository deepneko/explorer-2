# -*- coding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'analyzer'
require 'const'

describe Model do
  before do
    @const = Const.init
    Model.connect
  end

  it "delete complete" do
    Model.delete
  end

  it "analyzing all xferlog complete" do
    Model.analyze_all_xferlog
  end

  it "analyzing xferlog complete" do
    #Model.analyze_xferlog
  end

  it "analyzing smblog complete" do
    #Model.analyze_smblog
  end

  after do 
  end
end
