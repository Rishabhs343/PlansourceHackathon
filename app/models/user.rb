# frozen_string_literal: true

class User < ApplicationRecord
  has_many :challenges
  after_create :generate_api_token
  after_create :update_emp_id
  after_create :welcomemail_create

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :emp_id, presence: true, uniqueness: { case_sensitive: false }

  validate :validate_emp_id
  acts_as_follower

  def generate_api_token
    self.api_token = Devise.friendly_token
    save
  end

  

  def update_emp_id
    @newid = if id.to_s.length < 2
               "E0#{id}"
             else
               "E#{id}"
             end
    # @user = User.find_by(id: id)
    self.emp_id=@newid
    # @user.update(emp_id: @newid)
    save
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

  def welcomemail_create
    UserMailer.welcome_email(self).deliver
  end
end
