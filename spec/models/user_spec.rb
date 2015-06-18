require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.build :user
  end
  
  it 'should be valid from the factory' do
    @user.should be_valid
  end
end
    
