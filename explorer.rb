# -*- coding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("lib", File.dirname(__FILE__))

require 'net/http'
require 'rubygems'
require 'sinatra'
require 'erb'
require 'haml'
require 'builder'
require 'mongo'
require 'mongo_mapper'
require 'json/pure'
require 'uri'
require 'pp'

require 'view'
require 'model'
require 'util'
require 'const'

class String
  alias_method :to_xs, :original_xs if method_defined? :original_xs
end

$const = Const.init
View.init
set :sessions, true
set :root, File.dirname(__FILE__)
set :public, File.dirname(__FILE__) + '/public'
set :haml, {:format => :html5 }

helpers do
  def connect
    Model.connect
  end
end
