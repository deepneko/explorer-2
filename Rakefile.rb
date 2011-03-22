require 'rake'
require 'rspec/core/rake_task'

namespace :spec do
  EXPLORER_TARGET = [:crawler, :web, :delete]

  EXPLORER_TARGET.each do |target|
    RSpec::Core::RakeTask.new(target) do |t|
      t.rspec_opts = ['-f documentation', '-c']
      t.pattern = "spec/#{target}/*_spec.rb"
    end
  end

  RSpec::Core::RakeTask.new(:all) do |t|
    t.rspec_opts = ['-f documentation', '-c']
    t.pattern = FileList['spec/**/*_spec.rb']
  end
end

task :default => "spec:all"
task :crawler => "spec:crawler"
task :web => "spec:web"
task :delete => "spec:delete"
