module Smooth
  module Helpers
    class ContentStore

      class RenderContext
        def initialize
          @content = {}
        end

        def content(title, string=nil, &block)
          if string
            @content[title] = "#{string}\n"
          elsif block_given?
            @content[title] = capture_haml(&block) if block_given?
          else
            @content[title]
          end
        end
      end

      def self.register_helpers(mod)
        RenderContext.send :include, mod
      end

      attr_reader :context

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
