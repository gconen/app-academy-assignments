module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller
    def initialize(req, res)
      @req, @res = req, res
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      @already_built_response
    end

    # Set the response status code and header
    def redirect_to(url)
      check_unbuilt
      @res.status = 302
      @res["Location"] = url
      @already_built_response = true
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, content_type)
      check_unbuilt
      @res.body = content
      @res.content_type = content_type
      @already_built_response = true
    end

    private
    def check_unbuilt
      if already_built_response?
        raise ControllerError.new("Response already built")
      end
    end
  end
end

class ControllerError < StandardError

end
