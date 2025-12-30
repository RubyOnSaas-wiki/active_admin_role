require "bundler"
require "rake"

Bundler.setup
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)
task default: :spec

desc "Creates a test rails app for the specs to run against"
task :setup do
  require "rails/version"
  system "bundle exec rails --version"
  system <<-COMMAND
  bundle exec rails new tmp/rails-#{Rails::VERSION::STRING} \
    -m spec/support/rails_template.rb \
    --skip-spring \
    --skip-listen \
    --skip-bootsnap \
    --skip-test \
    --skip-git \
    --skip-action-mailer \
    --skip-action-cable \
    --skip-action-mailbox \
    --skip-action-text \
    --skip-active-job \
    --skip-active-storage \
    --skip-hotwire \
    --skip-jbuilder \
    --skip-system-test \
    --skip-docker \
    --skip-kamal \
    --skip-solid \
    --skip-thruster
  COMMAND
end

namespace :tmp do
  task :clear do
    require "fileutils"
    FileUtils.rm_r("tmp")
  end
end
