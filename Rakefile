require 'rubygems'
require 'bundler/setup'

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

task :default => [:test]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "smooth"
    s.summary = "create nice haml slides (powered by slippy)"
    s.description = "extends haml with useful helpers, a layout concept and rails-partial like components."
    s.email = "jh@neopoly.de"
    s.homepage = "http://techfolio.de"
    s.authors = ["Jakob Holderbaum"]
    s.files.exclude 'src'
  end

  Jeweler::RubygemsDotOrgTasks.new

rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

# RDoc
Rake::RDocTask.new do |rd|
  rd.title = "Smooth"
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  rd.rdoc_dir = "doc"
end

#TestUnit
desc "Run basic tests"
Rake::TestTask.new("test") do |t|
  t.pattern = 'test/*_test.rb'
  t.verbose = true
  # t.warning = true
  t.warning = false
end

