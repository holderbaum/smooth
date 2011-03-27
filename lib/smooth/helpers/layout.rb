module Smooth
  module Helpers
    module Layout

      def layout(name)
        name = name.to_s

        name << ".haml" unless name.match(/\.haml$/)
          
        @config.layouts_pathes.each do |path|
          if(file = path.join(name)).exist?
            set_layout_haml_content( file.read )
            return
          end
        end
        raise "Layout '#{name}' not found."
      end

      def set_layout_haml_content(layout)
        @renderer.layout = layout unless @renderer.layout
      end

    end
  end
end
