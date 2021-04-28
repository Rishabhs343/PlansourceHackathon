class User < ApplicationRecord
  before_commit :update_empid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   validates :empid, presence: true, uniqueness: { case_sensitive: false }
  
  validate :validate_empid
  
  def update_empid
    @newid= "E0" + self.id.to_s
    @user=User.find_by_id(self.id)
    @user.update(empid: @newid)
  end
  
  
  def validate_empid
    if User.where(email: empid).exists?
      errors.add(:empid, :invalid)
    end
  end
  attr_writer :login
  
  def login
    @login || self.empid || self.email
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(empid) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:empid].nil?
        where(conditions).first
      else
        where(empid: conditions[:empid]).first
      end
    end
  end
 end
 