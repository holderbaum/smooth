require 'test/helper'
require 'lib/smooth'

class SmoothConfigTest < Test::Unit::TestCase

  context "Pathes" do

    test "it should implement each" do
      p = Smooth::Config::Pathes.new( "/", "/bin" )
      pathes = []
      p.each do |path|
        pathes << path
      end

      assert_equal ["/", "/bin"], pathes
    end

    test "it should include Enumerable" do
      assert Smooth::Config::Pathes.included_modules.include?(Enumerable)
    end

    test "it should implement to_a with a clone" do
      pathes = ["/", "/usr"]
      p = Smooth::Config::Pathes.new( *pathes )
      
      assert_equal pathes, p.to_a
      p.to_a << "/SOMETHING"
      assert_equal pathes, p.to_a
    end

    test "it should implement unshift" do
      pathes = ["/", "/usr"]
      p = Smooth::Config::Pathes.new( *pathes )
      p.unshift "/a_path"
      
      assert_equal ["/a_path"]+pathes, p.to_a
    end

  end

  context "initialize" do

    test "default pathes" do
      cfg = Smooth::Config.new

      assets_path = Pathname.new(File.expand_path('../../assets', __FILE__))
      components_pathes = Smooth::Config::Pathes.new(File.expand_path('../../comp', __FILE__))

      assert_equal assets_path, cfg.assets_path
      assert cfg.components_pathes.is_a?(Smooth::Config::Pathes)
      assert_equal components_pathes.to_a, cfg.components_pathes.to_a
    end

  end

end
