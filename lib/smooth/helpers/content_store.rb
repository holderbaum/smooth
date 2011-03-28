module Smooth
  module Helpers
    module ContentStore

      def content(title, string=nil, &block)
        @content ||= {}

        @content[title] ||= ""

        if string
          @content[title] << "#{string}\n"
        elsif block_given?
          @content[title] << capture_haml(&block)
        else
          @content[title]
        end
      end

    end
  end
end
