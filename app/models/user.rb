# frozen_string_literal: true

class User < ApplicationRecord
  has_many :challenges
  before_commit :update_emp_id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :emp_id, presence: true, uniqueness: { case_sensitive: false }

  validate :validate_emp_id
  acts_as_follower

  def update_emp_id
    @newid = if id.to_s.length < 2
               "E0#{id}"
             else
               "E#{id}"
             end
    @user = User.find_by(id: id)
    @user.update(emp_id: @newid)
  end

  def validate_emp_id
    errors.add(:emp_id, :invalid) if User.where(email: emp_id).exists?
  end
  attr_writer :login

  def login
    @login || emp_id || email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['lower(emp_id) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions[:emp_id].nil?
      where(conditions).first
    else
      where(emp_id: conditions[:emp_id]).first
    end
  end
end
