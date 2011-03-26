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
    key :rawpath, String, :required => true
    timestamps!
  end

  class Dirlist
    include MongoMapper::Document
    key :pathid, String, :required => true
    key :ownid, String, :required => true
    key :file, String, :required => true
    key :fullpath, String, :required => true
    key :rawpath, String, :required => true
  end

  def self.crawl(path=$const.CRAWL_PATH)
    self.savedir("/", "/", "/") if path == $const.CRAWL_PATH

    Dir.open(path).each do |file|
      unless file =~ /^\./
        fullpath = path + file
        rel_path = path.gsub($const.CRAWL_PATH, "/")
        rel_fullpath = fullpath.gsub($const.CRAWL_PATH, "/")
        if File.file?(fullpath)
          self.savefile(rel_path, file, rel_fullpath, File.mtime(fullpath))
        else
          self.savedir(rel_path, file, rel_fullpath + "/")
          print "dir:" + fullpath + "\n"
          self.crawl(fullpath + "/")
        end
      end
    end
  end

  def self.savefile(path, file, fullpath, created_at)
    rawpath = fullpath
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
      filelist.rawpath = rawpath
      filelist.created_at = created_at
      print "save start\n"
      filelist.save!
      print "save complete\n"
    rescue Exception => e
      print "Exception:" + fullpath + "\n"
      p e.message
    end
  end

  def self.savedir(path, file, fullpath)
    rawpath = fullpath
    file = NKF.nkf('-w', file)
    fullpath = NKF.nkf('-w', fullpath)
    pathid = Digest::MD5.hexdigest(path)
    ownid = Digest::MD5.hexdigest(fullpath)    

    return if pathid == ownid # "/" not inserted

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
      dirlist.rawpath = rawpath
      print "save start\n"
      dirlist.save!
      print "save complete\n"
    rescue Exception => e
      print "Exception:" + fullpath + "\n"
      p e.message
    end
  end
  
  def self.delete(path=$const.CRAWL_PATH)
    begin
      print "delete start\n"
      Filelist.delete_all
      Dirlist.delete_all
      print "delete complete\n"
    rescue Exception => e
      print "Exception:delete\n"
      p e.message
    end
  end

  def self.delete_if_not_exist(path=$const.CRAWL_PATH)
    Filelist.all.each do |f|
      unless File.exist?(path + f.rawpath)
        begin
          print "destroy start:#{f.fullpath}\n"
          f.destroy
          print "destroy end\n"
        rescue Exception => e
          print "Exception:delete_if_not_exist\n"
          p e.message
        end
      end
    end

    Dirlist.all.each do |d|
      unless File.exist?(path + d.rawpath)
        begin
          print "destroy start:#{d.fullpath}\n"
          d.destroy
          print "destroy end\n"
        rescue Exception => e
          print "Exception:delete_if_not_exist\n"
          p e.message
        end
      end
    end
  end
end
