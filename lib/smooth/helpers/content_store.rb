module Smooth
  module Helpers
    module ContentStore

      def content(title, string=nil, &block)
        @content ||= {}

        if string
          @content[title] = "#{string}\n"
        elsif block_given?
          @content[title] = capture_haml(&block) if block_given?
        else
          @content[title]
        end
      end

    end
  end
end
