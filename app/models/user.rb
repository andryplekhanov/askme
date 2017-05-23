require 'openssl'

class User < ApplicationRecord

  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates_format_of :username, :with => /[a-zA-Z0-9][a-zA-Z0-9\_]+[a-zA-Z0-9]+/
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_length_of :username, :minimum => 6, :maximum => 40

  attr_accessor :password
  validates_presence_of :password, on: :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6

  before_save :encrypt_password

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST))
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
    return user if user.password_hash == hashed_password

    nil
  end
end
