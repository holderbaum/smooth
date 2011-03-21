module Smooth
  module Helpers
    class ContentStore

      def initialize(layout)
        @content = {}
        @layout = Haml::Engine.new(layout).render(self)
      end

      def content(title, &block)
        @content[title] = capture_haml(&block) if block_given?
        @content[title]
      end
    end
  end
end
