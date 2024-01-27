# spec/features/recipes_new_spec.rb

require 'rails_helper'

RSpec.feature 'New Recipe', type: :feature do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }

  before do
    sign_in user
  end

  scenario 'User creates a new recipe' do
    visit new_recipe_path

    # Assuming you have a test image in the spec/fixtures directory
    attach_file('recipe[photo]', Rails.root.join('spec', 'features', 'your_test_image.jpg'))

    fill_in 'recipe[name]', with: 'Delicious Dish'
    fill_in 'recipe[preparation_time]', with: 30
    fill_in 'recipe[cooking_time]', with: 60
    fill_in 'recipe[description]', with: 'A tasty dish that you will love!'

    click_button 'Save'

    expect(page).to have_content('Recipe was successfully created.')
    expect(page).to have_content('Delicious Dish')
  end
end
