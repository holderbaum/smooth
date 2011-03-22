ENV["RAILS_ENV"] = "test"

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'contest'

class String
  def unindent
    indent = self[/^\s+/]
    self.gsub(/^#{indent}/, '')
  end
end

class Test::Unit::TestCase
  # something
end
