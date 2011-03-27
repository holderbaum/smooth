ENV["RAILS_ENV"] = "test"

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'contest'
require 'fileutils'

class String
  def unindent
    indent = self[/^\s+/]
    self.gsub(/^#{indent}/, '')
  end
end

class Test::Unit::TestCase

  TEST_DIR = File.expand_path('../fixtures/test_dir', __FILE__)

  def in_test_dir(&block)
    Dir.chdir(TEST_DIR, &block)
  end

  def clear_test_dir
    files = Dir.glob(File.join TEST_DIR, "*")
    FileUtils.rm_rf files
  end

  def renderer(template, layout, config, helpers)
    helpers = Array(helpers)

    r = Smooth::Renderer.new(template, config)
    r.layout = layout if layout

    helpers.each do |helper|
      r.register_helpers helper
    end

    r
  end

end
