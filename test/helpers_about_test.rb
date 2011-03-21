require 'test/helper'
require 'lib/smooth'

class SmoothHelpersAboutTest < Test::Unit::TestCase
  include Smooth::Helpers

  def content_store(haml)
    ContentStore.register_helpers Smooth::Helpers::About
    cs = ContentStore.new(haml)
    cs.render!
    cs
  end

  test "it should set meta attributes" do
    haml = <<-EOC
-about do
  -title    "the title"
  -author   "the author"
  -company  "the company"
  -email    "the email"
  -date     "the date"
  -venue    "the venue"
    EOC

    cs = content_store(haml)
    assert_equal "", cs.context.about.inspect
  end
end
