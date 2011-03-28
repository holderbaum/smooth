module Smooth
  class Config

    ASSETS_PATH     = File.expand_path('../../../share/assets', __FILE__)
    LAYOUTS_PATH    = File.expand_path('../../../share/layouts', __FILE__)
    COMPONENTS_PATH = File.expand_path('../../../share/components', __FILE__)

    attr_reader :assets_path, :layouts_pathes, :components_pathes

    def initialize
      @assets_path        = Path.new( ASSETS_PATH ) 
      @layouts_pathes     = Pathes.new( LAYOUTS_PATH )
      @components_pathes  = Pathes.new( COMPONENTS_PATH )
    end

    class Path
      extend Forwardable

      def_delegators :@path, :join, :to_s

      def initialize(path)
        @path = Pathname.new(path)
        @default = @path.dup
      end

      def set(path)
        @path = Pathname.new(path)
      end

      def reset!
        @path = @default
      end

    end

    class Pathes
      include Enumerable

      def initialize(*args)
        @pathes = args.map { |path| Pathname.new(path) }
        @default = to_a
      end

      def prepend(path)
        @pathes.unshift Pathname.new(path)
      end

      def reset!
        @pathes = @default
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
