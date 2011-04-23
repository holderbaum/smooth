require 'helper'

class SmoothHelpersAssetsTest < Test::Unit::TestCase

  CONFIG = Smooth::Config.new
  CONFIG.assets_path.set File.expand_path('../fixtures/assets', __FILE__)

  def renderer_result(haml)
    r = renderer(haml, nil, CONFIG, Smooth::Helpers::Assets)
    r.result
  end

  teardown do
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

    test "it should also copy an entire dir recursively" do
      clear_test_dir
      in_test_dir do
        haml = <<-EOC.unindent
            -copy_asset 'dir'
        EOC

        r = renderer_result(haml)
        assert File.exist?('dir/file1'), 'dir/file1'
        assert File.exist?('dir/subdir/fileX'), 'dir/subdir/fileX'
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
            =js_path :example
            =js_path :subdir, :example
        EOC

        test = <<-EOC.unindent
            js/example.js
            js/subdir/example.js
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
            =css_path :example
            =css_path :subdir, :example
        EOC

        test = <<-EOC.unindent
            style/example.css
            style/subdir/example.css
        EOC

        r = renderer_result(haml)
        assert_equal test, r
      end
    end

  end

  context "img_include" do
    test "it should create the img tag" do
      clear_test_dir
      in_test_dir do
        haml = <<-EOC.unindent
            =img_path 'example.jpg'
            =img_path 'example'
            =img_path :subdir, 'example.png'
        EOC

        test = <<-EOC.unindent
            img/example.jpg
            img/example.jpg
            img/subdir/example.png
        EOC

        assert_equal test, renderer_result(haml)
      end
    end
  end

end
