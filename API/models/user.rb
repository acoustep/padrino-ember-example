require 'bcrypt'
require 'securerandom'

class User < Sequel::Model
  Sequel::Model.plugin :timestamps

  attr_reader :readable_token

  def before_create
    self.password = BCrypt::Password.create(self.password)
    generate_authentication_token
  end

  def self.sign_in credentials
    user = self.first(email: credentials.fetch("email", ""))
    return false unless user

    return false if BCrypt::Password.new(user.password) != credentials.fetch("password", "")

    user.generate_authentication_token
    user.save
    return user
  end

  def generate_authentication_token(user=false)
    self.authentication_token = SecureRandom.urlsafe_base64(nil,false)
    @readable_token = self.authentication_token
    self.authentication_token = BCrypt::Password.create(self.authentication_token)
    return
  end

end
