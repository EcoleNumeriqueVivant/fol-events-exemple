module ApplicationHelper
  
  def avatar_url(user)
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
  end
  
  def gravatar_for email, options = {}
    options = {:alt => 'avatar', :class => 'avatar', :size => 40}.merge! options
    id = Digest::MD5::hexdigest email.strip.downcase
    url = 'http://www.gravatar.com/avatar/' + id + '?s=' + options[:size].to_s
    options.delete :size
    image_tag url, options
  end
  
end
