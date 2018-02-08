require "./helpers/spec_browser_ch.rb"
# require "./helpers/spec_non_browser_poltergeist.rb" # non browser driver

RSpec.configure do |c|
      c.include AllureRSpec::Adaptor
    end

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

# site link
def main_site
  return 'https://gmail.com/'
end

def main_site_direct
  return 'https://accounts.google.com/'
end
