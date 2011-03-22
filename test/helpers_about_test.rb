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
    haml = <<-EOC.unindent
      -about do
        -title    "the title"
        -author   "the author"
        -company  "the company"
        -email    "the email"
        -date     "the date"
        -venue    "the venue"
    EOC

    result = {
      :title => "the title",
      :author => "the author",
      :company => "the company",
      :email => "the email",
      :date => "the date",
      :venue => "the venue"
    }

    cs = content_store(haml)
    assert_equal result, cs.context.about
  end

  test "about attributes should be accessible" do
    haml = <<-EOC.unindent
      -about do
        -title    "the title"
    EOC

    cs = content_store(haml)
    assert_equal "the title", cs.context.about(:title)
  end
end
