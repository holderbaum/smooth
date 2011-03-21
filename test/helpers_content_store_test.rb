require 'test/helper'
require 'lib/smooth'

class SmoothHelpersContentStoreTest < Test::Unit::TestCase
  include Smooth::Helpers

  test "it should render a haml file into content_stores" do
    haml = <<-EOC
-content :about do
  .something
.this_is_ignored
-content :slides do
  .other
    EOC
    cs = ContentStore.new(haml)

    assert_equal "<div class='something'></div>\n", cs.content(:about)
    assert_equal "<div class='other'></div>\n", cs.content(:slides)
  end
end
