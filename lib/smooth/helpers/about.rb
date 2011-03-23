module Smooth
  module Helpers
    module About
      class Context

        def initialize(parent)
          @parent = parent
        end

        def eval(&block)
          instance_eval(&block)
        end

        def add_about_info(key, value)
          @parent.about[key] = value
        end

        def method_missing(meth, *args, &block)
          if args.size > 0
            add_about_info meth, args.first
          end
        end
      end

      attr_reader :about

      def about(title = nil, &block)
        @about ||= {}

        if title
          return @about[title]
        end

        if block_given?
          Context.new(self).eval(&block)
        end

        @about
      end

    end
  end
end
