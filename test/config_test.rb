require 'test/helper'
require 'lib/smooth'

class SmoothConfigTest < Test::Unit::TestCase

  context "Path" do
    test "api delegation" do
      p = Smooth::Config::Path.new("/usr")

      assert_equal Pathname.new("/usr/bin"), p.join("bin")
    end

    test "it should implement to_s" do
      p = Smooth::Config::Path.new("/usr")

      assert_equal "/usr", p.to_s
    end

    test "it should be changeable" do
      p = Smooth::Config::Path.new("/usr")

      p.set("/bin")

      assert_equal "/bin", p.to_s
    end

    test "it should be resettable" do
      p = Smooth::Config::Path.new("/usr")

      p.set("/bin")
      p.reset!

      assert_equal "/usr", p.to_s
    end
  end

  context "Pathes" do

    test "it should implement each" do
      p = Smooth::Config::Pathes.new( "/", "/bin" )
      pathes = []
      p.each do |path|
        pathes << path
      end

      assert_equal [Pathname.new("/"), Pathname.new("/bin")], pathes
    end

    test "it should include Enumerable" do
      assert Smooth::Config::Pathes.included_modules.include?(Enumerable)
    end

    test "it should implement to_a with a clone" do
      p = Smooth::Config::Pathes.new( "/", "/usr" )

      pathes = [Pathname.new("/"), Pathname.new("/usr")]

      assert_equal pathes, p.to_a
      p.to_a << "/SOMETHING"
      assert_equal pathes, p.to_a
    end

    test "it should implement unshift" do
      p = Smooth::Config::Pathes.new( "/", "/tmp" )

      pathes = [Pathname.new("/"), Pathname.new("/tmp")]

      p.unshift "/a_path"
      assert_equal [Pathname.new("/a_path")]+pathes, p.to_a
    end

    test "it should be resettable" do
      p = Smooth::Config::Pathes.new( "/", "/swap" )

      pathes = [Pathname.new("/"), Pathname.new("/swap")]

      p.unshift "/a_path"
      p.reset!

      assert_equal pathes, p.to_a
    end

  end

  context "initialize" do

    test "default pathes" do
      cfg = Smooth::Config.new

      assets_path = Smooth::Config::Path.new(File.expand_path('../../assets', __FILE__))
      components_pathes = Smooth::Config::Pathes.new(File.expand_path('../../comp', __FILE__))

      assert cfg.assets_path.is_a?(Smooth::Config::Path)
      assert_equal assets_path.to_s, cfg.assets_path.to_s

      assert cfg.components_pathes.is_a?(Smooth::Config::Pathes)
      assert_equal components_pathes.to_a, cfg.components_pathes.to_a
    end

  end

end
