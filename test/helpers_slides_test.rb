require 'test/helper'
require 'lib/smooth'

class SmoothHelpersSlidesTest < Test::Unit::TestCase
  include Smooth::Helpers

  def content_store(haml)
    ContentStore.register_helpers Smooth::Helpers::Components
    ContentStore.register_helpers Smooth::Helpers::Slides
    cs = ContentStore.new(haml)
    cs.render!
    cs
  end

  test "it should provide a slides helper" do
    haml = <<-EOC.unindent
      -slides do
        .something
    EOC

    result = <<-EOC.unindent
      <div class='slides'>
        <div class='something'></div>
      </div>

    EOC

    cs = content_store(haml)
    assert_equal result, cs.context.content(:slides)
  end
end
