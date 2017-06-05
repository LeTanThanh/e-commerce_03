source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "5.0.1"
gem "puma", "3.4.0"
gem "sass-rails", "5.0.6"
gem "uglifier", "3.0.0"
gem "coffee-rails", "4.2.1"
gem "jquery-rails", "4.1.1"
gem "jbuilder", "2.4.1"
gem "bcrypt", "3.1.11"
gem "bootstrap-sass", "3.3.6"
gem "config", "1.4.0"
gem "ffaker", "2.5.0"
gem "will_paginate", "3.1.0"
gem "bootstrap-will_paginate", "0.0.10"

group :development, :test do
  gem "sqlite3", "1.3.12"
  gem "byebug", "9.0.0", platform: :mri
  gem "rspec"
  gem "rspec-rails"
  gem "rspec-collection_matchers"
  gem "factory_girl_rails"
  gem "better_errors"
  gem "guard-rspec", require: false
  gem "database_cleaner"
  gem "brakeman", require: false
  gem "jshint"
  gem "bundler-audit"
  gem "rubocop", "~> 0.35.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "scss_lint", require: false
  gem "scss_lint_reporter_checkstyle", require: false
  gem "eslint-rails"
  gem "rails_best_practices"
  gem "reek"
  gem "railroady"
  gem "autoprefixer-rails"
end

group :development do
  gem "web-console", "3.1.1"
  gem "listen", "3.0.8"
  gem "spring", "1.7.2"
  gem "spring-watcher-listen", "2.0.0"
end

group :production do
  gem "pg", "0.18.4"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :test do
  gem "simplecov", require: false
  gem "simplecov-rcov", require: false
  gem "simplecov-json"
  gem "shoulda-matchers"
end
