# spec/factories/recipes.rb
FactoryBot.define do
  factory :recipe do
    # Define your recipe attributes here
    name { 'Delicious Recipe' }
    preparation_time { 30 }
    cooking_time { 60 }
    description { 'A tasty dish' }
    public { false }
    # Add any other attributes as needed
  end
end
