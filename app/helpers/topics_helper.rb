module TopicsHelper

  def user_is_authorized_for_topics?
    current_user && current_user.admin?
  end

  def admin_or_mod_user?
    current_user && current_user.admin? || current_user.moderator?
  end

end
