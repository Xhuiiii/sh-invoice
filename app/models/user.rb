class User < ActiveRecord::Base
  attr_accessor :login
  enum role: [:rand, :sk, :staff]

  validates :username, :presence => true, :uniqueness => {:case_sensitive => false}
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  
  after_initialize do
  	self.role ||= :rand
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  def self.sk?
  	self.role == :sk
  end

  def self.staff?
  	self.role == :staff
  end

  def self.rand?
  	self.role == :rand  
  end 

  #Overwrite Devise's find_for_database_authentication method to change the behaviour of the login action. 
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end
end
