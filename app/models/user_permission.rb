class UserPermission < ActiveRecord::Base
  belongs_to :user

  def self.user_is_admin?(user)
    perm = self.find_by(user: user)
    return false unless perm
    !!perm.is_admin
  end
end
