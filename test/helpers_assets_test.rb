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
      assert_equal path, Smooth::Helpers::Assets.base_path
    end
  end

  context "PATH set by setup" do
    setup do
      Smooth::Helpers::Assets.base_path File.expand_path("../fixtures/assets", __FILE__)
    end

    teardown do
      Smooth::Helpers::Assets.reset_base_path!

      path = File.expand_path('../../assets', __FILE__)
      assert_equal path, Smooth::Helpers::Assets.base_path

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
              -copy_asset 'style/example.css'

            -content :test2 do
              -copy_asset 'style/subdir/example.css'
          EOC

          cs = content_store(haml)
          assert File.exist?('style/example.css'), 'style/example.css'
          assert File.exist?('style/subdir/example.css'), 'style/subdir/example.css'
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

    context "css_include" do
      test "it should include the css files" do
        clear_test_dir
        in_test_dir do
          haml = <<-EOC.unindent
            -content :test1 do
              -css_include :example

            -content :test2 do
              -css_include :subdir, :example
          EOC

          test1 = <<-EOC.unindent
            <link href='style/example.css' rel='stylesheet' type='text/css' />
          EOC

          test2 = <<-EOC.unindent
            <link href='style/subdir/example.css' rel='stylesheet' type='text/css' />
          EOC

          cs = content_store(haml)
          assert_equal test1, cs.content(:test1)
          assert_equal test2, cs.content(:test2)
        end
      end

    end
  end

end
