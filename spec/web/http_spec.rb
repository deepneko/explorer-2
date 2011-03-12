# -*- coding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))

require 'explorer'
require 'spec/spec_helper'

describe 'GET /' do
  before do
    get '/'
  end

  it "status code should be 200" do
    last_response.ok?.should be_true
  end

  after do 
  end
end
