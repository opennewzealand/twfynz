FactoryGirl.define do
  sequence(:email) { |n| "unique#{n}@example.com" }
  sequence(:login) { |n| "login_#{n}" }

  factory :user do
    email
    login
    password "password"
    password_confirmation "password"
    salt "abc123"
  end
end
