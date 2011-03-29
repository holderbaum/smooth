module Smooth
  # The Renderer is the base of Smooth. 
  # It renders the written template in a internally instanciated context. 
  # This context can be extended by helper modules through @register_helpers@
  #
  # *Note:*
  #
  # Basically, the context equals self in your template.
  #
  # *Usage:*
  #
  # <pre>
  # <code>
  # smooth = Renderer.new("%p my haml template string")
  #
  # smooth.register_helpers Smooth::Helpers::About
  # smooth.layout "= yield" # an optional layout (should be defined by the template)
  #
  # smooth.result #=> "<p>my haml template string</p>\n"
  # </code>
  # </pre>
  class Renderer

    # Returns the layout haml string
    attr_accessor :layout
    # Returns the context that has been used to render the template
    attr_reader :context

    def initialize(template, config = Config.new)
      @template = template
      @layout = nil
      @context = Context.new(self, config)
    end

    # Calls the render! method implicit (only once!) and returns the generated HTML 
    def result
      @result ||= render!
    end

    # Patches all methods definde in the given module into the renderer context
    def register_helpers(mod)
      @context.register_helpers mod
    end

    private
    def render!
      result = Haml::Engine.new(@template).render(@context)
      result = Haml::Engine.new(@layout).render(@context) if @layout
      result
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
