require 'rubygems'
require 'bundler/setup'

require 'rake'
require 'rake/testtask'

require 'yard'

task :default => [:test]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "smooth"
    s.summary = "create nice haml slides"
    s.description = "Haml-based slide generator for fast slides-creation from scratch."
    s.email = "jh@neopoly.de"
    s.homepage = "http://techfolio.de"
    s.authors = ["Jakob Holderbaum"]
    s.files.exclude 'example'
    s.files.exclude 'doc'
    s.executables = ["smooth"]
  end

  Jeweler::RubygemsDotOrgTasks.new

rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

# Generate doc
YARD::Rake::YardocTask.new

#TestUnit
desc "Run basic tests"
Rake::TestTask.new("test") do |t|
  t.pattern = 'test/*_test.rb'
  t.verbose = true
  # t.warning = true
  t.warning = false
end

