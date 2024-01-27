# spec/features/foods_view_spec.rb

require 'rails_helper'

RSpec.feature 'Foods view', type: :feature do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }

  before { sign_in user }

  scenario "User sees the 'Your stored food' section" do
    Food.create(name: 'Apple', measurement_unit: 'Piece', price: 1.99, quantity: 5, user: user)
    visit foods_path

    expect(page).to have_css('.food-container')
    expect(page).to have_selector('h2.header', text: 'Your Stored Food')
    expect(page).to have_link('Add Food', href: new_food_path)
  end

  scenario 'User sees a message when no food is available' do
    visit foods_path

    expect(page).to have_content('No food in your store, click on the button to add some.')
    expect(page).to have_link('Add Food', href: new_food_path)
  end

  scenario 'User sees the details of stored food' do
    food = Food.create(name: 'Banana', measurement_unit: 'Piece', price: 2.49, quantity: 8, user: user)
    visit foods_path

    expect(page).to have_selector('.food-row td', text: 'Banana')
    expect(page).to have_selector('.food-row td', text: 'Piece')
    expect(page).to have_selector('.food-row td', text: '$2.49')
    expect(page).to have_link('Modify', href: edit_food_path(food))
    expect(page).to have_link('Delete', href: food_path(food))
  end

  scenario 'User does not see modify and delete links without appropriate permissions' do
    food = Food.create(name: 'Orange', measurement_unit: 'Piece', price: 1.79, quantity: 10, user: user)
    visit foods_path

    expect(page).to have_selector('.food-row td', text: 'Orange')
    expect(page).not_to have_link('Modify', href: edit_food_path(food))
    expect(page).not_to have_link('Delete', href: food_path(food))
  end
end
