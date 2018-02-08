require "./helpers/spec_browser_ch.rb"
require "./helpers/spec_pages.rb"

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
  expect(page).to have_selector(header_text, text: "Sign in")
  expect(page).to have_selector(input_login)
  expect(page).to have_css(language_selector)
  expect(page).to have_no_css(".best-seller-ever")
end

# login methods
def customer_login(login)
  # find("input#identifierId").set(login)
  find(input_login).set(login)
  find(id_next_btn).click
end

def set_password(password)
  find(input_password).set(password)
  find(password_next_btn).click
end

# mailbox pages
def check_mailbox
  expect(page).to have_selector(inbox_logo)
  expect(page).to have_css(inbox_primary)
end

# Cleanup steps
def cleanup
  browser = Capybara.current_session.driver.browser # should be moved to helper
  browser.manage.delete_all_cookies
  Capybara.reset_sessions!
end