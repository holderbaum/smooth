require 'rubygems'
require 'bundler/setup'

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

task :default => [:test]

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

