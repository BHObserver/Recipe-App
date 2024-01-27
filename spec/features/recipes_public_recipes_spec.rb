# spec/features/recipes_spec.rb

require 'rails_helper'

RSpec.feature 'Public Recipes Page' do
  scenario 'displays public recipes' do
    # Assuming you have some public recipes in your database
    public_recipes = FactoryBot.create_list(:recipe, 3, public: true)

    visit public_recipes_path

    expect(page).to have_content('Public Recipes')

    public_recipes.each do |recipe|
      expect(page).to have_content(recipe.title)
    end
  end
end
