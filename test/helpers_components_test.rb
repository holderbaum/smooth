require 'test/helper'
require 'lib/smooth'

class SmoothHelpersComponentsTest < Test::Unit::TestCase
  include Smooth::Helpers

  def content_store(haml)
    ContentStore.register_helpers Smooth::Helpers::Components
    cs = ContentStore.new(haml)
    cs.render!
    cs
  end

  test "it should render components from both pathes" do
    Smooth::Helpers::Components::PATH = []
    Smooth::Helpers::Components::PATH << File.expand_path("../fixtures/components/path1", __FILE__)
    Smooth::Helpers::Components::PATH << File.expand_path("../fixtures/components/path2", __FILE__)

    haml = <<-EOC
-content :test1 do
  =component :comp1

-content :test2 do
  =component :comp2
    EOC

    cs = content_store(haml)
    assert_equal "<div class='comp1'></div>\n", cs.content(:test1)
    assert_equal "<div class='comp2'></div>\n", cs.content(:test2)
  end

  test "it should throw an exception of no component was found" do
    Smooth::Helpers::Components::PATH = []
    Smooth::Helpers::Components::PATH << File.expand_path("../fixtures/components/path1", __FILE__)

    haml = <<-EOC
-content :test do
  =component :no_component
    EOC

    e = assert_raise(RuntimeError, "aa") do
      cs = content_store(haml)
    end

    assert_equal "Component not found.", e.message
  end

  test "it should render an optional block" do
    Smooth::Helpers::Components::PATH = []
    Smooth::Helpers::Components::PATH << File.expand_path("../fixtures/components/path1", __FILE__)

    haml = <<-EOC
-content :test do
  =component :with_block do
    .content
    EOC

    result = <<-EOC
<div class='with_block'>
  <div class='content'></div>
</div>
    EOC

    cs = content_store(haml)
    assert_equal result, cs.content(:test)
  end

end
