# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "challenges/index", type: :view do
  current_user = User.first_or_create(email: "rishabh@gmail.com", password: "11111", password_confirmation: "11111", emp_id: "E01")

  before(:each) do
    assign(:challenges, [
      Challenge.create!(
        title: "Title",
        description: "Description",
        emp_id: current_user.emp_id,
        tags: "tags"
      ),
      Challenge.create!(
        title: "New Title",
        description: "New Description",
        emp_id: current_user.emp_id,
        tags: "New tags"
      )
    ])
  end

  it "renders a list of challenges" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: current_user.emp_id.to_s, count: 2
    assert_select "tr>td", text: "tags".to_s, count: 2
  end
end
