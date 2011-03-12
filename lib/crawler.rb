# -*- coding: utf-8 -*-
require 'net/http'
require 'rubygems'
require 'mongo'
require 'mongo_mapper'
require 'const'

$const = Const.init

module Crawler

class Model
  def connect
    MongoMapper.connection = Mongo::Connection.new($const.HOST)
    MongoMapper.database = $const.DB
  end

  class Filelist
    include MongoMapper::Document
    key :path, String, :required => true
    key :file, String, :required => true
    key :fullpath, String, :required => true
    timestamps!
  end

  def crawl(path=$const.CRAWL_PATH)
    Dir.open(path).each do |file|
      unless file =~ /^\./
        fullpath = path + file
        if File.file?(fullpath)
          save(path, file, fullpath)
        else
          print "dir:" + fullpath + "\n"
          self.crawl(fullpath + "/")
        end
      end
    end
  end

  def save(path, file, fullpath)
    filelist = Filelist.find_by_fullpath(fullpath)
    if filelist
      print "update:" + NKF.guess(fullpath).to_s + ":" + fullpath + "\n"
    else
      print "insert:" + NKF.guess(fullpath).to_s + ":" + fullpath + "\n"
      filelist = Filelist.new
    end

    begin
      filelist.path = NKF.nkf('-w', path)
      filelist.file = NKF.nkf('-w', file)
      filelist.fullpath = NKF.nkf('-w', fullpath)
      filelist.created_at = File.mtime(fullpath)
      print "save start\n"
      filelist.save!
      print "save complete\n"
    rescue Exception => e
      print "Exception:" + fullpath + "\n"
      p e.message
    end
  end

  def self.delete(path=$const.CRAWL_PATH)
    filelist = Filelist.all
    filelist.each do |f|
      unless File.exist?(f.fullpath)
        p f.fullpath
        Filelist.delete_all("path='#{f.fullpath}'")
      end
    end
  end
end

end
