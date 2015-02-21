require 'rubygems'
require 'bundler'

ENV['RACK_ENV'] ||= 'development'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'

task :boot do
  require File.expand_path('../config/boot', __FILE__)
end

desc 'Run pry console'
task :console do |_t, _args|
  exec 'pry -r ./config/boot'
end

desc 'Sync Onapp transactions to our DB'
task transactions_sync: :boot do
  Transactions::Sync.run
end

desc "Migrate Jager's SQL DB to our DB"
task migrate_from_jager: :boot do
  MigrateFromJager.run
end
