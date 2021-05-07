# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures Employee Id presence' do
      user = User.new(email: 'rishabh@gmail.com', password: '111111', password_confirmation: '111111',
                      emp_id: 'E01').save
      expect(user).to eq(false)
    end

    it 'ensures Mail Id presence' do
      user = User.new(emp_id: 'newid', password: '111111', password_confirmation: '111111').save
      expect(user).to eq(false)
    end
  end

  context 'scope tests' do
  end
end

describe User, type: :model do
  let(:user) { User.new(emp_id: 'newid', password: '111111', password_confirmation: '111111') }
  describe '#generate_api_token' do
    it 'generate api token and save it' do
      user.api_token = Devise.friendly_token
      expect(user.api_token.length).to eql(20)
    end
  end
end
