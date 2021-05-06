# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:email) { "foo@bar.com" }
  let(:warden_conditions) { { login: email } }

  it "finds user by email" do
    user = User.create(email: email)
    authenticated = User.find_for_database_authentication(warden_conditions)
    expect(authenticated).eql? user 
  end

  it "finds user by emp_id" do
    user = User.create(emp_id: email)
    authenticated = User.find_for_database_authentication(warden_conditions)
    expect(authenticated).eql? user 
  end
end
