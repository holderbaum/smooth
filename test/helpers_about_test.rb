require 'test/helper'
require 'lib/smooth'

class SmoothHelpersAboutTest < Test::Unit::TestCase
  include Smooth::Helpers

  def renderer_context(haml)
    r = renderer(haml, nil, Smooth::Helpers::About)
    r.result
    r.context
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

    assert_equal result, renderer_context(haml).about
  end

  test "about attributes should be accessible" do
    haml = <<-EOC.unindent
      -about do
        -title    "the title"
    EOC

    assert_equal "the title", renderer_context(haml).about(:title)
  end
end
