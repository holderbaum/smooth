require 'helper'

class SmoothHelpersAboutTest < Test::Unit::TestCase

  def renderer_context(haml)
    renderer(haml, :helpers => Smooth::Helpers::About).tap(&:result).context
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

  test "about attributes raise method_missing when called w/o arguments" do
    haml = <<-EOC.unindent
      -about do
        -title
    EOC

    assert_raise NameError do
      renderer_context(haml).about(:title)
    end
  end
end
