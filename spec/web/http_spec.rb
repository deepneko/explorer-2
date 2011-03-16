# -*- coding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))

require 'explorer'
require 'spec/spec_helper'

describe 'GET /' do
  before do
    get '/'
  end

  it "status code should be 200" do
    p last_response.body
    last_response.ok?.should be_true
  end

  after do 
  end
end

describe 'GET /update/7' do
  before do
    get '/update/7'
  end

  it "status code should be 200" do
    last_response.ok?.should be_true
  end

  after do 
  end
end

describe 'GET /update/30' do
  before do
    get '/update/30'
  end

  it "status code should be 200" do
    last_response.ok?.should be_true
  end

  after do 
  end
end

describe 'GET /update/365' do
  before do
    get '/update/365'
  end

  it "status code should be 200" do
    last_response.ok?.should be_true
  end

  after do 
  end
end
