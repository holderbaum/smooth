module Smooth
  module Helpers
    module Components
      PATH = []

      def component(name, arguments = {}, &block)
        PATH.each do |path|
          if File.exist?(file = File.join(path, "#{name.to_s}.haml"))
            if block_given?
              return Haml::Engine.new(File.read(file)).render(self, :content => capture_haml(&block))
            else
              return Haml::Engine.new(File.read(file)).render
            end
          end
        end
        raise "Component not found."
      end

    end
  end
end
