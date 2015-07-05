module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:span, msg) }.join
    html = <<-HTML
    <div class='flash-messages'>
      <div class="alert fade in alert-danger"> 
        <a class="close" data-dismiss="alert">&times</a>
        #{messages}
      </div>
    </div>
    HTML

    html.html_safe
  end
end