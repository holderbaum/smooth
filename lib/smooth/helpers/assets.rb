module Smooth
  module Helpers
    module Assets
      BASE_PATH = File.expand_path('../../../../assets', __FILE__)
      
      def self.base_path(new_path = nil)
        if new_path
          @base_path = new_path
        else
          @base_path ||= BASE_PATH
        end
      end

      def self.reset_base_path!
        @base_path = nil
      end

      def copy_asset(path)
        FileUtils.mkdir_p File.join(Dir.pwd, File.dirname(path) )

        from = File.join(Assets.base_path, path)
        to =  File.join(Dir.pwd, path)

        FileUtils.cp from, to unless File.exist? to
      end

      def convert_path_array_to_path(prefix, array, file_type = prefix)
        path = array.map(&:to_s)
        path.last << ".#{file_type}" unless path.last.match("\.#{file_type}$")
        File.join path.unshift(prefix)
      end

      def js_include(*args)
        path = convert_path_array_to_path 'js', args
        copy_asset path

        haml_tag 'script', :src => path
      end

      def css_include(*args)
        path = convert_path_array_to_path 'style', args, 'css'
        copy_asset path

        haml_tag 'link', :rel => 'stylesheet', :type => 'text/css', :href => path
      end

    end
  end
end
