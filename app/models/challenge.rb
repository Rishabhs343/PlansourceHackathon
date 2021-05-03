# frozen_string_literal: true

class Challenge < ApplicationRecord
  belongs_to :user
  acts_as_votable
  acts_as_followable
end
