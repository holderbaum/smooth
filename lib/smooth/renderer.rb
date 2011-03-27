module Smooth
  class Renderer

    attr_accessor :layout
    attr_reader :context

    def initialize(template, config = Config.new)
      @template = template
      @layout = nil
      @context = Context.new(self, config)
    end

    def render!
      result = Haml::Engine.new(@template).render(@context)
      result = Haml::Engine.new(@layout).render(@context) if @layout
      result
    end

    def result
      @result ||= render!
    end

    def register_helpers(mod)
      @context.register_helpers mod
    end

    class Context

      attr_reader :config

      def initialize(renderer, config)
        @renderer = renderer
        @config = config
      end

      def singleton_class
        class << self; self; end
      end

      def register_helpers(mod)
        singleton_class.class_eval do
          include mod
        end
      end
    end
  end
end
