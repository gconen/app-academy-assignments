module ApplicationHelper
  def format_id_tag(name)
    name.gsub(/[\[\]_]/, '-')
  end

  def csrf_input
    html = <<-HTML
      <input type="hidden"
        name="authenticity_token"
        value="#{form_authenticity_token}">
    HTML

    html.html_safe
  end

  def begin_form(action_url, method = "POST")
    html = <<-HTML
      <form action="#{action_url}" method="POST">
        <input type="hidden" name="_method" value="#{method}">
    HTML

    html.html_safe
  end

  def end_form(button = "Submit")
    html = <<-HTML
        <input type="submit" value="#{button}">
      </form>
    HTML
    html.html_safe
  end
end
