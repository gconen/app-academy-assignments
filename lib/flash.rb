module RailsLite
  class Flash
    def initialize(req)
      cookie = req.cookies.find { |cookie| cookie.name == "_rails_lite_flash"}
      if cookie.nil?
        @current = {}
      else
        @current = JSON.parse(cookie.value)
      end
      @cookie_data = {}
    end

    def [](key)
      @current[key]
    end

    def []=(key, value)
      @current[key] = value
      @cookie_data[key] = value
    end

    def now
      @current
    end

    def store_flash(res)
      cookie = WEBrick::Cookie.new("_rails_lite_flash", @cookie_data.to_json)
      res.cookies << cookie
    end
  end
end
