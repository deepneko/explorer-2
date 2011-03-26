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

    result.map{|p| p}
  end

  # from db
  def self.open_tree(pathid=$const.CRAWL_PATHID, ownid=nil)
    foldertree = Util::FolderTree.new

    loop do
      dirlist = Dirlist.sort(:file).all(:pathid => pathid)
      filelist = Filelist.sort(:file).all(:pathid => pathid)
      foldertree.tree << Util::Folder.new(dirlist, filelist, pathid)

      dir = Dirlist.all(:ownid => pathid)[0]
      break unless dir

      pathid = dir.pathid
    end

    foldertree.createtree
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
end
