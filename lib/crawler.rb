# -*- coding: utf-8 -*-
require 'net/http'
require 'rubygems'
require 'mongo'
require 'mongo_mapper'
require 'const'
require 'md5'

$const = Const.init

module Model
  def self.connect
    MongoMapper.connection = Mongo::Connection.new($const.HOST)
    MongoMapper.database = $const.DB
  end

  class Filelist
    include MongoMapper::Document
    key :pathid, String, :required => true
    key :ownid, String, :required => true
    key :file, String, :required => true
    key :fullpath, String, :required => true
    timestamps!
  end

  class Dirlist
    include MongoMapper::Document
    key :pathid, String, :required => true
    key :ownid, String, :required => true
    key :file, String, :required => true
    key :fullpath, String, :required => true
  end

  def self.crawl(path=$const.CRAWL_PATH)
    self.savedir($const.CRAWL_PATH, $const.CRAWL_PATH) if path == $const.CRAWL_PATH

    Dir.open(path).each do |file|
      unless file =~ /^\./
        fullpath = path + file
        if File.file?(fullpath)
          self.savefile(path, file, fullpath)
        else
          self.savedir(path, fullpath + "/")
          print "dir:" + fullpath + "\n"
          self.crawl(fullpath + "/")
        end
      end
    end
  end

  def self.savefile(path, file, fullpath)
    created_at = File.mtime(fullpath)
    path = NKF.nkf('-w', path)
    fullpath = NKF.nkf('-w', fullpath)
    file = NKF.nkf('-w', file)
    pathid = Digest::MD5.hexdigest(path)
    ownid = Digest::MD5.hexdigest(fullpath)
    
    filelist = Filelist.find_by_ownid(ownid)
    if filelist
      print "update:" + NKF.guess(fullpath).to_s + ":" + fullpath + "\n"
    else
      print "insert:" + NKF.guess(fullpath).to_s + ":" + fullpath + "\n"
      filelist = Filelist.new
    end
    
    begin
      filelist.pathid = pathid
      filelist.ownid = ownid
      filelist.fullpath = fullpath
      filelist.file = file
      filelist.created_at = created_at
      print "save start\n"
      filelist.save!
      print "save complete\n"
    rescue Exception => e
      print "Exception:" + fullpath + "\n"
      p e.message
    end
  end

  def self.savedir(path, fullpath)
    file = NKF.nkf('-w', File.basename(fullpath))
    fullpath = NKF.nkf('-w', fullpath)
    pathid = Digest::MD5.hexdigest(path)
    ownid = Digest::MD5.hexdigest(fullpath)

    dirlist = Dirlist.find_by_ownid(ownid)
    if dirlist
      print "update:" + NKF.guess(fullpath).to_s + ":" + fullpath + "\n"
    else
      print "insert:" + NKF.guess(fullpath).to_s + ":" + fullpath + "\n"
      dirlist = Dirlist.new
    end
    
    begin
      dirlist.pathid = pathid
      dirlist.ownid = ownid
      dirlist.file = file
      dirlist.fullpath = fullpath
      print "save start\n"
      dirlist.save!
      print "save complete\n"
    rescue Exception => e
      print "Exception:" + fullpath + "\n"
      p e.message
    end
  end
  
  def self.delete_by_path(path=$const.CRAWL_PATH)
    begin
      print "delete start\n"
      Filelist.delete_all
      Dirlist.delete_all
      print "delete complete\n"
    rescue Exception => e
      print "Exception:delete_by_path\n"
      p e.message
    end
  end
end
