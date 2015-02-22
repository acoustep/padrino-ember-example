require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Api::App::UsersHelper" do
  before do
    @helpers = Class.new
    @helpers.extend Api::App::UsersHelper
  end

  def helpers
    @helpers
  end
end
