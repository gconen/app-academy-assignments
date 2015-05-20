require "active_support/inflector"
require "params"
require "session"
require "flash"

module RailsLite
  class ControllerBase
    attr_reader :req, :res, :params

    # Setup the controller
    def initialize(req, res, route_params = {})
      @req, @res = req, res
      @params = Params.new(req, route_params)
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      @already_built_response
    end

    def invoke_action(name)
      send(name)
      render(name) unless @already_built_response
    end

    # Set the response status code and header
    def redirect_to(url)
      check_unbuilt
      set_cookies
      @res.status = 302
      @res["Location"] = url
      @already_built_response = true
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, content_type)
      check_unbuilt
      set_cookies
      @res.body = content
      @res.content_type = content_type
      @already_built_response = true
    end

    def render(template_name)
      controller_name = self.class.name.underscore
      template = File.read("views/#{controller_name}/#{template_name}.html.erb")
      html = ERB.new(template).result(binding)
      render_content(html, "text/html")
    end

    # method exposing a `Session` object
    def session
      @session ||= Session.new(@req)
    end

    def flash
      @flash  ||= Flash.new(@req)
    end

    def check_unbuilt
      if already_built_response?
        raise ControllerError.new("Response already built")
      end
    end

    def set_cookies
      session.store_session(@res)
      flash.store_flash(@res)
    end
  end

  class ControllerError < StandardError

  end
end
