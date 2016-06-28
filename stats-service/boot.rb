require "active_support"
require "active_support/core_ext"

# Initializes load path with gems listed in Gemfile
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __FILE__)
ENV["APP_ENV"] = ENV["RACK_ENV"] = ENV["APP_ENV"].presence || ENV["RACK_ENV"].presence || "development"
require "bundler/setup" if File.exist?(ENV["BUNDLE_GEMFILE"])

# Requires gems listed in Gemfile
Bundler.require(:default, ENV["APP_ENV"])

# Define APP_ROOT
APP_ROOT = Pathname.new(File.expand_path("..", __FILE__))

$: << File.expand_path("../", __FILE__)
