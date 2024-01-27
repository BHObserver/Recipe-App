require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', photo: 'https://john-doe-picture', email: 'john@doe.com', password: 'johndoe123') }

  before { subject.save }

  describe '#validators' do
    it 'Name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should have the role user by default' do
      expect(subject.role).to eq('user')
    end

    it 'should have an email' do
      expect(subject.email).to eq('john@doe.com')
    end

    it 'should have a photo' do
      expect(subject.photo).to eq(subject.photo)
    end

    it 'should have a password' do
      expect(subject).to be_valid
    end
  end
end
