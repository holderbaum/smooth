module Smooth
  class Base
    include Smooth::Helpers

    def initialize(layout)
      @layout = layout  
    end

    def render(content)
      content_store = ContentStore.new(content)
      Haml::Engine.new(@layout).render(content_store)
    end

  end
end
