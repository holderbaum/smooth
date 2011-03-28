module Smooth
  module Helpers
    module Slides

      def slides(&block)
        if block_given?
          content :slides, component(:slides, &block)
        else
          content :slides
        end
      end

    end
  end
end
