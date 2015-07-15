FactoryGirl.define do
  factory :user do
    fname "Tester"
    lname "Beta"
    sequence(:email) {|n| "tester#{n}@localhost"}
    password "foobarbaz"
    password_confirmation "foobarbaz"

    trait :root do
      # Assumes this user is created first, or is set to be ROOT_USER in env
      fname "Admin"
      lname "Root"
      email "root@localhost"
    end

    trait :admin do
      fname "Adam"
      lname "En"
      sequence(:email) {|n| "adam#{n}@localhost"}

      after :create do |user|
        perms = user.ensure_permission
        perms.is_admin = true
        perms.save
      end
    end
    factory :root_user, traits: [:root]
    factory :admin_user, traits: [:admin]
  end

end
  
