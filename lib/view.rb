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
    get '/rss.xml' do
      connect
      builder do |xml|
        xml.instruct!
        xml.rss :version => "2.0" do
          xml.channel do
            xml.title "TOMOYO search"
            xml.link "http://tomoyo.uraz.org/"
            
            Model.recent_update(7) do |updates|
              xml.item do
                xml.title "TOMOYO recent update!!"
                text = ""
                updates.each do |u|
                  text += u[:created_at].strftime('%Y-%m-%d %H:%M:%S') + " " + u[:file] + "<br>"
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
