FactoryGirl.define do
  factory :user_permission do
    user FactoryGirl.create :user
    is_admin false
  end
end
