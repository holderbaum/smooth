require 'test/helper'
require 'lib/smooth'

class SmoothHelpersComponentsTest < Test::Unit::TestCase
  include Smooth::Helpers

  def content_store(haml)
    ContentStore.register_helpers Smooth::Helpers::Assets
    cs = ContentStore.new(haml)
    cs.render!
    cs
  end

  context "no setup" do
    test "it should set the correct path" do
      path = File.expand_path('../../assets', __FILE__)
      assert_equal path, Smooth::Helpers::Assets::BASE_PATH
      assert_equal File.join(path, 'css'), Smooth::Helpers::Assets::CSS_PATH
    end
  end

  context "PATH set by setup" do
    setup do
      @old_base_path = Smooth::Helpers::Assets::BASE_PATH
      @old_css_path  = Smooth::Helpers::Assets::CSS_PATH
      Smooth::Helpers::Assets::BASE_PATH = File.expand_path("../fixtures/assets", __FILE__)
      Smooth::Helpers::Assets::CSS_PATH = File.join(Smooth::Helpers::Assets::BASE_PATH, 'css')
    end

    teardown do
      Smooth::Helpers::Assets::BASE_PATH = @old_base_path
      Smooth::Helpers::Assets::CSS_PATH = @old_css_path
    end

    context "css" do
      
      test "" do

      end

    end
  end

end
