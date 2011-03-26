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
    attr_reader :DEFAULT_SPAN

    def initialize
      @HOST = "localhost"
      @DB = "explorer"
      @COLLECTION = "filelist"
      @CRAWL_PATH = "/Users/deepneko/study/ruby/explorer-2/spec/test/" # end is '/'
      @CRAWL_PATHID = Digest::MD5.hexdigest("/")
      @IGNORE_PATH = ["/Users/deepneko/study/ruby/explorer-2/spec/test/dab/"]
      @DEFAULT_SPAN = 7
    end
  end
end
