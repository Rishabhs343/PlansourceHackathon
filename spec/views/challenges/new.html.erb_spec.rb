# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'challenges/new', type: :view do
  current_user = User.first_or_create(email: 'rishabh@gmail.com', password: '11111', password_confirmation: '11111',
                                      emp_id: 'E01')

  before(:each) do
    assign(:challenge, Challenge.new(
                         title: 'Title',
                         description: 'Description',
                         emp_id: current_user.emp_id,
                         tags: 'tags'
                       ))
  end

  it 'renders new challenge form' do
    render

    assert_select 'form[action=?][method=?]', challenges_path, 'post' do
      assert_select 'input[name=?]', 'challenge[title]'

      assert_select 'input[name=?]', 'challenge[description]'

      assert_select 'input[name=?]', 'challenge[tags]'
    end
  end
end
