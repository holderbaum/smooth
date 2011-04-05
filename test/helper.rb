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

  FIXTURES_DIR = File.expand_path('../fixtures', __FILE__)
  TEST_DIR = File.join(FIXTURES_DIR, 'test_dir')
  CLI_TEST_DIR = File.join(FIXTURES_DIR, 'cli_test')

  def in_test_dir(&block)
    Dir.chdir(TEST_DIR, &block)
  end

  def clear_test_dir
    files = Dir.glob(File.join TEST_DIR, "*")
    FileUtils.rm_rf files
  end

  def init_haml_template
    FileUtils.cp File.expand_path('../fixtures/cli_test/template.haml', __FILE__), TEST_DIR
  end

  def assert_slides_creation
    index = File.join(TEST_DIR, 'index.html')
    assert File.exist?(index), "#{index} missing."
    assert_equal File.open(File.join(CLI_TEST_DIR, 'index.html')).read, File.open(index).read, "#{index} wrong content."
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
