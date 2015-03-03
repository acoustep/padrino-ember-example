require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "User Model" do
  before do
    @user = User.create({
      email: "admin@admin.co.uk",
      password: "testpassword",
    })
  end

  it 'can construct a new instance' do
    user = User.new
    refute_nil user
  end

  describe "when signing in" do
    it 'generates an authentication_token when created' do
      refute_nil @user, "authentication_token"
      refute_nil @user, "readable_token"
    end

    it 'generates a new authentication_token' do
      params = { "email" => "admin@admin.co.uk", "password" => "testpassword"}
      user = User.sign_in params

      readable_token = user.readable_token
      authentication_token = user.authentication_token

      user = User.sign_in params

      refute_equal readable_token, user.readable_token
      refute_equal authentication_token, user.authentication_token
    end
    
    it 'returns false with invalid credentials' do
      params = { "email" => "admin@admin.co.uk", "password" => "badpassword"}
      user = User.sign_in params

      assert_equal false, user
    end

    it "returns false when credentials aren't set" do
      params = { }
      user = User.sign_in params

      assert_equal false, user
    end
  end

  describe "when authenticating credentials" do
    it "returns true when valid" do
      params = { "email" => "admin@admin.co.uk", "password" => "testpassword"}
      user = User.sign_in params

      authenticated = User.authenticate({"HTTP_AUTHORIZATION" => "Token authentication_token=\"#{user.readable_token}\", email=\"#{user.email}\""})
      assert_equal true, authenticated
    end

    it "returns false when invalid" do
      params = { "email" => "admin@admin.co.uk", "password" => "testpassword"}
      user = User.sign_in params

      User.sign_in params

      authenticated = User.authenticate({"HTTP_AUTHORIZATION" => "Token authentication_token=\"#{user.readable_token}\", email=\"#{user.email}\""})
      assert_equal false, authenticated
    end

    it "returns false if no header is sent" do
      params = { "email" => "admin@admin.co.uk", "password" => "testpassword"}
      user = User.sign_in params

      User.sign_in params

      authenticated = User.authenticate({})
      assert_equal false, authenticated
    end
  end
end
