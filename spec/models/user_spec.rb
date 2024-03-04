require 'rails_helper'

RSpec.describe User, type: :model do
  # Validations
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(phone_number: '1234567890', verified: true, password: 'password',
                      password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'validates presence of phone_number' do
      user = User.new(phone_number: nil)
      expect(user).not_to be_valid
      expect(user.errors.messages[:phone_number]).to include("can't be blank")
    end

    it 'validates uniqueness of phone_number' do
      existing_user = User.create(phone_number: '1234567890', verified: true, password: 'password',
                                  password_confirmation: 'password')
      user = User.new(phone_number: existing_user.phone_number)
      expect(user).not_to be_valid
      expect(user.errors.messages[:phone_number]).to include('has already been taken')
    end

    it 'validates inclusion of verified in [true, false]' do
      user = User.new(verified: nil)
      expect(user).not_to be_valid
      expect(user.errors.messages[:verified]).to include('is not included in the list')
    end
  end

  # Associations
  describe 'associations' do
    it 'has many summary_translations dependent destroy' do
      is_expected.to have_many(:summary_translations).dependent(:destroy)
    end
  end

  # Methods
  describe '#reset_failed_attempts' do
    it 'resets failed_attempts and locked_at' do
      user = User.create(phone_number: '1234567890', verified: true, password: 'password',
                         password_confirmation: 'password', failed_attempts: 3, locked_at: Time.current)
      user.reset_failed_attempts
      user.reload

      expect(user.failed_attempts).to eq(0)
      expect(user.locked_at).to be_nil
    end
  end

  describe '#lock_account' do
    it 'sets locked_at to current time' do
      user = User.create(phone_number: '1234567890', verified: true, password: 'password',
                         password_confirmation: 'password')
      user.lock_account
      user.reload

      expect(user.locked_at).to be_within(1.second).of(Time.current)
    end
  end
end
