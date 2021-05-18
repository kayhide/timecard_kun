source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.4'
gem 'rails', '~> 6.0.0'

gem 'bootstrap-datepicker-rails'
gem 'bootstrap-editable-rails'
gem 'bootstrap-sass'
gem 'coffee-rails', '~> 4.2'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'kaminari'
gem 'mechanize'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pry-rails'
gem 'puma', '~> 4.3'
gem 'rails-i18n'
gem 'sassc-rails'
gem 'slim-rails'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug'
  gem 'capybara', '~> 2.13'
  gem 'factory_bot_rails'
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'guard-rspec'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'rack-livereload'
  gem 'rspec-rails', '~> 4.0.0.beta2'
  gem 'selenium-webdriver'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development do
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'rails-controller-testing'
end

group :production do
  gem 'rails_12factor'
end
