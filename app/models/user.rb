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
    if self.id.to_s.length<2
      @newid= "E0" + self.id.to_s
    else
      @newid= "E" + self.id.to_s
    end
    @user=User.find_by_id(self.id)
    @user.update(emp_id: @newid)
  end
  
  
  def validate_emp_id
    if User.where(email: emp_id).exists?
      errors.add(:emp_id, :invalid)
    end
  end
  attr_writer :login
  
  def login
    @login || self.emp_id || self.email
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(emp_id) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:emp_id].nil?
        where(conditions).first
      else
        where(emp_id: conditions[:emp_id]).first
      end
    end
  end
end
