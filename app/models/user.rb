class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, 
                  :admin, :stripe_user_id, :stripe_card_type,
                  :stripe_card_digits, :stripe_card_expiry

  has_many :invoices

  attr_accessor :password, :stripe_card_token
  before_save :prepare_password

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  # validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates :password, presence: {unless: 'signup_token'}
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  validate :no_stripe_errors

  scope :active, -> { where(:signup_token => nil) }

  def no_stripe_errors
    errors[:base] << @stripe_error if @stripe_error
  end

  def self.admins
    where(admin: true)
  end

  def self.clients
    where(admin: false)
  end
  
  def stripe_error=(error)
    @stripe_error = error
  end

  # login can be either username or email address
  def self.authenticate(login, pass)
    return false if pass.blank?
    user = active.where(:username => login).first || active.where(:email => login).first
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  def is_admin?
    admin
  end

  def create_signup_token
    self.signup_token = SecureRandom.uuid
  end

  def has_card?
    stripe_user_id.present?
  end

  def pending?
    signup_token.present?
  end

  def payable_invoices
    self.invoices.payable
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end
