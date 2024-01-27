require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password123') }

  subject do
    Recipe.new(user:, name: 'Pizza', preparation_time: 30, cooking_time: 15, description: 'Very easy to prepare',
               public: true)
  end

  before { subject.save }

  describe '#validators' do
    it 'requires user_id to be present' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end

    it 'requires user_id to correspond to an existing user' do
      subject.user_id = user.id + 1
      expect(subject).to_not be_valid
      expect(subject.errors[:user]).to include('must exist')
    end

    it 'requires name to be present' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    # ... (other tests remain unchanged)

    it 'requires public to be either true or false' do
      subject.public = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:public]).to include('is not included in the list')
    end
  end
end
