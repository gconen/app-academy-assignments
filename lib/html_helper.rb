module RailsLite
  module HTMLHelper
    def link_to(title, url = nil)
      url ||= title
      "<a href=http://#{url}>#{title}</a>"
    end
    def button_to(title, url = nil, method = "POST")
      url ||= title
      html = <<-HTML
        <form action="http://#{url}" method="POST">
          <input type="hidden", name="_method" method="#{method}">
          <input type="submit" value="#{title}">
        </form>
      HTML

      html
    end
  end
end
