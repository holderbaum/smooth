module Smooth
  class Config

    ASSETS_PATH = File.expand_path('../../../assets', __FILE__)
    COMPONENTS_PATH = File.expand_path("../../../comp", __FILE__)

    attr_reader :assets_path, :components_pathes

    def initialize
      @assets_path = Pathname.new( ASSETS_PATH ) 
      @components_pathes = Pathes.new( COMPONENTS_PATH )
    end


    class Pathes
      include Enumerable

      def initialize(*args)
        @pathes = []
        args.each do |path|
          @pathes << path
        end
      end

      def unshift(path)
        @pathes.unshift path 
      end

      def to_a
        @pathes.dup
      end

      def each(&blk)
        @pathes.each(&blk)
      end
    end

  end
end
