module Smooth
  class Renderer

    def initialize(template)
      @template = template
    end

    def render!
      Haml::Engine.new(@template).render
    end

    def result
      @result ||= render!
    end

  end
end
