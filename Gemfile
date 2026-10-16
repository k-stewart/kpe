source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.4"

gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  gem "bundler-audit", require: false # Audits gems for known security defects (use config/bundler-audit.yml to ignore issues)
  gem "brakeman", require: false # Static analysis for security vulnerabilities [https://brakemanscanner.org/]

  gem "rubocop", require: false
  gem "rspec-rails", "~> 8.0"
  gem "shoulda-matchers", "~> 8.0"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
