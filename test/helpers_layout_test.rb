require 'test/helper'
require 'lib/smooth'

class SmoothHelpersLayoutTest < Test::Unit::TestCase

  CONFIG = Smooth::Config.new
  CONFIG.layouts_pathes.prepend File.expand_path("../fixtures/layouts", __FILE__)

  def renderer(haml)
    r = super(haml, nil, CONFIG, Smooth::Helpers::Layout)
    r.result
  end

  test "it should set meta attributes" do
    template = <<-EOC.unindent
      -set_layout_haml_content ".layout= @inner"
      -@inner = "foo"
    EOC

    result = <<-EOC.unindent
      <div class='layout'>foo</div>
    EOC

    assert_equal result, renderer(template)
  end
end
