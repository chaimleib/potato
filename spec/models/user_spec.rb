require 'rails_helper'
require 'factory_girl'
require 'pry'
require 'pry-nav'

RSpec.describe User, type: :model do
  before :each do
    @root = create(:root_user)
    @user = create(:user)
    @admin = create(:admin_user)
  end

  # after :each do
  #   @root.destroy
  #   @user.destroy
  #   @admin.destroy
  # end

  it 'is not nil' do
    expect(User).to_not be_nil
  end
  
  it 'is not empty' do
    expect(User.count).to be_nonzero
  end

  describe 'Root' do

    it 'is present' do
      expect(@root).to be_a(User)
    end

    it 'is an admin' do
      expect(@root.is_admin?).to be true
    end

    it 'is recognized as root' do
      expect(@root.is_root?).to be true
    end

    it 'is allowed to delete a non-admin' do
      expect(@root.may_delete_user? @user).to be true
    end

    it 'is allowed to delete an admin' do
      expect(@root.may_delete_user? @admin).to be true
    end
  end
end
