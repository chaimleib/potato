require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.build :user
  end
  
  it 'should be valid from the factory' do
    expect(@user).to be_valid
  end
  
  describe "Email" do
    it "should be unique" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user).to_not be_valid
    end
    
    it "should accept hostnames with any number of domain segments" do
      @user.email = 'me@example'
      expect(@user).to be_valid
      @user.email = 'me@mail.example.com'
      expect(@user).to be_valid
    end
    
    it "should have a valid user" do
      @user.email = 'me-two@example.com'
      expect(@user).to be_valid
      
      @user.email = 'me$two@example.com'
      expect(@user).to_not be_valid
    end
    
    it "should have a valid host" do
      @user.email = 'me@example-2.com'
      expect(@user).to be_valid
      
      @user.email = 'me@example#2.com'
      expect(@user).to_not be_valid
      
      @user.email = 'me@example..com'
      expect(@user).to_not be_valid
    end
    
    it "should be saved in lower-case" do
      mixed_case = 'Me3THREe@ExamPle.COM'
      @user.email = mixed_case
      @user.save
      expect(@user.email).to eq mixed_case.downcase
    end
      
  end
  
  describe "Password" do
    it 'should be present and nonblank' do
      @user.password = @user.password_confirmation = ' '*8
      expect(@user).to_not be_valid
    end
    
    it 'should be long enough (>8 chars)' do
      @user.password = @user.password_confirmation = 'a'*7
      expect(@user).to_not be_valid
    end
    
    it 'should accept a random 8-char string' do
      @user.password = @user.password_confirmation = 'VB]@0\(7'
      expect(@user).to be_valid
    end
  end
  
end

