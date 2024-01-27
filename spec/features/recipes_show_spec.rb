# spec/features/recipe_show_spec.rb

require 'rails_helper'

RSpec.feature 'Recipe Show Page' do
  scenario 'User views a recipe' do
    # Assuming you have a recipe in the database
    recipe = create(:recipe, name: 'Delicious Dish', preparation_time: 30, cooking_time: 60, description: 'A tasty dish that you will love!')

    visit recipe_path(recipe)

    expect(page).to have_content('Delicious Dish')
    expect(page).to have_content('Preparation Time: 30 minutes')
    expect(page).to have_content('Cooking Time: 60 minutes')
    expect(page).to have_content('Description: A tasty dish that you will love!')
    # Add other expectations based on your actual show page content
  end
end
