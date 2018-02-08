require './helpers/spec_helper.rb'
require './helpers/spec_steps.rb'
#require './helpers/config_helper.rb'

  describe "Customer visit Gmail and do login",
   :feature => "AS a customer I'm opening login page in browser and login ...",
    js: true, :order => :defined do
    
    before(:step) do |s|
      puts "Before step #{s.current_step}"
    end

    before (:each) do
      visit main_site
    end

    it "TC#1 - Gmail customer login" , :story => "Login with correct data", :severity => :normal do |e|
      e.step "Check proper page" do |s|
        visit_loginpage
      end

      e.step "Enter customer login" do |s|
        customer_login("andrew.lakhno")
      end

      e.step "Enter customer password" do |s|
        set_password("Pa$$w0rd`")
      end
        
      e.step "Check mailbox - login success" do |s|
        check_mailbox
        expect(page).to have_content("Andrew Lakhno")
      end

      e.step "Cleanup" do |s|
        cleanup
      end  
  end

  # describe "Something else ",
  #  :feature => "AS a user I'm ...ing",
  #   js: true, :order => :defined do
    
  #     before(:step) do |s|
  #       puts "Before step #{s.current_step}"
  #     end
  
  #     before (:each) do
  #       visit main_site
  #     end
  
  # end

end