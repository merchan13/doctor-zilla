source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.0.2'
gem 'puma', '~> 3.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '>= 3.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

#CUSTOM
gem 'bcrypt'
gem 'devise'
gem 'devise_security_extension'
gem 'devise-i18n'
gem 'twitter-bootstrap-rails'
gem 'devise-bootstrap-views'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'bootstrap-datepicker-rails'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog-aws'
gem 'figaro'
gem 'responders'
gem 'htmltoword'


group :development, :test do
  gem 'byebug', platform: :mri
  gem 'sqlite3'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
