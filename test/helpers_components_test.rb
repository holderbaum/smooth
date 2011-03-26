require 'test/helper'
require 'lib/smooth'

class SmoothHelpersComponentsTest < Test::Unit::TestCase
  include Smooth::Helpers

  def renderer_result(haml)
    renderer(haml, nil, Smooth::Helpers::Components).result
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

      Smooth::Helpers::Components.clear_pathes!
      Smooth::Helpers::Components.unshift_pathes new_pathes[0]
      Smooth::Helpers::Components.unshift_pathes new_pathes[1]

      assert_equal [new_pathes[1], new_pathes[0]], Smooth::Helpers::Components.pathes
    end

    teardown do
      Smooth::Helpers::Components.reset_pathes!

      pathes = [File.expand_path('../../comp/', __FILE__)]
      assert_equal pathes, Smooth::Helpers::Components.pathes
    end

    test "it should render components from both pathes" do
      haml = <<-EOC.unindent
        =component :comp1
        =component :comp2
      EOC

      result = <<-EOC.unindent
        <div class='comp1'></div>
        <div class='comp2'></div>
      EOC

      r = renderer_result(haml)
      assert_equal result, r
    end

    test "it should throw an exception if no component was found" do
      haml = <<-EOC.unindent
        =component :no_component
      EOC

      e = assert_raise(RuntimeError, "aa") do
        renderer_result(haml)
      end

      assert_equal "Component 'no_component' not found.", e.message
    end

    test "it should render an optional block" do
      haml = <<-EOC.unindent
        =component :with_block do
          .content
      EOC

      result = <<-EOC.unindent
        <div class='with_block'>
          <div class='content'></div>
        </div>
      EOC

      r = renderer_result(haml)
      assert_equal result, r
    end

    test "it should instantiate the given arguments" do
      haml = <<-EOC.unindent
        =component :with_block_and_arg, :arg => 'value' do
          .content= "my content"
      EOC

      result = <<-EOC.unindent
        <div class='with_block_and_arg'>
          value
          <div class='content'>my content</div>
        </div>
      EOC

      r = renderer_result(haml)
      assert_equal result, r
    end

    test "it should render component without block" do
      haml = <<-EOC.unindent
        =component :with_block
      EOC

      result = <<-EOC.unindent
        <div class='with_block'>
          
        </div>
      EOC

      r = renderer_result(haml)
      assert_equal result, r
    end

    test "it should render component without block and argument" do
      haml = <<-EOC.unindent
        =component :with_block_and_arg, :arg => "something"
      EOC

      result = <<-EOC.unindent
        <div class='with_block_and_arg'>
          something
          
        </div>
      EOC

      r = renderer_result(haml)
      assert_equal result, r
    end

    test "it should be nestable" do
      haml = <<-EOC.unindent
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

      r = renderer_result(haml)
      assert_equal result, r
    end

    context "component_resolver" do
      test "it should map *args to a component call" do
        haml = <<-EOC.unindent
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

        r = renderer_result(haml)
        assert_equal result, r
      end

      test "it should map *args without argument hashto a component call" do
        haml = <<-EOC.unindent
          =component_resolver :with_block_and_title, "my title" do
            .inner
        EOC

        result = <<-EOC.unindent
          <div class='with_block_and_title'>
            my title
            <div class='inner'></div>
          </div>
        EOC

        r = renderer_result(haml)
        assert_equal result, r
      end

      test "it should map *args without argument hash and title to a component call" do
        haml = <<-EOC.unindent
          =component_resolver :with_block_and_title do
            .inner
        EOC

        result = <<-EOC.unindent
          <div class='with_block_and_title'>
            
            <div class='inner'></div>
          </div>
        EOC

        r = renderer_result(haml)
        assert_equal result, r
      end

      test "it should map *args without title to a component call" do
        haml = <<-EOC.unindent
          =component_resolver :with_block_and_arg_and_title, :arg => "argument", :arg2 => "bla" do
            .inner
        EOC

        result = <<-EOC.unindent
          <div class='with_block_and_arg_and_title'>
            
            argument
            <div class='inner'></div>
          </div>
        EOC

        r = renderer_result(haml)
        assert_equal result, r
      end

    end
  end
end
