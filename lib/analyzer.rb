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

  class Download
    include MongoMapper::Document
    key :ownid, String, :required => true
    key :count, Integer, :required => true
  end

  def self.analyze_all_xferlog(path=$const.XFERLOG_PATH)
    log = `cat #{path} | nkf -w`
    log.each do |l|
      if l =~ /(\/usr\/home\/BACKUP\/kotachu)(.*)( b _ o r )(.*)( ftp 0 \* c)/
        print $2 + "\n"
        savelog("/" + $2)
      end
    end
  end

  def self.analyze_xferlog(path=$const.XFERLOG_PATH)
    log = `grep "#{Time.now.strftime("%a %b %d")}" #{path} | nkf -w`
    log.each do |l|
      if l =~ /(\/usr\/home\/BACKUP\/kotachu)(.*)( b _ o r )(.*)( ftp 0 \* c)/
        print $2 + "\n"
        savelog("/" + $2)
      end
    end
  end

  def self.analyze_smblog(path=$const.SMBLOG_PATH)
    log = `grep -A 1 "#{Time.now.strftime("%Y/%m/%d")}" #{path} | grep "opened file" | nkf -w`

    log.each do |l|
      if l =~ /(nobody opened file )(.*)( read=Yes)/
        print "/" + $2 + "\n"
        savelog("/" + $2)
      end
    end
  end

  def self.savelog(path)
    path = NKF.nkf('-w', path)
    ownid = Digest::MD5.hexdigest(path)
    
    filelist = Filelist.find_by_ownid(ownid)
    p ownid
    p filelist

    f = Filelist.find_by_fullpath("/Soft/Cisco/SDM/SDM2.4.1Japanese-DL/SDM-V241-ja/sdm.tar")
    p f.ownid
    p f.file
    return unless filelist

    download = Download.find_by_ownid(ownid)
    if download
      print "update:" + filelist.fullpath + ":" + filelist.fullpath + "\n"
    else
      print "insert:" + filelist.fullpath + ":" + filelist.fullpath + "\n"
      download = Download.new
      download.count = 0
    end
    
    begin
      download.ownid = ownid
      download.count = download.count + 1
      print "save start\n"
      download.save!
      print "save complete\n"
    rescue Exception => e
      print "Exception:" + filelist.fullpath + "\n"
      p e.message
    end
  end
  
  def self.delete
    begin
      print "delete start\n"
      Download.delete_all
      print "delete complete\n"
    rescue Exception => e
      print "Exception:delete\n"
      p e.message
    end
  end
end
