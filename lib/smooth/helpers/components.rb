module Smooth
  module Helpers
    module Components
      class ComponentError < RuntimeError; end

      def component(name, arguments = {}, &block)
        @config.components_pathes.each do |path|
          if (file = path.join("#{name.to_s}.haml")).exist?
            return Haml::Engine.new(file.read).render(self, arguments) do
              capture_haml(&block) if block_given?
            end
          end
        end
        raise ComponentError.new("Component '#{name}' not found.")
      end

      def component_resolver(*args, &block)
        name = args.shift
        if args.size != 0 and !args[0].is_a?(Hash)
          title = args.shift
        else
          title = ""
        end
        options = args.last || {}
        options.merge!( :title => title )

        component name, options, &block
      end

      def method_missing(meth, *args, &blk)
        component_resolver meth, *args, &blk
      rescue ComponentError
        super
      end
    end
  end
end
