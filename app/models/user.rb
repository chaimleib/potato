require 'user_permission'

class User < ActiveRecord::Base
  has_one :user_permission

  before_save{
    self.email = email.downcase
  }

  after_save{
    self.ensure_permission
  }

  before_destroy {
    raise "Cannot destroy root user" if self.is_root?
    self.user_permission.destroy
  }

  validates :fname,
    presence: true
  validates :lname,
    presence: true
  validates :email,
    presence: true,
    length: {minimum: 3},
    uniqueness: {case_sensitive: false}
  
  has_secure_password
  
  def full_name
    "#{fname} #{lname}"
  end

  def concealed_email
    email.sub /\A([^@])[^@]+@/, '\1***@'
  end

  def human_email
    "#{full_name} <#{email}>"
  end

  def self.root_user
    root_email = Rails.application.secrets.root_user
    root = root_email.present? && User.find_by(email: root_email) || 
      self.first
  end

  def is_root?
    self == User.root_user
  end

  def is_admin?
    # Root has a strict superset of admin permissions, and is an
    # admin, even if his user_permissions don't say so.
    self.is_root? || 
      self.ensure_permission.is_admin
  end

  def may_delete_user?(other)
    # Only admins can delete users. 
    return false unless self.is_admin?

    # Nobody, not even root, can delete root. 
    return false if other.is_root?

    #self != other  # Nobody can delete themselves.
    true
  end

  def ensure_permission
    # Make sure that this User has a UserPermission.
    # Create it if it's not there yet.
    # @returns user_permission
    perms = user_permission
    unless perms
      perms = UserPermission.create(user: self, is_admin: false)
      perms.save
    end
    perms
  end

end
