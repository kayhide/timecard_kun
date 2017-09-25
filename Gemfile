source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.4'
gem 'rails', '~> 5.1.3'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'slim-rails'
gem 'kaminari'

gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'rails-i18n'

gem 'mechanize'

gem 'pry-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'

  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'rack-livereload'
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'guard-rspec'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'rails-footnotes'
end

group :production do
  gem 'rails_12factor'
end
