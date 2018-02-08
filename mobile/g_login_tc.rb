require './helpers/spec_helper.rb'
require './helpers/spec_steps.rb'

  describe "Customer visit Gmail and do login on mobile device",
   :feature => "AS a customer I'm opening login page in browser and login ...",
    js: true, :order => :defined do
    
    before(:step) do |s|
      puts "Before step #{s.current_step}"
    end

    before (:each) do
      visit main_site
    end

    it "TC#1 - Gmail customer login" , :story => "Login with correct data", :severity => :normal do |e|
      e.step "Validate test setup: Check proper page" do |s|
        visit_loginpage
      end

      e.step "Enter customer login" do |s|
        customer_login("andrewbigbug")
      end

      e.step "Enter customer password" do |s|
        set_password("Uc82Y0yv7")
      end
        
      e.step "Check mailbox: Login success" do |s|
        # check_mailbox
        expect(page).to have_content("You're missing out") # in mobile version Google show only stub-page "You're missing out"
      end

      e.step "Cleanup: Cleanup session and cookies" do |s|
        cleanup
      end  
  end

end