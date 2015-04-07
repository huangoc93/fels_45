module UsersHelper
  def gravatar_for user, options = {size: 80, style: ""}
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = user.avatar? ? user.avatar.url :
      "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar",
      style: "max-width: #{size}px; max-height: #{size}px; #{options[:style]}")
  end
end