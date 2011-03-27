require 'test/helper'
require 'lib/smooth'

class SmoothConfigTest < Test::Unit::TestCase

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
