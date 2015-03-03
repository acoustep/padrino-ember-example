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

  def self.authenticate(environment, parser=AuthorizationStringParser)
    credentials = parser.new(environment).parsed_string
    return false if credentials.nil?

    user = self.where(email: credentials.fetch("email", "")).first

    return false unless user

    return BCrypt::Password.new(user[:authentication_token]) == credentials.fetch("authentication_token", "")
  end

end

class AuthorizationStringParser
  attr_accessor :parsed_string, :environment
  def initialize(environment)
    @environment = environment
  end

  def parsed_string
    parsed_string ||= parse_string
  end

  protected

  def parse_string
    raw_param_string = environment.fetch("HTTP_AUTHORIZATION", "")
    raw_param_string.gsub(/Token\s|"|,/, "").split(' ').map { |key_value| key_value.split(%r/=(.+)?/) }.to_h
  end
end
