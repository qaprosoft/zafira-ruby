# frozen_string_literal: true

require 'bundler/gem_tasks'

task default: :spec_all

desc 'Spec all functionality of gem'
task :spec_all do
  system('rspec spec/*/ -f doc -r ./spec/zafira_spec_helper')
end
