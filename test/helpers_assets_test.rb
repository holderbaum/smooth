require 'test/helper'
require 'lib/smooth'
require 'fileutils'

class SmoothHelpersComponentsTest < Test::Unit::TestCase
  include Smooth::Helpers

  def content_store(haml)
    ContentStore.register_helpers Smooth::Helpers::Assets
    cs = ContentStore.new(haml)
    cs.render!
    cs
  end

  TEST_DIR = File.expand_path('../fixtures/test_dir', __FILE__)

  def in_test_dir(&block)
    Dir.chdir(TEST_DIR, &block)
  end

  def clear_test_dir
    files = Dir.glob(File.join TEST_DIR, "*")
    FileUtils.rm_rf files
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
      clear_test_dir
    end

    context "convert_path_array_to_path" do

      test "expand path with implicit file_type" do
        haml = <<-EOC.unindent
          -content :test do
            =convert_path_array_to_path('js', [:my, :file])
        EOC

        cs = content_store(haml)

        assert_equal "js/my/file.js\n", cs.content(:test)
      end

      test "expand path with explicit file_type" do
        haml = <<-EOC.unindent
          -content :test do
            =convert_path_array_to_path('style', [:my, :file], 'css')
        EOC

        cs = content_store(haml)

        assert_equal "style/my/file.css\n", cs.content(:test)
      end

      test "don't apply file_type twice" do
        haml = <<-EOC.unindent
          -content :test do
            =convert_path_array_to_path('js', [:my, 'file.js'])
        EOC

        cs = content_store(haml)

        assert_equal "js/my/file.js\n", cs.content(:test)
      end

    end

    context "copy_asset" do

      test "it should copy the asset file" do
        clear_test_dir
        in_test_dir do
          haml = <<-EOC.unindent
            -content :test1 do
              -copy_asset 'js/example.js'

            -content :test2 do
              -copy_asset 'js/subdir/example.js'
          EOC

          cs = content_store(haml)
          assert File.exist?('js/example.js'), 'js/example.js'
          assert File.exist?('js/subdir/example.js'), 'js/subdir/example.js'
        end
      end

      test "it should not fail if the asset dirs exist" do
        clear_test_dir
        in_test_dir do
          FileUtils.mkdir_p 'css/subdir'

          haml = <<-EOC.unindent
            -content :test1 do
              -copy_asset 'css/example.css'

            -content :test2 do
              -copy_asset 'css/subdir/example.css'
          EOC

          cs = content_store(haml)
          assert File.exist?('css/example.css'), 'css/example.css'
          assert File.exist?('css/subdir/example.css'), 'css/subdir/example.css'
        end
      end

      test "it should not override asset files" do
        clear_test_dir
        in_test_dir do
          FileUtils.mkdir_p 'js/subdir'
          File.open('js/example.js', 'w') do |js|
            js << "foo"
          end

          haml = <<-EOC.unindent
            -content :test1 do
              -copy_asset 'js/example.js'
          EOC

          cs = content_store(haml)
          assert File.exist?('js/example.js'), 'js/example.js'
          assert_equal "foo", File.read('js/example.js')
        end
      end

    end
      
    context "js_include" do
      test "it should include the js files" do
        clear_test_dir
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

    end

  end

end
