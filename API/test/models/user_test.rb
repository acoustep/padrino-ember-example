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

  it 'generates an authentication_token when created' do
    refute_nil @user, "authentication_token"
    refute_nil @user, "readable_token"
  end

  it 'generates a new authentication_token when signed in' do
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
