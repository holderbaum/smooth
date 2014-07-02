require 'helper'

class SmoothHelpersLayoutTest < Test::Unit::TestCase

  CONFIG = Smooth::Config.new
  CONFIG.layouts_pathes.prepend File.expand_path("../fixtures/layouts/path1", __FILE__)
  CONFIG.layouts_pathes.prepend File.expand_path("../fixtures/layouts/path2", __FILE__)

  def renderer_result(haml, layout=nil)
    renderer(haml, :config => CONFIG, :helpers => Smooth::Helpers::Layout, :layout => layout).result
  end

  test "it should be possible to set raw haml content as layout" do
    template = <<-EOC.unindent
      -set_layout_haml_content ".layout= @inner"
      -@inner = "foo"
    EOC

    result = <<-EOC.unindent
      <div class='layout'>foo</div>
    EOC

    assert_equal result, renderer_result(template)
  end

  test "it should use the layout from layouts pathes" do
    templates = []
    templates << <<-EOC.unindent
      -layout :test1
      -@inner = "foo"
    EOC

    templates << <<-EOC.unindent
      -layout :test2
      -@inner = "foo"
    EOC

    results = []
    results << <<-EOC.unindent
      <div class='test-1'>
        <div class='layout'>
          foo
        </div>
      </div>
    EOC

    results << <<-EOC.unindent
      <div class='test-2'>
        <div class='layout'>
          foo
        </div>
      </div>
    EOC

    assert_equal results[0], renderer_result(templates[0])
    assert_equal results[1], renderer_result(templates[1])
  end

  test "it should accept strings with and without .haml" do
    templates = []
    templates << <<-EOC.unindent
      -layout "test1"
      -@inner = "foo"
    EOC

    templates << <<-EOC.unindent
      -layout "test2.haml"
      -@inner = "foo"
    EOC

    results = []
    results << <<-EOC.unindent
      <div class='test-1'>
        <div class='layout'>
          foo
        </div>
      </div>
    EOC

    results << <<-EOC.unindent
      <div class='test-2'>
        <div class='layout'>
          foo
        </div>
      </div>
    EOC

    assert_equal results[0], renderer_result(templates[0])
    assert_equal results[1], renderer_result(templates[1])
  end

  test "it should raise if no layout is found" do
    template = <<-EOC.unindent
      -layout "this_layout_wont_be_found"
    EOC
    
    e = assert_raise RuntimeError do
      renderer_result(template)
    end

    assert_equal "Layout 'this_layout_wont_be_found.haml' not found.", e.message
  end

  test "it should not override the renderer layout" do
    template = <<-EOC.unindent
      -layout :test1
      -@inner = "foo"
    EOC

    result = <<-EOC.unindent
      <div class='layout'>foo</div>
    EOC

    assert_equal result, renderer_result(template, ".layout= @inner")
  end
end
