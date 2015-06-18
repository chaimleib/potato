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
end

