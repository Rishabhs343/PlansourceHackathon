# frozen_string_literal: true

class AddApiTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :api_token, :string
  end
end
