require 'addressable/uri'
require 'rest-client'

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json',
  ).to_s
  begin
    puts RestClient.post(url, :user => {
    name: "Tiger"
    } )
  rescue RestClient::Exception => e
    puts e.message
  end
end

def update_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/4.json',
  ).to_s
  begin
    puts RestClient.patch(url, :user => {
    email: "tiger@example.com"
    } )
  rescue RestClient::Exception => e
    puts e.message
  end
end

def destroy_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/3.json',
  ).to_s
  begin
    puts RestClient.delete(url)
  rescue RestClient::Exception => e
    puts e.message
  end
end

destroy_user
