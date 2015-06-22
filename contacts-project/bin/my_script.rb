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
    username: "Kim"
    } )
  rescue RestClient::Exception => e
    puts e.message
  end
end

def create_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts.json',
  ).to_s
  begin
    puts RestClient.post(url, :contact => {
      name: "Harry Potter",
      email: "nimbus2000@example.com",
      user_id: 1
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
    path: '/users/1.json',
  ).to_s
  begin
    puts RestClient.patch(url, :user => {
    username: "molly91"
    } )
  rescue RestClient::Exception => e
    puts e.message
  end
end

def update_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/1.json',
  ).to_s
  begin
    puts RestClient.patch(url, :contact => {
      email: "hufflepuffsux@example.com"
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
    path: '/users/2.json',
  ).to_s
  begin
    puts RestClient.delete(url)
  rescue RestClient::Exception => e
    puts e.message
  end
end

update_contact
