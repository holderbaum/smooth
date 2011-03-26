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

        def method_missing(meth, *args, &block)
          component_resolver( *([meth, args].flatten), &block )
        end
      end

      def self.register_helpers(mod)
        RenderContext.send :include, mod
      end

      attr_reader :context

      def initialize(template)
        @content = {}
        @context = RenderContext.new
        @template = template 
      end
      
      def render!
        Haml::Engine.new(@template).render(@context)
      end

      def content(title)
        @context.content(title)
      end

    end
  end
end
