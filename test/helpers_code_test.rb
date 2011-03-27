require 'test/helper'
require 'lib/smooth'

class SmoothHelpersStyleTest < Test::Unit::TestCase

  def renderer_result(haml)
    r = renderer(haml, nil, Smooth::Config.new, [Smooth::Helpers::Assets, Smooth::Helpers::ContentStore, Smooth::Helpers::Code])
    r.result
  end

  def renderer_context(haml)
    r = renderer(haml, nil, Smooth::Config.new, [Smooth::Helpers::Assets, Smooth::Helpers::ContentStore, Smooth::Helpers::Code])
    r.result
    r.context
  end

  test "it should parse the code and create html" do
    clear_test_dir
    in_test_dir do
      # ruby code with amy theme
      haml = <<-EOC.unindent
        =code :ruby, :amy do
          :plain
            class Ruby
            end
      EOC

      result = <<-EOC.unindent
        <pre class=\"amy\"><span class=\"line-numbers\">   1 </span> <span class=\"ControlKeyword\">class</span> <span class=\"ClassName\">Ruby</span>
        <span class=\"line-numbers\">   2 </span> <span class=\"ControlKeyword\">end</span>
        </pre>
      EOC

      assert_equal result, renderer_result(haml)
    end
  end

  test "it should copy the necessary stylesheets" do
    clear_test_dir
    in_test_dir do
      haml = <<-EOC.unindent
        =code :ruby, :amy do
          :plain
            class Ruby
            end
      EOC

      assert_equal "<link href='style/uv/amy.css' rel='stylesheet' type='text/css' />\n\n", renderer_context(haml).content(:head)
      assert File.exist?('style/uv/amy.css')
    end
  end

end
