class User < ActiveRecord::Base
  rolify
  acts_as_paranoid
  has_paper_trail
	TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  attr_accessor :login
	# Include default devise modules. Others available are:
	# :lockable, :timeoutable
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
	       :trackable, :validatable, :confirmable, :omniauthable, :authentication_keys => [:login]

  has_many :blog_posts
  has_many :comments

	validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates :fullname, length: 2..30
  validates :username, presence: true
	validates :username, uniqueness: true, if: -> { self.username.present? }
	validates :username, exclusion: { in: %w(user admin superuser blogger) }
	validates :username, length: 2..30

	scope :without_role, ->(role) { where.not(id: Role.find_by(name: role.to_s).users.pluck(:id)) }

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?
    	if auth.provider == "facebook"
    		# Get the existing user by email if the provider gives us a verified email.
	      # If no verified email was provided we assign a temporary email and ask the
	      # user to verify it on the next step via UsersController.finish_signup
	      # email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
	      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
	      email = auth.info.email if email_is_verified
	      user = User.where(email: email).first if email
	      username = nil
	      if auth.info.nickname.present?
	      	username = auth.info.nickname
	      elsif auth.info.name.present?
	      	username = auth.info.name.downcase.gsub(" ", "")
	      	user_count = User.where("username LIKE ?", "#{username}%").count
	      	if user_count > 0
	      		username = username + (user_count).to_s
	      	end
	      else
	      	username = auth.uid
	      end
	      # Create the user if it's a new registration
	      if user.nil?
	        user = User.new(
	          fullname: auth.info.name,
	          username: username,
	          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
	          password: Devise.friendly_token[0,20],
	          photo_url_thumb: auth.info.image
	        )
	        user.skip_confirmation!
	        user.add_role :blogger
	        user.save!
	      end
    	elsif auth.provider == "twitter"
	      email = nil
	      user = User.where(email: email).first if email
	      username = nil
	      if auth.info.nickname.present?
	      	username = auth.info.nickname
	      elsif auth.info.name.present?
	      	username = auth.info.name.downcase.gsub(" ", "")
	      	user_count = User.where("username LIKE ?", "#{username}%").count
	      	if user_count > 0
	      		username = username + (user_count).to_s
	      	end
	      else
	      	username = auth.uid
	      end

	      # Create the user if it's a new registration
	      if user.nil?
	        user = User.new(
	          fullname: auth.info.name,
	          username: username,
	          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
	          password: Devise.friendly_token[0,20],
	          photo_url_thumb: auth.info.image
	        )
	        user.skip_confirmation!
	        user.add_role :blogger
	        user.save!
	      end
    	elsif auth.provider == "linkedin"
	      email = auth.info.email
	      user = User.where(email: email).first if email
	      username = nil
	      if auth.info.name.present?
	      	username = auth.info.name.downcase.gsub(" ", "")
	      	user_count = User.where("username LIKE ?", "#{username}%").count
	      	if user_count > 0
	      		username = username + (user_count).to_s
	      	end
	      else
	      	username = auth.uid
	      end
	      # Create the user if it's a new registration
	      if user.nil?
	        user = User.new(
	          fullname: auth.info.name,
	          username: username,
	          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
	          password: Devise.friendly_token[0,20],
	          photo_url_thumb: auth.info.image
	        )
	        user.skip_confirmation!
	        user.add_role :blogger
	        user.save!
	      end
    	elsif auth.provider == "github"
	      email = auth.info.email
	      user = User.where(email: email).first if email
	      username = nil
	      if auth.info.nickname.present?
	      	username = auth.info.nickname
	      elsif auth.info.name.present?
	      	username = auth.info.name.downcase.gsub(" ", "")
	      	user_count = User.where("username LIKE ?", "#{username}%").count
	      	if user_count > 0
	      		username = username + (user_count).to_s
	      	end
	      else
	      	username = auth.uid
	      end

	      # Create the user if it's a new registration
	      if user.nil?
	        user = User.new(
	          fullname: auth.info.name,
	          username: username,
	          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
	          password: Devise.friendly_token[0,20],
	          photo_url_thumb: auth.info.image
	        )
	        user.skip_confirmation!
	        user.add_role :blogger
	        user.save!
	      end
    	elsif auth.provider == "google_oauth2"
	      email = auth.info.email
	      user = User.where(email: email).first if email
	      username = nil
	      if auth.info.name.present?
	      	username = auth.info.name.downcase.gsub(" ", "")
	      	user_count = User.where("username LIKE ?", "#{username}%").count
	      	if user_count > 0
	      		username = username + (user_count).to_s
	      	end
	      else
	      	username = auth.uid
	      end
	      # Create the user if it's a new registration
	      if user.nil?
	        user = User.new(
	          fullname: auth.info.name,
	          username: username,
	          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
	          password: Devise.friendly_token[0,20],
	          photo_url_thumb: auth.info.image
	        )
	        user.skip_confirmation!
	        user.add_role :blogger
	        user.save!
	      end
    	end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end
end
