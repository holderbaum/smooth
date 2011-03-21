module Smooth
  module Helpers
    class ContentStore

      class RenderContext
        def initialize
          @content = {}
        end

        def content(title, &block)
          @content[title] = capture_haml(&block) if block_given?
          @content[title]
        end
      end

      def self.register_helpers(mod)
        RenderContext.send :include, mod
      end

      def initialize(layout)
        @content = {}
        @context = RenderContext.new
        @layout = layout 
      end
      
      def render!
        Haml::Engine.new(@layout).render(@context)
      end

      def content(title)
        @context.content(title)
      end

    end
  end
end
