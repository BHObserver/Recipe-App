# spec/features/recipe_index_spec.rb

require 'rails_helper'

RSpec.feature 'Recipe Index', type: :feature do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }

  before { sign_in user }


  scenario 'User views the recipe index with no recipes' do
    visit recipes_path

    expect(page).to have_css('h2.header', text: 'My Recipes')
    expect(page).to have_link('Add Recipe', href: new_recipe_path)

    expect(page).to have_content('No recipe added, click on the button to add some.')
  end
end
