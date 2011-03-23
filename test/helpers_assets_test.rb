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

    context "js_include" do
      
      test "it should include the js files" do
        in_test_dir do
          haml = <<-EOC.unindent
            -content :test1 do
              -js_include :example

            -content :test2 do
              -js_include :subdir, :example
          EOC

          test1 = <<-EOC.unindent
            <script src='js/example.js'></script>
          EOC

          test2 = <<-EOC.unindent
            <script src='js/subdir/example.js'></script>
          EOC

          cs = content_store(haml)
          assert_equal test1, cs.content(:test1)
          assert_equal test2, cs.content(:test2)
        end
      end

      test "it should include the js files" do
        in_test_dir do
          haml = <<-EOC.unindent
            -content :test1 do
              -js_include :example

            -content :test2 do
              -js_include :subdir, :example
          EOC

          cs = content_store(haml)
        end
      end

    end
  end

end
