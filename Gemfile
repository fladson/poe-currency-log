source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "coffee-rails", "~> 4.2"
gem "devise"
gem "jbuilder", "~> 2.5"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.5"
gem "sass-rails", "~> 5.0"
gem "sendgrid-ruby"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "awesome_print", require: false
  gem "bullet"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "guard"
  gem "guard-livereload"
  gem "guard-rspec"
  gem "meta_request"
  gem "pry-rails"
  gem "reek", require: false
  gem "rspec-rails", "~> 3.7"
  gem "rubocop-github", require: false
  gem "rubocop-rspec", require: false
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara"
  gem "coveralls", require: false
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "shoulda-matchers", "~> 3.1"
  gem "simplecov", require: false
end
