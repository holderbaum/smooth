module Smooth
  module Helpers
    module Components
      PATH = [ File.expand_path("../../../../comp", __FILE__) ]

      def component(name, arguments = {}, &block)
        PATH.each do |path|
          if File.exist?(file = File.join(path, "#{name.to_s}.haml"))
            if block_given?
              puts arguments
              return Haml::Engine.new(File.read(file)).render(self, arguments) do
                capture_haml &block 
              end
            else
              return Haml::Engine.new(File.read(file)).render(self, arguments) do
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
