class User < ActiveRecord::Base
  attr_reader :password

  after_initialize :ensure_session_token

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, presence: true, uniqueness: true

  # Where does this get called?  This gets called by the sessions
  # controller at login
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)

    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
  end

  # Checks to see if the password digest matches the password.
  # New duplicates the hash, create would hash the digest again.
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  # Take the password from the input form, assigns it to the instance
  # variable and then created a password_digest to store in the database
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  # This will be used when a new user logs in to the application
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  private
    # This checks for a session token or reassigns to a new one if
    # none present
    def ensure_session_token
      self.session_token ||= SecureRandom.urlsafe_base64(16)
    end
end
