require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test

require "rdoc/task"

RDoc::Task.new do |rdoc|
  rdoc.generator = "ri"
  rdoc.rdoc_dir = "doc"
  rdoc.rdoc_files.include("lib/**/*.rb")
  rdoc.markup = "markdown"
end
