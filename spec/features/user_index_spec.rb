# spec/features/user_index_spec.rb

require 'rails_helper'

RSpec.feature 'User Index Page' do
  scenario 'displays a list of users with photo, name, and recipe count' do
    # Assuming you have some users in the database with associated recipes
    users_with_recipes = create_list(:user, 3)
    users_without_recipes = create_list(:user, 2)

    visit users_path

    expect(page).to have_content('Users')

    users_with_recipes.each do |user|
      expect(page).to have_css(".card", count: users_with_recipes.size)

      within(".cardlist") do
        within(".card", text: user.name) do
          expect(page).to have_css(".user-photo[src='#{user.photo}']")
          expect(page).to have_content(user.name)
          expect(page).to have_content("Number of recipes: #{user.recipes.count}")
        end
      end
    end

    users_without_recipes.each do |user|
      expect(page).to have_css(".card", count: users_with_recipes.size + users_without_recipes.size)

      within(".cardlist") do
        expect(page).to have_css(".card", text: user.name)
        expect(page).to have_css(".user-photo[src='#{user.photo}']")
        expect(page).to have_content(user.name)
        expect(page).to have_content("Number of recipes: 0")
      end
    end
  end

end
