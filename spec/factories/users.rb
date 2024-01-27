# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'john@example.com' }
    password { 'password123' }
    # Add any other attributes as needed
  end
end
