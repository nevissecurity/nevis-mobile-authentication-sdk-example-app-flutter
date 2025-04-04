source "https://rubygems.org"

gem "cocoapods", "~> 1.16"
gem "fastlane", "~> 2.225"

# These gems were loaded from the standard library by Fastlane,
# but will no longer be part of the default gems since Ruby 3.4.0.
# Includes them directly until Fastlane fixes it.
gem "abbrev"
gem "ostruct"

group :development do
	gem "rubocop", "~> 1.63", require: false
	gem "team_fastlane-rubocop", "~> 1.2.10", require: false
end

plugins_path = File.join(File.dirname(__FILE__), "fastlane", "Pluginfile")
eval_gemfile(plugins_path) if File.exist?(plugins_path)
