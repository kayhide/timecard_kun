require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.without_hidden' do
    it 'scopes by hidden' do
      users = FactoryBot.create_list(:user, 2, hidden: false)
      FactoryBot.create(:user, hidden: true)
      expect(User.without_hidden).to eq users
    end
  end
end
