class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :posts

  def admin?
    true
  end

  def self.find_for_douban_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = self.find_by_email(data.email)
      user
    else # Create a user with a stub password. 
      self.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
    end
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.douban_data"] && session["devise.douban_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  def douban_token
    if self[:douban_token].instance_of? String
      YAML.load self[:douban_token]
    else
      self[:douban_token]
    end      
  end

end
