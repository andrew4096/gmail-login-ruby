require './helpers/spec_helper.rb'

describe "As A QA user i'm validating content and items which are not related to the user flow", :feature => "As A QA user i'm validating content and items which are not related to the user flow", :severity => :normal do

 before(:step) do |s|
    puts "Before step #{s.current_step}"
  end

  before (:each) do
      visit main_site_se
    end

it "Validating content and items", :story => "Validating content and items", :severity => :normal do |e|
    
    e.step "Visit home page and verified it opened" do |s|
        visit_homepage (main_site_se)
    end

    e.step "verify there is a Favico on the main page" do |s|
        favicon
    end

    e.step "verify there is a valid 404 page, when page is not found" do |s|
        check404(main_site_se, "SIDAN KAN INTE HITTAS")
        #Percy::Capybara.snapshot(page, name: '404 is displayed properly on SE')
    end
end 

it "As A User i'm checking and clicking on all articles and verify their content", :story => "As A User i'm checking and clicking on all articles and verify their content", :severity => :normal do |e|
    
    e.step "Check the top rotator is present" do |s|
        expect(page).to have_selector("#HeaderRotator")
    end

    e.step "Check track my order link" do |s|
        trackmyordertop
    end

    e.step "Check Need help page" do |s|
        find(".top-right-item [href='/info/kundservice']").click 
        expect(page).to have_selector(".articleContent", text: "HUR KAN VI HJÄLPA DIG ?")
        expect(page).to have_selector(".NewArticleTitleh2", text: "FRAKT OCH LEVERANS")
        expect(page).to have_selector(".NewArticleTitleh2", text: "MIN BESTÄLLNING")
        expect(page).to have_selector(".NewArticleTitleh2", text: "BETALNING")
        expect(page).to have_selector(".NewArticleTitleh2", text: "RETUR OCH ÅTERBETALNING")
        expect(page).to have_selector(".NewArticleTitleh2", text: "INFORMATION")
        expect(page).to have_selector(".NewArticleTitleh2", text: "ALMÄNNA VILLKOR")
        expect(page).to have_selector(".NewArticleTitleh2", text: "OM MITTNAMNHALSBAND")
        expect(page).to have_selector(".NewArticleTitleh2", text: "KONTAKTA OSS")
        #Percy::Capybara.snapshot(page, name: 'Need help page content on SE')

    end 

    e.step "Main Site Logo - click and verify it takes to home page" do |s|
      find("[href='/'][id*='hyper']").click
      expect(page).to have_current_path(main_site_se, url: true)
    end

    e.step "sidebarFbBox - Facebook like button - verify" do |s|
      expect(page).to have_selector(".top-right-item .fb-like")
    end

    e.step "Bottom page - certificates-wrapper (Payment option logos) - verify" do |s|
      find(".payments-wrap")
      expect(find(".payments-wrap")).to have_selector("img", :count => 9)
    end

    e.step "Bottom page - copyright description" do |s|
      find(".footerLine.container")
      expect(find(".footerLine.container")).to have_selector(".copyright")
    end    

    e.step "Free delivery page - footer - click and verify it's opened" do |s|
        find("[href='/info/leverans-information']", :text => "LEVERANS INFORMATION").click
        expect(page).to have_content("FRAKT OCH LEVERANS INFORMATION")
        expect(page).to have_content("Adressinformation")
        expect(page).to have_content("Leveransmeddelande")
        expect(page).to have_content("Beräknad leverans")  
        #Percy::Capybara.snapshot(page, name: 'Free delivery page content on SE')
    end 

 end 


it "I'm verifying there is a design and items are proprly set on the site", :story => "I'm verifying there is a design and items are proprly set on the site", :severity => :normal do |e|

    e.step "Verify the Title of the site" do |s|
       expect(page).to have_selector("#head title", :text => "Namnsmycken, Namnhalsband, Halsband med Namn | MittNamnhalsband")     
    end 

    e.step "Verify the top menu is exist with 6 categories" do |s|
       expect(page).to have_selector(".topMenuItem", :count => 6)
    end   

    e.step "1st Collections submenu number" do |s|
        expect(find(".topMenu .topMenuItem", match: :first)).to have_selector(".subMenuItem", :count => 9)
    end  

    e.step "check all sub menu content for 1st top menu item" do |s|
<<<<<<< HEAD
        submenus_for_1st_topmenu(9)     
=======
        submenus_for_x_topmenu(1,8) 
        #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')    
>>>>>>> ab4b82976de9a3eafef4166f21d0fcbdd215da76
    end 

    e.step "2nd Collections submenu number" do |s|
        expect(all(".topMenu .topMenuItem")[1]).to have_selector(".subMenuItem", :count => 7)
    end

    e.step "check all sub menu content for 2nd top menu item" do |s|
<<<<<<< HEAD
        submenus_for_x_topmenu(2,7)     
=======
        submenus_for_x_topmenu(2,6)  
        #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')      
>>>>>>> ab4b82976de9a3eafef4166f21d0fcbdd215da76
    end 

    e.step "3rd Collections submenu number" do |s|
        expect(all(".topMenu .topMenuItem")[2]).to have_selector(".subMenuItem", :count => 4)
    end

    e.step "check all sub menu content for 3rd top menu item" do |s|
        submenus_for_x_topmenu(3,4)
        #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')        
    end 

    e.step "4th Collections submenu number" do |s|
        expect(all(".topMenu .topMenuItem")[3]).to have_selector(".subMenuItem", :count => 11)
    end

    e.step "check all sub menu content for 4th top menu item" do |s|
<<<<<<< HEAD
        submenus_for_x_topmenu(4,11)     
=======
        submenus_for_x_topmenu(4,6) 
        #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')       
>>>>>>> ab4b82976de9a3eafef4166f21d0fcbdd215da76
    end 

    e.step "5th Collections submenu number" do |s|
        expect(all(".topMenu .topMenuItem")[4]).to have_selector(".subMenuItem", :count => 6)
    end

    e.step "check all sub menu content for 5th top menu item" do |s|
<<<<<<< HEAD
        submenus_for_x_topmenu(5,6)
    end

    e.step "6th Collections submenu number" do |s|
        expect(all(".topMenu .topMenuItem")[5]).to have_selector(".subMenuItem", :count => 1)
    end

    e.step "check all sub menu content for 5th top menu item" do |s|
        submenus_for_x_topmenu(6,1)     #changed by @Andrew in accordance with QA SE
=======
        submenus_for_x_topmenu(5,1) 
        #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')       
>>>>>>> ab4b82976de9a3eafef4166f21d0fcbdd215da76
    end 

end
 
end