module ApplicationHelper
  require 'redcloth'
  require 'htmlentities'

  def to_html(m)
    coder = HTMLEntities.new
    m = coder.decode(m)
    m =  RedCloth.new(m, [:filter_html, :sanitize_html]).to_html
    m.html_safe
  end

end
