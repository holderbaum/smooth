module Smooth
  module Helpers
    module Components

      def component(name, arguments = {}, &block)
        @config.components_pathes.each do |path|
          if (file = path.join("#{name.to_s}.haml")).exist?
            if block_given?
              return Haml::Engine.new(file.read).render(self, arguments) do
                capture_haml &block 
              end
            else
              return Haml::Engine.new(file.read).render(self, arguments) do
                # empty block for yield
              end
            end
          end
        end
        raise "Component '#{name}' not found."
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
    end
  end
end
