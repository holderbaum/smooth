require 'helper'

class SmoothHelpersSlidesTest < Test::Unit::TestCase

  def renderer_context(haml)
    renderer(haml, :helpers => [Smooth::Helpers::ContentStore, Smooth::Helpers::Components, Smooth::Helpers::Slides]).tap(&:result).context
  end


  test "it should provide a slides helper" do
    haml = <<-EOC.unindent
      -slides do
        .something
    EOC

    result = <<-EOC.unindent
      <div class='something'></div>

    EOC

    r = renderer_context(haml)
    assert_equal result, r.content(:slides)
  end

  test "the slides helper should also be used in the layout" do
    haml = <<-EOC.unindent
      -slides do
        .something
    EOC

    result = <<-EOC.unindent
      <div class='something'></div>

    EOC

    r = renderer_context(haml)
    assert_equal result, r.slides
  end
end
