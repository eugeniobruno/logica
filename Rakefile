require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/test_*.rb']
end

task default: :test

desc 'Start a REPL session'
task :console do
  require 'logica'
  require 'pry'
  ARGV.clear
  Pry.start
end
