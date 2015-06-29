class User < ActiveRecord::Base
  before_save{
    self.email = email.downcase
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
end
