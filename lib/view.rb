# -*- coding: utf-8 -*-
module View
  def self.init
    index
    tree
    update
    search
    rss
  end

  def self.index
    get '/' do
      erb :index
    end
  end

  def self.tree
    get '/tree' do
      erb :tree, :locals => {:path => params[:path]}
    end
  end

  def self.search
    get '/search' do
      connect
      erb :search, :locals => {:keyword => params[:keyword]}
    end
  end

  def self.update
    get '/update/:span' do
      connect
      erb :update, :locals => {:span => params[:span]}
    end
  end

  def self.rss
    get '/rss.xml' do
      connect
      builder do |xml|
        xml.instruct! :xml, :version => '1.0'
        xml.rss :version => "2.0" do
          xml.channel do
            xml.title "みんなのTOMOYO"
            xml.description "正しく使いましょう"
            xml.link "http://tomoyo.uraz.org/"
            
            Model.find_limit($const.DEFAULT_PAGES).each do |post|
              xml.item do
                xml.title post[:created_at]
                text = ""
                post[:text].each_line do |line|
                  text += line + "<br>"
                end
                xml.description text
              end
            end
          end
        end
      end
    end
  end

end
