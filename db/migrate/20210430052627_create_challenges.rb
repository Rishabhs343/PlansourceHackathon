# frozen_string_literal: true

class CreateChallenges < ActiveRecord::Migration[5.1]
  def change
    create_table :challenges do |t|
      t.text :title
      t.text :description
      t.string :tags
      t.string :emp_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
