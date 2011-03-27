require 'test/helper'
require 'lib/smooth'

class SmoothHelpersContentStoreTest < Test::Unit::TestCase

  def renderer_context(haml)
    r = renderer(haml, nil, Smooth::Config.new, Smooth::Helpers::ContentStore)
    r.result
    r.context
  end

  context "rendering" do
    test "it should render a haml file into the content hash" do
      haml = <<-EOC.unindent
        -content :about do
          .something
        .this_is_ignored
        -content :slides do
          .other
      EOC

      r = renderer_context(haml)

      assert_equal "<div class='something'></div>\n", r.content(:about)
      assert_equal "<div class='other'></div>\n", r.content(:slides)
    end

    test "content should also accept a html string" do
      haml = <<-EOC.unindent
        -content :string, "the content"
      EOC

      r = renderer_context(haml)

      assert_equal "the content\n", r.content(:string)
    end
  end

end
