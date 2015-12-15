module UsersHelper
  def avatar_for(user, options = {})
    unless user.nil?
      default_options = { size: :normal }
      options = default_options.merge(options)
      size = avatar_sizes[options[:size]]

      get_gravatar(user, size)
    end
  end

  private

  def get_gravatar(user, size)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: 'gravatar', width: "#{size}", height: "#{size}")
  end

  def avatar_sizes
    { micro: 24, normal: 80 }
  end
end
