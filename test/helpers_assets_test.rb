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

  def in_test_dir(&block)
    path = File.expand_path('../fixtures/test_dir', __FILE__)
    Dir.chdir(path, &block)
  end

  context "no setup" do
    test "it should set the correct path" do
      path = File.expand_path('../../assets', __FILE__)
      assert_equal path, Smooth::Helpers::Assets::BASE_PATH
      assert_equal File.join(path, 'js'), Smooth::Helpers::Assets::JS_PATH
    end
  end

  context "PATH set by setup" do
    setup do
      @old_base_path = Smooth::Helpers::Assets::BASE_PATH
      @old_js_path  = Smooth::Helpers::Assets::JS_PATH
      Smooth::Helpers::Assets::BASE_PATH = File.expand_path("../fixtures/assets", __FILE__)
      Smooth::Helpers::Assets::JS_PATH = File.join(Smooth::Helpers::Assets::BASE_PATH, 'js')
    end

    teardown do
      Smooth::Helpers::Assets::BASE_PATH = @old_base_path
      Smooth::Helpers::Assets::JS_PATH = @old_js_path
    end

    context "js" do
      
      test "it should copy the js file and include it" do
        in_test_dir do
          puts Dir.pwd
        end
        puts Dir.pwd
      end

    end
  end

end
