class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook] #, :confirmable
  
  has_many :flits, dependent: :destroy
  validates :password, length: { minimum: 6 }
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many :flits

  def self.find_for_facebook_oauth(omniauth)
    if user = User.find_by_email(omniauth.info.email)
      if omniauth.info.image.present?
        user.update_attribute(:image, omniauth.info.image)
      end
      user
      else # Create a user with a stub password. 
        User.create!(:email => omniauth.info.email,
                  :name => omniauth.info.name,
                  :image => omniauth.info.image,
                  :password => Devise.friendly_token[0,20])
      end
    end
    def self.new_with_session(params, session)
      super.tap do |user|
        if omniauth = session["devise.facebook_data"]
          user.email = omniauth.info.email
          user.name = omniauth.info.name
          user.image = omniauth.info.image
        end
      end
    end
  end
