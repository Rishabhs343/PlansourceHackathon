# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Challenge, type: :model do
  current_user = User.first_or_create(email: 'test@example.com', password: 'password',
                                      password_confirmation: 'password')
  it 'title' do
    challenge = Challenge.new(
      title: '',
      description: 'new description',
      tags: 'new tags',
      user: current_user
    )
    expect(challenge).to_not be_valid

    challenge.title = 'has a title'
    expect(challenge).to be_valid
  end

  it 'should have a description' do
    challenge = Challenge.new(
      title: 'A title',
      description: '',
      tags: 'a tags in',
      user: current_user
    )
    expect(challenge).to_not be_valid

    challenge.description = 'has a description'
    expect(challenge).to be_valid
  end

  it 'should have a tags' do
    challenge = Challenge.new(
      title: 'A title',
      description: 'A description test',
      tags: '',
      user: current_user
    )
    expect(challenge).to_not be_valid
  end

  it 'has title atleast 4 to 20 characters' do
    challenge = Challenge.new(
      title: '',
      description: 'A description test',
      tags: 'has a tags',
      user: current_user
    )
    expect(challenge).to_not be_valid

    challenge.title = '1234'
    expect(challenge).to be_valid
  end

  it 'has description atleast  4 to 20 characters' do
    challenge = Challenge.new(
      title: 'A title',
      description: '',
      tags: 'has a tags',
      user: current_user
    )
    expect(challenge).to_not be_valid

    challenge.description = '1234'
    expect(challenge).to be_valid

    char_string = 'fqMdqb8PUJpjYYD5KRVogqRp5qapXLzUW9TQ7H5XpSsii0jga6'
    challenge.description = char_string
    expect(challenge).to be_valid

    challenge.description = "#{char_string}1"
    expect(challenge).to_not be_valid
  end
end
