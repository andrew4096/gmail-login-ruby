# gmail-login-ruby
Simple Gmail autotest.

Project based on Ruby2.3-x64, Selenium-webdriver and Capybara+Rspec.
For report generaton uses Allure with screenshot support by capybara-screenshot.

Currently test written only for Google Chrome, tested on v. 64.0.3282.140 (64-bit).

For testing mobile versions there are solution - gem 'webdriver-user-agent' that should change 
browser mode, like this (:browser => :chrome, :agent => :iphone, :orientation => :landscape), but currently 
there are problem with initialise this with Capybara.
