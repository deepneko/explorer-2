# -*- coding: utf-8 -*-
require 'net/http'
require 'rubygems'
require 'mongo'
require 'mongo_mapper'
require 'const'

$const = Const.init

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
    key :date, String, :required => true
  end

  def crawler(path=$const.CRAWL_PATH)
    Dir.open(path).each do |e|
      unless e =~ /^\./
        p = path + e
        begin
          if File.file?(p)
            filelist = Filelist.find_by_fullpath(p)
            if filelist
              print "update:" + NKF.guess(p).to_s + ":" + p + "\n"
              filelist.path = NKF.nkf('-w', path)
              filelist.file = NKF.nkf('-w', e)
              filelist.fullpath = NKF.nkf('-w', p)
              filelist.date = File.mtime(p).strftime('%Y-%m-%d %H:%M:%S')
              print "save start\n"
              filelist.save!
              print "save complete\n"
            else
              print "insert:" + NKF.guess(p).to_s + ":" + p + "\n"
              filelist = Filelist.new
              filelist.path = NKF.nkf('-w', path)
              filelist.file = NKF.nkf('-w', e)
              filelist.fullpath = NKF.nkf('-w', p)
              filelist.date = File.mtime(p).strftime('%Y-%m-%d %H:%M:%S')
              print "save start\n"
              filelist.save!
              print "save complete\n"
            end
          else
            print "dir:" + p + "\n"
            self.crawler(p + "/")
          end
        rescue Exception => e
          print "Exception:" + p + "\n"
          p e.message
        end
      end
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

model = Model.new
model.connect
model.crawler
