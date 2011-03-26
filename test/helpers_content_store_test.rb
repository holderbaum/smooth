require 'test/helper'
require 'lib/smooth'

class SmoothHelpersContentStoreTest < Test::Unit::TestCase
  include Smooth::Helpers

  context "rendering" do
    test "it should render a haml file into content_stores" do
      haml = <<-EOC.unindent
        -content :about do
          .something
        .this_is_ignored
        -content :slides do
          .other
      EOC
      cs = ContentStore.new(haml)
      cs.render!

      assert_equal "<div class='something'></div>\n", cs.context.content(:about)
      assert_equal "<div class='other'></div>\n", cs.context.content(:slides)
    end

    test "content should also accept a html string" do
      haml = <<-EOC.unindent
        -content :string, "the content"
      EOC
      cs = ContentStore.new(haml)
      cs.render!

      assert_equal "the content\n", cs.context.content(:string)
    end
  end

  context "plugins" do
    test "it should be extendable with helpers" do
      module ExampleHelperModule
        def weird_method_name
          "return"
        end
      end

      ContentStore.register_helpers(ExampleHelperModule)
      cs = ContentStore.new("")

      assert_equal "return", cs.context.weird_method_name
    end
  end

  context "method missing" do
    setup do
      new_pathes = []
      new_pathes << File.expand_path("../fixtures/components/path1", __FILE__)
      new_pathes << File.expand_path("../fixtures/components/path2", __FILE__)

      Smooth::Helpers::Components.clear_pathes!
      Smooth::Helpers::Components.unshift_pathes new_pathes[0]
      Smooth::Helpers::Components.unshift_pathes new_pathes[1]
    end

    teardown do
      Smooth::Helpers::Components.reset_pathes!
    end

    test "it should wrap component_resolver with method_missing" do
      haml = <<-EOC.unindent
        -content :test1 do
          =missing "the title" do
            .stuff
      EOC

      result = <<-EOC.unindent
        <div class='missing'>
          the title
          <div class='stuff'></div>
        </div>
      EOC

      ContentStore.register_helpers( Smooth::Helpers::Components )
      cs = ContentStore.new(haml)
      cs.render!
      assert_equal result, cs.context.content(:test1)
    end
  end
end
