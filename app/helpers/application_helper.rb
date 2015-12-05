module ApplicationHelper
  # Returns a glyphicon tag
  def glyphicon(name)
    content_tag :i, '', class: "glyphicon glyphicon-#{name}"
  end
end
