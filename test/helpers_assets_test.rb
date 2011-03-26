require 'test/helper'
require 'lib/smooth'

class SmoothHelpersAssetsTest < Test::Unit::TestCase

  def renderer_result(haml)
    r = renderer(haml, nil, Smooth::Helpers::Assets)
    r.result
  end

  context "PATH set by setup" do
    setup do
      path = File.expand_path('../../assets', __FILE__)
      assert_equal path, Smooth::Helpers::Assets.base_path

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
          =convert_path_array_to_path('js', [:my, :file])
        EOC

        r = renderer_result(haml)
        assert_equal "js/my/file.js\n", r
      end

      test "expand path with explicit file_type" do
        haml = <<-EOC.unindent
          =convert_path_array_to_path('style', [:my, :file], 'css')
        EOC

        r = renderer_result(haml)
        assert_equal "style/my/file.css\n", r
      end

      test "don't apply file_type twice" do
        haml = <<-EOC.unindent
          =convert_path_array_to_path('js', [:my, 'file.js'])
        EOC

        r = renderer_result(haml)
        assert_equal "js/my/file.js\n", r
      end

    end

    context "copy_asset" do

      test "it should copy the asset file" do
        clear_test_dir
        in_test_dir do
          haml = <<-EOC.unindent
            -copy_asset 'js/example.js'
            -copy_asset 'js/subdir/example.js'
          EOC

          r = renderer_result(haml)
          assert File.exist?('js/example.js'), 'js/example.js'
          assert File.exist?('js/subdir/example.js'), 'js/subdir/example.js'
        end
      end

      test "it should not fail if the asset dirs exist" do
        clear_test_dir
        in_test_dir do
          FileUtils.mkdir_p 'css/subdir'

          haml = <<-EOC.unindent
            -copy_asset 'style/example.css'
            -copy_asset 'style/subdir/example.css'
          EOC

          r = renderer_result(haml)
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
            -copy_asset 'js/example.js'
          EOC

          r = renderer_result(haml)
          
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
            -js_include :example
            -js_include :subdir, :example
          EOC

          test = <<-EOC.unindent
            <script src='js/example.js'></script>
            <script src='js/subdir/example.js'></script>
          EOC

          r = renderer_result(haml)
          assert_equal test, r
        end
      end

    end

    context "css_include" do
      test "it should include the css files" do
        clear_test_dir
        in_test_dir do
          haml = <<-EOC.unindent
            -css_include :example
            -css_include :subdir, :example
          EOC

          test = <<-EOC.unindent
            <link href='style/example.css' rel='stylesheet' type='text/css' />
            <link href='style/subdir/example.css' rel='stylesheet' type='text/css' />
          EOC

          r = renderer_result(haml)
          assert_equal test, r
        end
      end

    end
  end

end
