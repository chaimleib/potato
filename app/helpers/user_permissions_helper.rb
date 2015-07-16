module UserPermissionsHelper
  RIGHT_ARROW = "\u2192"

  def admin_notes(user_permission)
    admin_notes = []
    user = user_permission.user
    if user.is_root?
      admin_notes << 'root'
    end
    if !!user_permission.is_admin != user.is_admin?
      admin_notes << "user.is_admin? #{RIGHT_ARROW} #{user.is_admin?}"
    end
    admin_notes
  end
end
