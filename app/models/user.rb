class User < ActiveRecord::Base
  validates :username, :session_token, :password_digest, presence: true
  validates :username, uniqueness: true

  has_many :goals

  after_initialize :ensure_session_token

  attr_reader :password

  validates :password, length: { minimum: 6, allow_nil: true }

  def self.find_by_credentials(username, password)
    possible_user = User.find_by(username: username)
    return nil unless possible_user
    BCrypt::Password.new(possible_user.password_digest).is_password?(password) ? possible_user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end

end
