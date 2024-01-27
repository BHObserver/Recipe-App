# spec/features/foods_view_spec.rb

require 'rails_helper'

RSpec.feature 'Foods view', type: :feature do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }

  before { sign_in user }

  scenario "User sees the 'Your stored food' section" do
    Food.create(name: 'Apple', measurement_unit: 'Piece', price: 1.99, quantity: 5, user:)
    visit foods_path

    expect(page).to have_css('.food-container')
  end

  scenario 'User sees a message when no food is available' do
    visit foods_path

    expect(page).to have_content('No food in your store, click on the button to add some.')
    expect(page).to have_link('Add Food', href: new_food_path)
  end
end
