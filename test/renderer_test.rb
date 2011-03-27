require 'test/helper'
require 'lib/smooth'

class SmoothRendererTest < Test::Unit::TestCase
  include Smooth::Helpers

  context "rendering" do

    test "it should render a haml template" do
      template = <<-EOC.unindent
        .around
          %inner
      EOC

      html = <<-EOC.unindent
        <div class='around'>
          <inner></inner>
        </div>
      EOC

      r = Smooth::Renderer.new(template)
      assert_equal html, r.result
    end

  end

  context "rendering with layout" do
    test "it should give the template context after rendering to the layout renderer" do
      template = <<-EOC.unindent
        .around
          - @inner = 42
      EOC

      layout = <<-EOC.unindent
        .layout
          = @inner
      EOC

      html = <<-EOC.unindent
        <div class='layout'>
          42
        </div>
      EOC

      r = Smooth::Renderer.new(template)
      r.layout = layout

      assert_equal html, r.result
    end
  end

  context "registering helpers to the context" do
    test "it should only be instance-wide" do
      template = <<-EOC.unindent
        .around
          =my_helper
      EOC

      html = <<-EOC.unindent
        <div class='around'>
          I'm in ur helperz
        </div>
      EOC

      module MyTestHelpers
        def my_helper
          "I'm in ur helperz"
        end
      end

      r = Smooth::Renderer.new(template)
      r.register_helpers MyTestHelpers
      assert_equal html, r.result

      assert_raise NameError do
        r = Smooth::Renderer.new(template)
        r.result
      end
    end
  end

  context "config" do
    test "it should create an implicit config object" do
      r = Smooth::Renderer.new("%template")

      assert r.context.config.is_a?(Smooth::Config)
    end

    test "it should accept an explicit config object" do
      c = Smooth::Config.new
      r = Smooth::Renderer.new("%template", c)

      assert_equal c, r.context.config
    end

  end

end
