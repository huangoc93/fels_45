module ApplicationHelper
  def full_title page_title = ''
    base_title = "E-Learning"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def show_image default, url, options = {} 
    if default == :category 
      default = "/default/category.jpg"
    elsif default == :user 
      default = "/default/user.png"
    elsif default == :admin 
      default = "/default/admin.png"
    end
    image_tag(url || default, options)
  end
end