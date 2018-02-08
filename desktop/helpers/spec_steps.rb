require "./helpers/spec_browser_ch.rb"
# require "./helpers/spec_non_browser_poltergeist.rb" # non browser driver

module WaitForAjax  #use "wait_for_ajax" in tests to wait ajax loading
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end

# login page
def visit_loginpage
  expect(page).to have_selector("#headingText", text: "Sign in")
  expect(page).to have_selector('#identifierId')
  expect(page).to have_css("[data-value='en']")
  expect(page).to have_no_css(".best-seller-ever")
end

# login methods
def customer_login(login)
  find("input#identifierId").set(login)
  find("#identifierNext").click
end

def set_password(password)
  find("input[name='password']").set(password)
  find("#passwordNext").click
end

# mailbox pages
def check_mailbox
  expect(page).to have_selector("[href='#inbox']")
  expect(page).to have_css("[href='https://mail.google.com/mail/u/0/#inbox']")
end

# Cleanup steps
def cleanup
  browser = Capybara.current_session.driver.browser # should be moved to helper
  browser.manage.delete_all_cookies
  Capybara.reset_sessions!
end