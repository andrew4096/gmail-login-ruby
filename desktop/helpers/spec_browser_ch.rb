require 'capybara'
require 'selenium-webdriver'
require 'webdriver-user-agent'
require 'rspec/expectations'
require 'capybara/rspec'
require 'rspec-steps'
require 'allure-rspec'
require 'pathname'
require 'rspec/retry'
require 'capybara-screenshot/rspec' # support screenshots

Capybara.current_driver = :selenium
 Capybara.register_driver :selenium do |app|
   Capybara::Selenium::Driver.new(app, :browser => :chrome, args: ["--disable-infobars"])
end
Capybara.ignore_hidden_elements = false
Capybara.javascript_driver = :selenium
Capybara.save_path = "screenshots" # option for capybara screenshots
Capybara::Screenshot.prune_strategy = :keep_last_run # option for capybara screenshots
# Capybara.reset_sessions! # cleanup session

Capybara.configure do |config|
  config.default_max_wait_time = 15 # seconds
  config.default_driver        = :selenium
  browser = Capybara.current_session.driver.browser
  # browser.manage.window.maximize
  browser.manage.window.resize_to(1280, 800)
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.include Capybara::DSL
  # config.include AllureRSpec::Adaptor
  # AllureRSpec::DSL.attach_file("#{scenario.name}.png -FAILURE Screenshot") if ENV['ALLURE']=='true'
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  # show retry status in spec process
  config.verbose_retry = true
  # Try twice (retry once)
  config.default_retry_count = 2
  # Only retry when Selenium raises Net::ReadTimeout
  config.exceptions_to_retry = [Net::ReadTimeout]
  config.filter_run :focus
  config.order = 'random'

  # config.after(:each) do |example|
  #   unless example.exception.nil?
  #     example.attach_file(File.new(save_screenshot(File.join(Dir.pwd, "results/#{UUID.new.generate}.png"))))
  #   end
  #   # @driver.quit
  # end
end

AllureRSpec.configure do |config|
  config.output_dir = "results"
  config.clean_dir = true
  config.logging_level = Logger::DEBUG # Allure logging level (choose: DEBUG or INFO )
end