module RailsLite
  class Route
    attr_reader :pattern, :http_method, :controller_class, :action_name

    def initialize(pattern, http_method, controller_class, action_name)
      @pattern = parse_pattern(pattern)
      @http_method = http_method.to_s.upcase
      @controller_class = controller_class
      @action_name = action_name
    end

    # checks if pattern matches path and method matches request method
    def matches?(req)
      req.path =~ pattern && req.request_method.to_s.upcase == http_method
    end

    # use pattern to pull out route params (save for later?)
    # instantiate controller and call controller action
    def run(req, res)
      controller = controller_class.new(req, res, route_params(req))
      controller.invoke_action(action_name)
    end

    private

    def parse_pattern(pattern)
      return pattern if pattern.is_a?(Regexp)
      Regexp.new(pattern.to_s)
    end

    def route_params(req)
      route_match = pattern.match(req.path)
      params = {}
      route_match.names.each do |match_name|
        params[match_name] = route_match[match_name]
      end

      params
    end
  end

  class Router
    attr_reader :routes

    def initialize
      @routes = []
    end

    # simply adds a new route to the list of routes
    def add_route(pattern, method, controller_class, action_name)
      @routes << Route.new(pattern, method, controller_class, action_name)
    end

    # evaluate the proc in the context of the instance
    # for syntactic sugar :)
    def draw(&proc)
      instance_eval(&proc)
    end

    # make each of these methods that
    # when called add route
    [:get, :post, :put, :delete].each do |http_method|
      define_method(http_method) do |pattern, controller_class, action_name|
        add_route(pattern, http_method, controller_class, action_name)
      end
    end

    # should return the route that matches this request
    def match(req)
      @routes.find { |route| route.matches?(req) }
    end

    # either throw 404 or call run on a matched route
    def run(req, res)
      route = match(req)
      if route.nil?
        res.status = 404
        res.body = "Cannot find route for #{req.request_method} #{req.path}"
      else
        route.run(req, res)
      end
    end
  end
end
