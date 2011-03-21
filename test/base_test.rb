require 'test/helper'
require 'lib/smooth/base'

class SmoothBaseTest < Test::Unit::TestCase
  include Smooth

  context "Layout" do
    test "it should render everything in the layout" do
      layout = <<-EOC
.html
  .body
    =slides
      EOC
      result = <<-EOC
<html>
  <body>
    <div class="slides">
      <p>stuff</p>
    </div>
  </body>
</html>
      EOC

      smooth = Base.new(layout)
      assert_equal result, smooth.render(".p stuff")
    end
  end

end
