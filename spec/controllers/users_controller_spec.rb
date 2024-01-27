# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      user = User.create(name: 'John Dose', email: 'tesat@example.com', password: 'password123')
      sign_in user

      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @users with all users' do
      user1 = User.create(name: 'John Doe', email: 'test@example.com', password: 'password123')
      user2 = User.create(name: 'John DoeN', email: 'test2@example.com', password: 'password123')
      sign_in user1

      get :index
      expect(assigns(:users)).to match_array([user1, user2])
    end
  end
end
