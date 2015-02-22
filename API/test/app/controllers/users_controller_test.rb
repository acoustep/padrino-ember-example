require 'json'
require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "/users" do
  before do
    User.create({
      email: "admin@admin.co.uk",
      password: "testpassword",
    })
  end

  it "should authenticate valid credentials" do
    post "api/v1/users/sign_in", {"user" => {"email" => "admin@admin.co.uk", "password" => "testpassword"}}
    json_response = JSON.parse last_response.body
    assert_equal nil, json_response["message"]
    assert_equal "admin@admin.co.uk", json_response["email"]
    assert_includes json_response, "authentication_token"
    assert_equal 201, last_response.status
  end

  it "should authenticate valid credentials" do
    post "api/v1/users/sign_in", {"user" => {"email" => "admin@admin.co.uk", "password" => "wrongpassword"}}
    json_response = JSON.parse last_response.body
    refute_nil json_response["message"]
    refute_includes json_response, "email"
    assert_equal 401, last_response.status
  end
end
