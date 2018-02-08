require 'capybara'
require 'selenium-webdriver'
require 'rspec/expectations'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'rspec-steps'
# require 'capybara-screenshot/rspec'
# require 'capybara/poltergeist'
include Capybara::DSL

Capybara.javascript_driver = :poltergeist
Capybara.current_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    js_errors: false,
    window_size: [1280, 1024],
    # phantomjs:   File.join('C:\Ruby23-x64\phantomjs-1.9.8-windows',"phantomjs.exe"),
    debug:       false
  )
end

Capybara.default_max_wait_time = 4


RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  # Capybara.javascript_driver = :webkit
end
