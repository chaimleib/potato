require 'user_permission'

class User < ActiveRecord::Base
  has_one :user_permission

  before_save{
    self.email = email.downcase
  }

  after_save{
    self.ensure_permissions
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
    self.is_root? || 
      self.permissions.is_admin
  end

  def may_delete_user?(other)
    return false unless self.is_admin? 
    return false if other.is_root?
    self != other
  end

  def ensure_permissions
    perms = UserPermission.find_by(user: self)
    unless perms
      perms = UserPermission.create(user: self, is_admin: false)
      perms.save
    end
    perms
  end

end
