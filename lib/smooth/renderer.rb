module Smooth
  class Renderer

    attr_writer :layout

    def initialize(template)
      @template = template
    end

    def render!
      context = Context.new
      result = Haml::Engine.new(@template).render(context)
      result = Haml::Engine.new(@layout).render(context) if @layout
      result
    end

    def result
      @result ||= render!
    end

    class Context
      
    end
  end
end
