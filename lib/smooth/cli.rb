module Smooth
  class CLI < Thor
    include Thor::Actions

    desc :build, "create slides from template.haml"
    def build
      puts "ohh"
    end

  end
end
