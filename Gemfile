source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails',                '4.2.1'#'4.2.2'
gem 'sass-rails',           '~> 5.0.3'
gem 'uglifier',             '~> 2.7.0'
gem 'coffee-rails',         '4.1.0'
gem 'jquery-rails',         '~> 4.0.4'
gem 'turbolinks',           '~> 2.5.3'
gem 'jbuilder',             '~> 2.3.1'
gem 'devise',               '~> 3.5.2'
gem 'bootstrap-sass',       '~> 3.3.5.1'
gem 'thin',                 '~> 1.6.3'
gem 'pg',                   '~> 0.18.2'
gem 'foreman',              '~> 0.78.0'
gem 'simple_form',          '~> 3.1.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'sdoc',        group: :doc



group :development do
  gem 'annotate',           '~> 2.6.10'
  gem 'web-console',        '~> 2.2.1'
  gem 'spring'
  gem 'sqlite3'
end

group :test, :development do
  gem 'rubocop',                 require: false
  gem 'rubycritic',              require: false
  gem 'simplecov',               '~> 0.10.0', require: false
  gem 'brakeman',                '~> 3.0.5', require: false
  gem 'pry-rails',               '~> 0.3.4'
  gem 'pry-rescue',              '~> 1.4.2'
  gem 'binding_of_caller',       '~> 0.7.2'
  gem 'better_errors',           '~> 2.1.1'
  gem 'factory_girl_rails',      '~> 4.5.0'
  gem 'shoulda-matchers',        '~> 2.8.0'
  gem 'rspec-rails',             '~> 3.3.3'
  gem 'rspec-activemodel-mocks', '~> 1.0.1'
  gem 'rails_best_practices',    '~> 1.15.7'
  gem 'ephemeral_response',      '~> 0.4.0'
  gem 'database_cleaner',        '~> 1.4.1'
  # gem 'json_spec',               '~> 1.1.4'
  gem 'rspec_candy',             '~> 0.4.0'
  gem 'sextant',                 '~> 0.2.4'
  # gem 'derailed',                '~> 0.1.0'
end

group :production do
  gem 'rails_12factor'
  gem 'rails_serve_static_assets', '~> 0.0.4'
end
