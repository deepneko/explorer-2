module Const
  def self.init
    return Const.new
  end

  class Const
    attr_reader :HOST
    attr_reader :DB
    attr_reader :COLLECTION
    attr_reader :CRAWL_PATH
    attr_reader :CRAWL_PATHID
    attr_reader :IGNORE_PATH
    attr_reader :XFERLOG_PATH
    attr_reader :SMBLOG_PATH

    def initialize
      @HOST = "localhost"
      @DB = "explorer"
      @COLLECTION = "filelist"
      @CRAWL_PATH = "/Users/deepneko/study/ruby/explorer-2/spec/test/" # end is '/'
      @CRAWL_PATHID = Digest::MD5.hexdigest("/")
      @IGNORE_PATH = ["/Users/deepneko/study/ruby/explorer-2/spec/test/dab/"]
      @XFERLOG_PATH = "/Users/deepneko/log/xferlog"
      @SMBLOG_PATH = "/Users/deepneko/log/log.*"
    end
  end
end
