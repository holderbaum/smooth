module Smooth
  module Helpers
    module Assets

      def copy_asset(path)
        FileUtils.mkdir_p File.join(Dir.pwd, File.dirname(path) )

        from = @config.assets_path.join(path)
        to =  File.join(Dir.pwd, path)

        FileUtils.cp from, to unless File.exist? to
      end

      def convert_path_array_to_path(prefix, array, file_type = prefix)
        path = array.map(&:to_s)
        path.last << ".#{file_type}" unless path.last.match("\.#{file_type}$")
        File.join path.unshift(prefix)
      end

      def js_path(*args)
        path = convert_path_array_to_path 'js', args
        copy_asset path

        path
      end

      def css_path(*args)
        path = convert_path_array_to_path 'style', args, 'css'
        copy_asset path

        path
      end

      def img_path(*args)
        if match = args.last.match(/\.(\w*)$/)
          file_type = match[0]
        else
          file_type = 'jpg'
        end

        path = convert_path_array_to_path 'img', args, file_type
        copy_asset path

        path
      end

    end
  end
end
