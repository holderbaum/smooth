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
        # [ key, style_body ]
        @styles ||= []

        @styles << [ key, capture_haml(&block) ] unless style?(key)
      end

      def style?(key)
        key = key.to_s
        @styles.find { |(k, _)| k.to_s == key }
      end
      private :style?

      def styles
        @styles.map do |key, style|
          "/* #{key} */\n"+
          "#{style}"
        end.join("\n")
      end

    end
  end
end
