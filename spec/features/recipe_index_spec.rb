# spec/features/recipe_index_spec.rb

require 'rails_helper'

RSpec.feature 'Recipe Index', type: :feature do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }

  before { sign_in user }

  scenario 'User views the recipe index with recipes' do
    # Create some recipes for the user
    recipe1 = Recipe.create(name: 'Pasta Carbonara', description: 'Delicious pasta dish', user:)
    recipe2 = Recipe.create(name: 'Chicken Stir-Fry', description: 'Healthy stir-fry', user:)

    visit recipes_path

    expect(page).to have_css('h2.header', text: 'My Recipes')
    expect(page).to have_link('Add Recipe', href: new_recipe_path)



    # Test content within each recipe card
    expect(page).to have_css('.recipe-name', text: 'Chicken Stir-Fry')

    expect(page).to have_link('Remove', href: recipe_path(recipe1))
    expect(page).to have_link('Remove', href: recipe_path(recipe2))

    expect(page).to have_css('.recipe-decision', text: 'Delicious pasta dish')
    expect(page).to have_css('.recipe-decision', text: 'Healthy stir-fry')

    expect(page).to have_css('.total p', text: 'Total food items:')
    expect(page).to have_css('.total p', text: 'Total price:')

    # Add more expectations based on your actual view structure and content
  end

  scenario 'User views the recipe index with no recipes' do
    visit recipes_path

    expect(page).to have_css('h2.header', text: 'My Recipes')
    expect(page).to have_link('Add Recipe', href: new_recipe_path)

    expect(page).to have_content('No recipe added, click on the button to add some.')
  end
end
