module Smooth
  module Helpers
    module Components
      PATH = [ File.expand_path("../../../../comp", __FILE__) ]

      def self.path(new_path = nil)
        if new_path
          @path = new_path
        else
          @path ||= PATH
        end
      end

      def self.reset_path!
        @path = nil
      end

      def component(name, arguments = {}, &block)
        Components.path.each do |path|
          if File.exist?(file = File.join(path, "#{name.to_s}.haml"))
            if block_given?
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
