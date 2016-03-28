module ApplicationHelper
	def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Social Friends").join(" - ")
      end
    end
  end

  def active_link(path)
    if current_page? path
      "active"
    end
  end

  def user_avatar(user)
    if user.attachments.default
      user.attachments.default.file.url(:thumb)
    else
      "/assets/no-user.png"
    end
  end
end
