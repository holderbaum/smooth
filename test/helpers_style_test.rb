require 'helper'

class SmoothHelpersStyleTest < Test::Unit::TestCase

  def renderer_context(haml)
    r = renderer(haml, nil, Smooth::Config.new, [Smooth::Helpers::ContentStore, Smooth::Helpers::Style])
    r.result
    r.context
  end

  test "it should provide a collecting style helper" do
    haml = <<-EOC.unindent
      -style :style1 do
        my css
      -style :style2 do
        my css2
    EOC

    result = <<-EOC.unindent
      /* style1 */
      my css

      /* style2 */
      my css2
    EOC

    assert_equal result, renderer_context(haml).styles
  end

  test "it should not concatenate nor overwrite keys even with key string" do
    haml = <<-EOC.unindent
      -style :style1 do
        my css
      -style "style1" do
        my css2
    EOC

    result = <<-EOC.unindent
      /* style1 */
      my css
    EOC

    assert_equal result, renderer_context(haml).styles
  end
end
