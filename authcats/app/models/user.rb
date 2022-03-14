class User < ApplicationRecord
  validates :user_name, :password_digest, presence: true
  validates :user_name, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many :cats,
    foreign_key: :user_id,
    class_name: :Cat,
    dependent: :destroy

  has_many :requests,
    foreign_key: :user_id,
    class_name: :CatRentalRequest,
    dependent: :destroy

  has_many :sessions, 
    foreign_key: :user_id,
    class_name: :Session,
    dependent: :destroy

  def reset_session_token!
    self.create_session.session_token
  end

  def password
    @password
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)    
  end

  def is_password?(password)
    password_object = BCrypt::Password.new(self.password_digest)
    password_object.is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(user_name: username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def create_session
    session = Session.create!(session_token: SecureRandom::urlsafe_base64, user_id: self.id)
    session
  end

end
