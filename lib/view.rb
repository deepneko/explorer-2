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
      connect
      erb :index
    end
  end

  def self.tree
    get '/tree/:pathid' do
      connect
      erb :tree, :locals => {:pathid => params[:pathid]}
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
    get '/rss' do
      connect
      builder do |xml|
        xml.instruct! :xml, :version => 1.0
        xml.rss :version => "2.0" do
          xml.channel do
            xml.title "TOMOYO search"
            xml.link "http://tomoyo.uraz.org/"
            
            Model.recent_update(7).each do |u|
              xml.item do
                xml.title "TOMOYO recent update!!"
                xml.description = "[" + u[:created_at].strftime('%Y-%m-%d %H:%M:%S') + "] " + u[:file] + "<br>"
              end
            end
          end
        end
      end
    end
  end
end
