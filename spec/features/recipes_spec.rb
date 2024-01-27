# spec/features/recipes_spec.rb

require 'rails_helper'

RSpec.feature 'Recipes', type: :feature do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }

  context 'when user is signed in' do
    before { sign_in user }

    scenario 'user can add a new recipe' do
      visit new_recipe_path

      expect(page).to have_content('Create a New Recipe')
    end

    scenario 'user can view their recipes' do
      Recipe.create(user:, name: 'Recipe 1')
      Recipe.create(user:, name: 'Recipe 2')

      visit recipes_path
      expect(page).to have_content('My Recipes')
      expect(page).to have_link('Add Recipe', href: new_recipe_path)
      expect(page).to have_selector('.recipe-list', count: user.recipes.count)
    end

    scenario 'user can view a specific recipe' do
      recipe = Recipe.create(user:, name: 'Apple pie', preparation_time: 30, cooking_time: 15,
                             description: 'Very easy to prepare', public: true)
      visit recipe_path(recipe)
      expect(page).to have_content('Apple pie')
    end
  end

  context 'when user is not signed in' do
    scenario 'user cannot add a new recipe' do
      visit new_recipe_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
