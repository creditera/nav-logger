require "bundler/gem_tasks"
require "guard/rake_task"
require "rake/testtask"

Guard::RakeTask.new

Rake::TestTask.new :test do |t|
  t.libs << "test"
  # t.warning = false
  t.test_files = FileList["test/**/test_*.rb"]
end

desc "Run the tests"
task default: :test
