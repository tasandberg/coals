require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Display basic researcher information'
task :info, %i[email role why grantor] => :prereq do |_task, args|
  puts 'do it do it'
  puts "You gave me #{args.inspect}"
end
