module Smooth
  class Base
    include Smooth::Helpers

    def initialize(layout)
      @layout = layout  
    end

    def render(content)
      content_store = ContentStore.new(content)
      content_store.render!

      Haml::Engine.new(@layout).render(content_store.context)
    end

  end
end
