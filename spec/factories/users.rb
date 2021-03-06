FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "first_name_#{n}" }
    sequence(:last_name) { |n| "last_name_#{n}" }
    sequence(:email) { |n| "example_#{n}@example.com" }
  end
end
