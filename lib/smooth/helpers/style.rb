module Smooth
  module Helpers
    module Style

      #def slides(&block)
        #if block_given?
          #content :slides, component(:slides, {}, &block)
        #else
          #content :slides
        #end
      #end

      def style(key, &block)
        @styles ||= {}

        @styles[key] = capture_haml(&block) unless @styles[key]
      end

      def styles
        @styles.map do |key, style|
          "/* #{key} */\n"+
          "#{style}"
        end.join("\n")
      end

    end
  end
end
