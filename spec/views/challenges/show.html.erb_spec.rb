# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'challenges/show', type: :view do
  current_user = User.first_or_create(email: 'rishabh@gmail.com', password: '11111', password_confirmation: '11111',
                                      emp_id: 'E01')

  before(:each) do
    @challenge = assign(:challenge, Challenge.create!(
                                      title: 'Title',
                                      description: 'Description',
                                      emp_id: current_user.emp_id,
                                      tags: 'tags'
                                    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/E01/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/tags/)
  end
end
