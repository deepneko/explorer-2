module Model
  def self.connect
    MongoMapper.connection = Mongo::Connection.new($const.HOST)
    MongoMapper.database = $const.DB
  end

  def self.find_by_fullpath(keyword)
    result = []
    keywords = keyword.split
    result = Filelist.all(:fullpath => /#{keywords.shift}/i)

    if keywords.size > 0
      keywords.each do |k|
        result &= Filelist.all(:fullpath => /#{k}/i)
      end
    end

    result.map{|p| p.fullpath}
  end

  def self.open_path(path=$const.CRAWL_PATH)
    Util::FolderTree.new(path).tree
  end

  def self.all
    Filelist.sort(:created_at.desc).all
  end

  def self.recent_update(span)
    since = (Time.now - 24*60*60*(span.to_i)).utc
    Filelist.where(:created_at.gt => since).sort(:created_at.desc).all
  end

  class Filelist
    include MongoMapper::Document
    key :path, String, :required => true
    key :file, String, :required => true
    key :fullpath, String, :required => true
    timestamps!
  end

  class Download
    include MongoMapper::Document
    key :file_id, ObjectId, :required => true
    key :download, Integer, :required => true
    key :user, Array, :required => true
  end
end
