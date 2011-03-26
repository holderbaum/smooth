require 'test/helper'
require 'lib/smooth'

class SmoothRendererTest < Test::Unit::TestCase
  include Smooth::Helpers

  context "rendering" do

    test "it should render a haml template" do
      template = <<-EOC.unindent
        .around
          %inner
      EOC

      html = <<-EOC.unindent
        <div class='around'>
          <inner></inner>
        </div>
      EOC

      r = Smooth::Renderer.new(template)
      assert_equal html, r.result
    end

  end

end
