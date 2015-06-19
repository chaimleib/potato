class User < ActiveRecord::Base
  EMAIL_RGX = /\A[a-z0-9][-_\.a-z0-9]*@[a-z0-9][-_a-z0-9]*(\.[a-z0-9][a-z0-9]*)*\z/i
  before_save { self.email = email.downcase }
  has_secure_password
  
  validates :name, 
    presence: true
  validates :email, 
    presence: true, 
    format: {with: EMAIL_RGX},
    uniqueness: { case_sensitive: false }
  validates :password,
    presence: true,
    length: { minimum: 8 }
  
end

