require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "Api::App::PostsHelper" do
  before do
    @helpers = Class.new
    @helpers.extend Api::App::PostsHelper
  end

  def helpers
    @helpers
  end
end
