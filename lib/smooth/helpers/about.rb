module Smooth
  module Helpers
    module About
      def about(title = nil, &block)
        @about ||= {}

        if title
          return @about[title]
        end

        content(:about, &block) if block_given?
        @about
      end

      # TODO: method missing is our friend here
      def title(s)
        @about[:title] = s
      end

      def author(s)
        @about[:author] = s
      end

      def company(s)
        @about[:company] = s
      end

      def email(s)
        @about[:email] = s
      end

      def date(s)
        @about[:date] = s
      end

      def venue(s)
        @about[:venue] = s
      end
    end
  end
end
