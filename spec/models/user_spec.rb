# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:given_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('test').for(:email) }
    it { should validate_presence_of(:uid) }
    it { should validate_uniqueness_of(:uid) }
  end

  describe 'associations' do
    it { should have_many(:receipts) }
  end

  describe '#full_name' do
    it 'returns the full name' do
      user = User.new(given_name: 'John', last_name: 'Doe')
      expect(user.full_name).to eq('John Doe')
    end
  end

  describe '.from_omniauth' do
    let(:user_info) do
      OmniAuth::AuthHash.new(
        email: 'test@example.com',
        given_name: 'John',
        family_name: 'Doe',
        nickname: 'johndoe'
      )
    end

    it 'creates a new user' do
      expect { User.from_omniauth(user_info) }.to change(User, :count).by(1)
    end

    it 'finds an existing user' do
      User.create!(
        email: 'test@example.com',
        given_name: 'Jane',
        last_name: 'Doe',
        username: 'janedoe',
        uid: '123'
      )
      expect { User.from_omniauth(user_info) }.to_not change(User, :count)
    end
  end
end
