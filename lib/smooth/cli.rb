module Smooth
  class CLI < Thor
    include Thor::Actions

    desc :build, "create slides from template.haml"
    def build
      template = Pathname.new File.expand_path('template.haml')
      slides = Pathname.new File.expand_path('index.html')

      renderer = Smooth::Renderer.new(template.read)

      Smooth::Helpers.constants.each do |const|
        renderer.register_helpers Smooth::Helpers.const_get(const)  
      end

      slides.open 'w' do |f|
        f << renderer.result
      end
    end

  end
end
