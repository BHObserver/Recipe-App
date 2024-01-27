# spec/features/recipes_spec.rb

require 'rails_helper'

RSpec.feature 'Recipes', type: :feature do
  let(:user) { create(:user) }

  context 'when user is signed in' do
    before { sign_in user }

    scenario 'user can add a new recipe' do
      visit new_recipe_path
      # Assuming your form has a title 'New Recipe Form'
      expect(page).to have_content('New Recipe Form')
    end

    scenario 'user can view their recipes' do
      create(:recipe, user: user, name: 'Recipe 1')
      create(:recipe, user: user, name: 'Recipe 2')

      visit recipes_path
      expect(page).to have_content('My Recipes')
      expect(page).to have_link('Add Recipe', href: new_recipe_path)
      expect(page).to have_selector('.recipe-list', count: user.recipes.count)
    end

    scenario 'user can view a specific recipe' do
      recipe = create(:recipe, user: user, name: 'Chicken Curry')
      visit recipe_path(recipe)
      expect(page).to have_content('Chicken Curry')
    end

    scenario 'user can view public recipes' do
      public_recipe = create(:recipe, public: true, name: 'Public Recipe')
      visit public_recipes_path
      expect(page).to have_content('Public Recipe')
    end
  end

  context 'when user is not signed in' do
    scenario 'user cannot add a new recipe' do
      visit new_recipe_path
      expect(page).to have_content('Sign in')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end

    scenario 'user can view public recipes' do
      public_recipe = create(:recipe, public: true, name: 'Public Recipe')
      visit public_recipes_path
      expect(page).to have_content('Public Recipe')
    end
  end
end
