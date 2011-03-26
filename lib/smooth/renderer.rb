module Smooth
  class Renderer

    def initialize(template)
      @template = template
    end

    def render
      Haml::Engine.new(@template).render
    end

  end
end
