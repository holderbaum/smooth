require 'helper'

class SmoothHelpersContentStoreTest < Test::Unit::TestCase

  def renderer_context(haml)
    renderer(haml, :helpers => Smooth::Helpers::ContentStore).tap(&:result).context
  end

  def renderer_result(haml)
    renderer(haml, :helpers => Smooth::Helpers::ContentStore).result
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

    test "it should concatenate on multiple calls" do
      haml = <<-EOC.unindent
        -content :test do
          .something
        -content :test do
          .other
        -content :test, "a string"
      EOC

      result = <<-EOC.unindent
        <div class='something'></div>
        <div class='other'></div>
        a string
      EOC

      r = renderer_context(haml)

      assert_equal result, r.content(:test)

    end

    test "a never touched store should render an empty string" do
      assert_equal "", renderer_result("- content :something")
    end
  end

end
