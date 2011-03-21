require 'test/helper'
require 'lib/smooth'

class SmoothBaseTest < Test::Unit::TestCase
  include Smooth

  context "Layout" do
    test "it should render everything in the layout" do
      layout = <<-EOC
%html
  %body
    =content :placeholder
      EOC
      result = <<-EOC
<html>
  <body>
    <p>stuff</p>
  </body>
</html>
      EOC

      content = <<-EOC
- content :placeholder do
  %p stuff
      EOC

      smooth = Base.new(layout)
      assert_equal result, smooth.render(content)
    end
  end

end
