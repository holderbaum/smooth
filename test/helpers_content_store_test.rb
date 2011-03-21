require 'test/helper'
require 'lib/smooth'

class SmoothHelpersContentStoreTest < Test::Unit::TestCase
  include Smooth::Helpers

  context "rendering" do
    test "it should render a haml file into content_stores" do
      haml = <<-EOC
-content :about do
  .something
.this_is_ignored
-content :slides do
  .other
      EOC
      cs = ContentStore.new(haml)
      cs.render!

      assert_equal "<div class='something'></div>\n", cs.content(:about)
      assert_equal "<div class='other'></div>\n", cs.content(:slides)
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

      assert_equal "return", cs.instance_variable_get('@context').weird_method_name
    end
  end
end
