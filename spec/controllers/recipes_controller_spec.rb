require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      user = User.create(name: 'John Doe', email: 'test@example.com', password: 'password123')
      sign_in user

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #public_recipes' do
    it 'renders the public_recipes template' do
      get :public_recipes
      expect(response).to render_template(:public_recipes)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      user = User.create(name: 'John Doe', email: 'test@example.com', password: 'password123')
      sign_in user

      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the recipe' do
      user = User.create(name: 'John Doe', email: 'test@example.com', password: 'password123')
      sign_in user
      Recipe.create(name: 'Pasta Carbonara', description: 'Delicious pasta dish', user:)
    end
  end
end
