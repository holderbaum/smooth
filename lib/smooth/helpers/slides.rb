module Smooth
  module Helpers
    module Slides

      def slides(&block)
        content :slides, component(:slides, {}, &block)
      end

    end
  end
end
