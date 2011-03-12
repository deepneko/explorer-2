require 'rack/test'

module MyTest
  def app
    Sinatra::Application
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include MyTest
end
