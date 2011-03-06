module Const
  def self.init
    return Const.new
  end

  class Const
    attr_reader :HOST
    attr_reader :DB
    attr_reader :COLLECTION
    attr_reader :CRAWL_PATH

    def initialize
      @HOST = "localhost"
      @DB = "explorer"
      @COLLECTION = "filelist"
      @CRAWL_PATH = "/Users/deepneko/study/ruby/explorer-2/test/" # end is '/'
    end
  end
end
