# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Challenge, type: :model do
  current_user = User.first_or_create(email: "rishabh@gmail.com", password: "11111", password_confirmation: "11111", emp_id: "E01")
  it 'title' do
    challenge = Challenge.new(
      title: '',
      description: 'new description',
      tags: 'new tags',
      user: current_user
    )
    expect(challenge).to_not be_valid

    challenge.title = 'new title'
    expect(challenge).to be_valid
  end

  it 'description' do
    challenge = Challenge.new(
      title: 'Test Title',
      description: '',
      tags: 'a tags in',
      user: current_user
    )
    expect(challenge).to_not be_valid

    challenge.description = 'new description'
    expect(challenge).to be_valid
  end

  it 'tags' do
    challenge = Challenge.new(
      title: 'Test Title',
      description: 'A description test',
      tags: '',
      user: current_user
    )
    expect(challenge).to be_valid
  end

  it 'title has minimum 4 characters' do
    challenge = Challenge.new(
      title: '',
      description: 'New description',
      tags: 'New Tags',
      user: current_user
    )
    expect(challenge).to_not be_valid

    challenge.title = 'Test Title'
    expect(challenge).to be_valid
  end

  it 'description has minimum 4 character' do
    challenge = Challenge.new(
      title: 'Test Title',
      description: '',
      tags: 'New tags',
      user: current_user
    )
    expect(challenge).to_not be_valid

    challenge.description = '1234'
    expect(challenge).to be_valid

    string = 'qwertyuiasdfghjklzxc'
    challenge.description = string
    expect(challenge).to be_valid

    challenge.description = "#{string}"*3
    expect(challenge).to_not be_valid
  end
end
