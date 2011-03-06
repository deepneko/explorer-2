module Util
  class FolderTree
    attr_reader :tree

    def initialize(path)
      @path = path
      @tree = []
      @folderlist = [Folder.new($const.CRAWL_PATH)]
      dir = $const.CRAWL_PATH
      path.gsub($const.CRAWL_PATH, "").split("/").each do |p|
        dir += p
        if File.file? dir
          @file = dir
        else
          dir += "/"
          @folderlist << Folder.new(dir)
        end
      end

      # test
      test1 = @folderlist.map{|f| f.path}
      p "test1:#{test1.join(",")}"

      if @folderlist.size > 1
        createtree(@folderlist[0], 0, @folderlist[1])
      else
        createtree(@folderlist[0], 0)
      end
      p "------------------------------------------------------------------"
    end

    def createtree(folder, depth, next_folder=nil)
      depth += 1
      p "#{'  '*depth}depth:#{depth}"
      p "#{'  '*depth}next_folder:#{next_folder.path}" if next_folder
      folder.dirlists.each do |f|
        p "#{'  '*depth}#{f}"
        dir = "<a href=/tree?path=#{f}>" + File.basename(f) + "</a>"
        @tree << ("&nbsp;&nbsp;&nbsp;&nbsp;"*depth) + "<img src=/img/dir.gif>" + dir
        if next_folder && @folderlist.size > depth
          createtree(@folderlist[depth], depth, @folderlist[depth+1]) if f == next_folder.path
        end
      end

      folder.filelists.each do |f|
        p "#{'  '*depth}#{f}"
        if f == @path
          file = "<font color=red>" + File.basename(f) + "</font>"
          @tree << ("&nbsp;&nbsp;&nbsp;&nbsp;"*depth) + "<img src=/img/text.gif>" + file
        else
          @tree << ("&nbsp;&nbsp;&nbsp;&nbsp;"*depth) + "<img src=/img/text.gif>" + File.basename(f) 
        end
      end
    end
  end

  class Folder
    attr_reader :path
    attr_reader :filelists #absolute path
    attr_reader :dirlists #absolute path

    def initialize(path)
      @path = path
      @filelists = []
      @dirlists = []
      current(path)

      p "---------------"
      p @path
      p @filelists
      p @dirlists
      p "---------------"
    end

    def current(path)
      Dir.open(path).each do |f|
        absolute_path = path + f
        next if f =~ /^\./
        if File.file? absolute_path
          @filelists << absolute_path
        else
          @dirlists << absolute_path + "/"
        end
      end
    end
  end
end
