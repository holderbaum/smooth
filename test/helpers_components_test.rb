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

  context "no setup" do
    test "it should set the correct pathes" do
      path = File.expand_path('../../comp/', __FILE__)
      assert_equal [path], Smooth::Helpers::Components.pathes
    end
  end

  context "PATHES set by setup" do
    setup do
      new_pathes = []
      new_pathes << File.expand_path("../fixtures/components/path1", __FILE__)
      new_pathes << File.expand_path("../fixtures/components/path2", __FILE__)
      Smooth::Helpers::Components.pathes(new_pathes)
    end

    teardown do
      Smooth::Helpers::Components.reset_pathes!

      pathes = [File.expand_path('../../comp/', __FILE__)]
      assert_equal pathes, Smooth::Helpers::Components.pathes
    end

    test "it should render components from both pathes" do
      haml = <<-EOC.unindent
        -content :test1 do
          =component :comp1

        -content :test2 do
          =component :comp2
      EOC

      cs = content_store(haml)
      assert_equal "<div class='comp1'></div>\n", cs.content(:test1)
      assert_equal "<div class='comp2'></div>\n", cs.content(:test2)
    end

    test "it should throw an exception if no component was found" do
      haml = <<-EOC.unindent
        -content :test do
          =component :no_component
      EOC

      e = assert_raise(RuntimeError, "aa") do
        cs = content_store(haml)
      end

      assert_equal "Component 'no_component' not found.", e.message
    end

    test "it should render an optional block" do
      haml = <<-EOC.unindent
        -content :test do
          =component :with_block do
            .content
      EOC

      result = <<-EOC.unindent
        <div class='with_block'>
          <div class='content'></div>
        </div>
      EOC

      cs = content_store(haml)
      assert_equal result, cs.content(:test)
    end

    test "it should instantiate the given arguments" do
      haml = <<-EOC.unindent
        -content :test do
          =component :with_block_and_arg, :arg => 'value' do
            .content= "my content"
      EOC

      result = <<-EOC.unindent
        <div class='with_block_and_arg'>
          value
          <div class='content'>my content</div>
        </div>
      EOC

      cs = content_store(haml)
      assert_equal result, cs.content(:test)
    end

    test "it should render component without block" do
      haml = <<-EOC.unindent
        -content :test do
          =component :with_block
      EOC

      result = <<-EOC.unindent
        <div class='with_block'>
          
        </div>
      EOC

      cs = content_store(haml)
      assert_equal result, cs.content(:test)
    end

    test "it should render component without block and argument" do
      haml = <<-EOC.unindent
        -content :test do
          =component :with_block_and_arg, :arg => "something"
      EOC

      result = <<-EOC.unindent
        <div class='with_block_and_arg'>
          something
          
        </div>
      EOC

      cs = content_store(haml)
      assert_equal result, cs.content(:test)
    end

    test "it should be nestable" do
      haml = <<-EOC.unindent
        -content :test do
          =component :with_block do
            .content
            =component :with_block do
              .nested
      EOC

      result = <<-EOC.unindent
        <div class='with_block'>
          <div class='content'></div>
          <div class='with_block'>
            <div class='nested'></div>
          </div>
        </div>
      EOC

      cs = content_store(haml)
      assert_equal result, cs.content(:test)
    end

    context "component_resolver" do
      test "it should map *args to a component call" do
        haml = <<-EOC.unindent
          - content :test do 
            =component_resolver :with_block_and_arg_and_title, "my title", :arg => "argument", :arg2 => "bla" do
              .inner
        EOC

        result = <<-EOC.unindent
          <div class='with_block_and_arg_and_title'>
            my title
            argument
            <div class='inner'></div>
          </div>
        EOC

        cs = content_store(haml)
        assert_equal result, cs.content(:test)
      end

      test "it should map *args without argument hashto a component call" do
        haml = <<-EOC.unindent
          - content :test do 
            =component_resolver :with_block_and_title, "my title" do
              .inner
        EOC

        result = <<-EOC.unindent
          <div class='with_block_and_title'>
            my title
            <div class='inner'></div>
          </div>
        EOC

        cs = content_store(haml)
        assert_equal result, cs.content(:test)
      end

      test "it should map *args without argument hash and title to a component call" do
        haml = <<-EOC.unindent
          - content :test do 
            =component_resolver :with_block_and_title do
              .inner
        EOC

        result = <<-EOC.unindent
          <div class='with_block_and_title'>
            
            <div class='inner'></div>
          </div>
        EOC

        cs = content_store(haml)
        assert_equal result, cs.content(:test)
      end

      test "it should map *args without title to a component call" do
        haml = <<-EOC.unindent
          - content :test do 
            =component_resolver :with_block_and_arg_and_title, :arg => "argument", :arg2 => "bla" do
              .inner
        EOC

        result = <<-EOC.unindent
          <div class='with_block_and_arg_and_title'>
            
            argument
            <div class='inner'></div>
          </div>
        EOC

        cs = content_store(haml)
        assert_equal result, cs.content(:test)
      end

    end
  end
end
