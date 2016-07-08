class User < ActiveRecord::Base
  attr_accessor :remember_token

  before_save{ email.downcase! }
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true,
    length: {maximum:255},
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+(\.[a-z\d\-]+)+\z/i},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_token, User.digest(remember_token))
  end

  def authenticated?
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
