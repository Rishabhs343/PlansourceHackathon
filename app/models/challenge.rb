# frozen_string_literal: true

class Challenge < ApplicationRecord
  belongs_to :user
  acts_as_votable
  acts_as_followable
  validates :title, presence: true, length: { minimum: 4, maximum: 20 }
  validates :description, presence: true, length: { minimum: 4, maximum: 50 }
end
