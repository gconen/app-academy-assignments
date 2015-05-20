require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      cookie = req.cookies.find { |cookie| cookie.name == "_rails_lite_app"}
      if cookie.nil?
        @contents = {}
      else
        @contents = JSON.parse(cookie.value)
      end
    end

    def [](key)
      @contents[key]
    end

    def []=(key, value)
      @contents[key] = value
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      cookie = WEBrick::Cookie.new("_rails_lite_app", @contents.to_json)
      res.cookies << cookie
    end
  end
end
