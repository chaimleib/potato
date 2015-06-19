require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.build :user
  end
  
  it 'should be valid from the factory' do
    expect(@user).to be_valid
  end
  
  it "should have a unique email" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert !duplicate_user.valid?
  end
  
  describe "Password" do
    it 'should be present and nonblank' do
      @user.password = @user.password_confirmation = ' '*8
      expect(@user).to_not be_valid
    end
    
    it 'should be long enough' do
      @user.password = @user.password_confirmation = 'a'*7
      expect(@user).to_not be_valid
    end
    
    it 'should accept a random 8-char string' do
      @user.password = @user.password_confirmation = 'VB]@0\(7'
      expect(@user).to be_valid
    end
  end
  
end

