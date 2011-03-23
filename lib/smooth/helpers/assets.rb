module Smooth
  module Helpers
    module Assets
      BASE_PATH = File.expand_path('../../../../assets', __FILE__)
      JS_PATH = File.join(BASE_PATH, 'js')

      def js_include(*args)
        path = ['js'].concat(args).map(&:to_s)

        path.last << '.js'
        path = File.join(path)

        haml_tag 'script', :src => path
      end

    end
  end
end
