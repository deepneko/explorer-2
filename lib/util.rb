module Util
  class FolderTree
    attr_reader :tree
    attr_reader :output

    def initialize
      @tree = []
      @output = ""
    end

    def createtree
      _createtree(@tree.pop)
      @output
    end

    def _createtree(folder, depth=0)
      next_folder = nil
      next_folder = @tree.pop if @tree.size != 0

      folder.dirlist.each do |dir|
        p "#{'  '*depth}#{dir.file}"
        @output += ("&nbsp;&nbsp;&nbsp;&nbsp;"*depth) + "<img src=/img/dir.gif><a href=/tree/#{dir.ownid}>" + dir.file + "</a><br>"
        _createtree(next_folder, depth+1) if next_folder and next_folder.pathid == dir.ownid
      end

      folder.filelist.each do |file|
        p "#{'  '*depth}#{file.file}"
        @output += ("&nbsp;&nbsp;&nbsp;&nbsp;"*depth) + "<img src=/img/text.gif>" + file.file + "<br>"
      end
    end
  end

  class Folder
    attr_reader :filelist
    attr_reader :dirlist
    attr_reader :pathid

    def initialize(dirlist, filelist, pathid)
      @dirlist = dirlist
      @filelist = filelist
      @pathid = pathid
    end
  end
end
