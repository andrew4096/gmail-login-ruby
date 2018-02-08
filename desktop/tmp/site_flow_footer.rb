require './helpers/spec_helper.rb'

feature "AS a user i'm clicking on all bottom links in main page (about us, terms, etc...) And verify i'm in the right page and the page has the right functionality" , js: true, :order => :defined do

  describe "AS a user i'm Entering to each one of the links and verify content" do

    before (:each) do
      visit main_site
    end

    it "Need Help link" do
      page.click_link('Need Help', href: '/Article/Need-Help')
      expect(page).to have_selector(".faqSectionLeft h3", :text => "MY ORDER")
      expect(page).to have_selector(".faqSectionLeft h3", :text => "RETURN AND REFUNDS")
      expect(page).to have_selector(".faqSectionLeft h3", :text => "ABOUT MYNAMENECKLACE")
      expect(page).to have_selector(".faqSectionRight h3", :text => "PRIVACY AND SECURITY")
      expect(page).to have_selector(".faqSectionRight h3", :text => "PAYMENT")
      expect(page).to have_selector(".faqSectionRight h3", :text => "HELPFUL INFORMATION")

      find(".faqBox .question span", text: "Do You Ship Worldwide?").click
      expect(page).to have_selector("div.answer", :text => "Yes, We Ship Worldwide.", :visible => true)
      find(".faqBox .question span", text: "Ring Size Incorrect").click
      expect(page).to have_selector("div.answer", :text => "If your ring size is incorrect, we will resize your ring the first time for free!", :visible => true)
      #Percy::Capybara.snapshot(page, name: 'Need help page')
    end

    describe "Track my order link" do

    # it "Track my order - verify content" do #removed from footer
    #    page.click_link('Track My Order', href: '/Footer-menu-links/Need-Help/Track-My-Order')
    #    expect(page).to have_selector(".EditingFormLabel", :text => "Order ID Number:")
    #    expect(page).to have_selector(".EditingFormLabel", :text => "Customer Email:")
    #    expect(page).to have_selector(".FormButton[value='CHECK ORDER STATUS']")
    #  end

    #  it "Track my order - validations" do #removed from footer
    #    page.click_link('Track My Order', href: '/Footer-menu-links/Need-Help/Track-My-Order')
    #    fill_in("Order ID Number:", with: "111")
    #    fill_in("Order Customer Email:", with: "test")
    #    find(".btn-primary.FormButton").click
    #    expect(page).to have_selector(".ErrorLabel", :text => "The entered values cannot be saved. Please see the fields below for details.")
    #    expect(page).to have_selector(".EditingFormErrorLabel", :text => "Please, enter valid e-mail.")
    #  end

    end

    it "Delivery Information link" do
      page.click_link('Delivery Information', href: '/Article/Delivery-Information')
      expect(page).to have_content("Delivery Methods & Charges")
      expect(page).to have_content("Estimated Delivery")
      expect(page).to have_content("Shipping Notification")
      expect(page).to have_selector(".article-content [href='/Article/FAQ?s=shipping#FaqArticle']")
      #Percy::Capybara.snapshot(page, name: 'Delivery Information page')
    end

    describe "Jewellery Size Guide link" do

      it "Jewellery Size Guide - verify content" do
        page.click_link('Jewellery Size Guide', href: '/Landing-pages-w-sidebar/Jewellery-Size-Guide')
        expect(page).to have_content("HOW TO CHOOSE THE RIGHT CHAIN FOR YOUR NECKLACE")
        expect(page).to have_content("HOW TO FIND OUT YOUR RING SIZE")
        expect(page).to have_content("HOW TO SELECT YOUR BRACELET SIZE ?")
        expect(page).to have_content("HOW TO CARE FOR YOUR PERSONALISED JEWELLERY")
        expect(page).to have_selector("[href='/Landing-pages-w-sidebar/How-to-Choose-Your-Chain-Length.aspx']")
        expect(page).to have_selector("[href='/Landing-pages-w-sidebar/Ring-Size-Guide.aspx']")
        expect(page).to have_selector("[href='/Landing-pages-w-sidebar/How-to-choose-your-bracelet-size.aspx']")
        expect(page).to have_selector("[href='/Article/Care-Instructions.aspx']")
        #Percy::Capybara.snapshot(page, name: 'Jewerly Size Guide page')
      end

      it "verify content on How to Choose Your Chain Length link" do
        page.click_link('Jewellery Size Guide', href: '/Landing-pages-w-sidebar/Jewellery-Size-Guide')
        find("[href='/Landing-pages-w-sidebar/How-to-Choose-Your-Chain-Length.aspx']").click
        expect(page).to have_content("How to Choose Your Chain Length")
        expect(page).to have_selector("[src='/getattachment/Landing-pages-w-sidebar/How-to-Choose-Your-Chain-Length/model_chain_length_cm.jpg.aspx?lang=en-US']")
        #Percy::Capybara.snapshot(page, name: 'Length guide page')
      end

      it "verify content on Ring Size Guide link" do
        page.click_link('Jewellery Size Guide', href: '/Landing-pages-w-sidebar/Jewellery-Size-Guide')
        find("[href='/Landing-pages-w-sidebar/Ring-Size-Guide.aspx']").click
        expect(page).to have_content("Ring Size Guide")
        expect(page).to have_selector(".ringsGuideBox")
        expect(page).to have_selector(".ringsGuideFooterWizardBtn")
        #Percy::Capybara.snapshot(page, name: 'Size Guide page')
      end

      it "verify content on How to choose your bracelet size link" do
        page.click_link('Jewellery Size Guide', href: '/Landing-pages-w-sidebar/Jewellery-Size-Guide')
        find("[href='/Landing-pages-w-sidebar/How-to-choose-your-bracelet-size.aspx']").click
        expect(page).to have_content("How to choose your bracelet size")
        expect(page).to have_selector(".measureImgsBox")
        #Percy::Capybara.snapshot(page, name: 'Bracelet size page')
      end

      it "verify content on Care Instructions link" do
        page.click_link('Jewellery Size Guide', href: '/Landing-pages-w-sidebar/Jewellery-Size-Guide')
        find("[href='/Article/Care-Instructions.aspx']").click
        expect(page).to have_content("Care Instructions")
        expect(page).to have_selector("h3", :text => "Gold & Silver Name Jewellery Cleaning:")
        #Percy::Capybara.snapshot(page, name: 'Care Instruction page')
      end

    end


    it "Care Instructions link" do
      page.click_link('Care Instructions', href: '/Article/Care-Instructions')
      expect(page).to have_content("Care Instructions")
      expect(page).to have_selector("h3", :text => "Gold & Silver Name Jewellery Cleaning:")
    end

 #   it "Chain Collection link" do
 #     page.click_link('Chain Collection', href: '/Footer-menu-links/Need-Help/Chain-Collection')
 #     expect(page).to have_content("Chain Collection")
 #     expect(page).to have_content("Box Chain")
 #     expect(page).to have_content("Beads Chain")
 #     expect(page).to have_content("Figaro Chain")
 #     expect(page).to have_content("Rollo Chain")
 #     expect(page).to have_content("Twist Chain")
 #     expect(page).to have_selector(".LPSideContent")
 #   end

    it "FAQ link" do
      page.click_link('FAQ', href: '/Article/FAQ')
      expect(page).to have_selector("h1", :text => "FAQ")
      #execute_script('window.scroll(0,500);')
      
      find(".question span", :text => "Do you ship worldwide?").click
      wait_for_ajax
      sleep 3
      #expect(page).to have_selector("div.answer", :text => "Orders must be cancelled within 24 hours after placing the order, as all our items are personalised and therefore custom made.", :visible => true)
      expect(page).to have_selector("div.answer", :text => "Yes, we ship to most countries all over the world." , :visible => true) #changed since last changes from prod DB
      expect(page).to have_content("OUR PRODUCTS")
      expect(page).to have_content("RETURNS AND REFUNDS")
      expect(page).to have_content("STILL NEED HELP?")
      #Percy::Capybara.snapshot(page, name: 'FAQ page')
    end

    it "Tips and Advice link" do
      page.click_link('Tips and Advice', href: '/Article/Tips-and-Advice')
      expect(page).to have_selector("h1", :text => "Tips and Advice")
      expect(page).to have_selector("h3", :text => "Information about our products:")
      expect(page).to have_selector("h3", :text => "About us:")
      expect(page).to have_selector("h3", :text => "For more information, please see further articles for your use:")
      #Percy::Capybara.snapshot(page, name: 'Tip and Advice page')
    end

   # it "Terms and conditions link" do #removed from fotter?
 #     page.click_link('Terms and conditions', href: '/Footer-menu-links/About-MyNameNecklace/Terms-and-conditions')
 #     expect(page).to have_selector("h1", :text => "Terms and conditions")
 #     expect(page).to have_selector("h3", :text => "Privacy Policy")
 #     expect(page).to have_selector("h3", :text => "Cookie Policy")
 #     expect(page).to have_selector("h3", :text => "Shipment, Customs, Duties and Taxes")
 #     expect(page).to have_selector("[alt='Global_collect_banner_NEW_IE']")
 #   end

    it "Privacy Policy link" do
      page.click_link('Privacy Policy', href: '/Article/Privacy-Policy')
      expect(page).to have_selector("h1", :text => "Privacy Policy")
      expect(page).to have_content("When you register at our site")
      expect(page).to have_selector(".article-content")
      #Percy::Capybara.snapshot(page, name: 'Privacy Policy page')
    end

    it "Payment Policy link" do
      page.click_link('Payment Policy', href: '/Article/Payment-Policy')
      expect(page).to have_selector("h1", :text => "Payment Policy")
      expect(page).to have_selector(".article-content")
      expect(page).to have_selector("[alt='Foot_visa']")
      #expect(page).to have_selector("[alt='Foot_laser_ie']") #removed?
      expect(page).to have_selector("[alt='Foot_mastercard']")
      expect(page).to have_selector("[alt='Foot_amex']")
      #expect(page).to have_selector("[alt='Foot_Maestro']") #removed
      expect(page).to have_selector("[alt='Paypal_verified_IE']")
      #Percy::Capybara.snapshot(page, name: 'Payment Policy page')
    end

    it "Return and Cancellation Policy link" do
      page.click_link('Return and Cancellation Policy', href: '/Article/Return-and-Cancellation-Policy')
      expect(page).to have_selector("h1", :text => "Return and Cancellation Policy")
      expect(page).to have_selector("h3", :text => "Return Policy")
      expect(page).to have_selector("h3", :text => "Cancellation Policy")
      expect(page).to have_selector(".article-content [href='/Info/Contact-us.aspx']")
      #Percy::Capybara.snapshot(page, name: 'Return and Cencellation page')
    end

    describe "About Us link" do

      it "About Us - verify content" do
        page.click_link('About Us', href: '/Article/About-Us')
        expect(page).to have_selector("h1", :text => "About Us")
        expect(page).to have_selector(".article-content")
        expect(page).to have_selector("[href='/Info/Contact-us.aspx']")
        #Percy::Capybara.snapshot(page, name: 'About us page')
      end

      it "click here to Email us - verify Email us Page" do
        page.click_link('About Us', href: '/Article/About-Us')
        find("[href='/Info/Contact-us.aspx']").click
        sleep 3
        expect(page).to have_content("Email us")
        #expect(page).to have_selector(".csp-header", :text => "Email us")
        expect(page).to have_selector("[id*='Name.First']")
        expect(page).to have_selector("[id*='Name.Last']")
        expect(page).to have_selector("[id*='Emails.PRIMARY.Address']")
        expect(page).to have_selector("[id*='Emails.PRIMARY.Address_Validate']")
        execute_script('window.scroll(0,500);')
        sleep 3
        expect(page).to have_selector("[id*='Phones.MOBILE.Number']")
        expect(page).to have_selector("[id*='order_id_text_field']")
        expect(page).to have_selector("[id*='Incident.Threads']")
        expect(page).to have_selector("#rn_FormSubmit_19_Button")
        #Percy::Capybara.snapshot(page, name: 'Email us page')
      end

      it "click here to Email us - verify a user can upload an image in case of Dameged item" do
        page.click_link('About Us', href: '/Article/About-Us')
        find("[href='/Info/Contact-us.aspx']").click
        sleep 3
        expect(page).to have_content("Email us")
        
        expect(page).to have_selector("upload-file-img")
        #expect(page).to have_selector(".uploader-input-file")
        #expect(page).to have_content("No file has been selected..")
      end

      it "click here to Email us - validation check with EMPTY input text" do
        page.click_link('About Us', href: '/Article/About-Us')
        find("[href='/Info/Contact-us.aspx']").click
        sleep 3
        execute_script('window.scroll(0,500);')
        sleep 3
        find("#rn_FormSubmit_19_Button").click
        expect(page).to have_selector("#rn_ErrorLocation")
        #expect(page).to have_selector(".EditingFormErrorLabel", :count => 4)
        #expect(page).to have_content("Please select subject of your inquiry")
      end

      it "click here to Email us - validation check with FULL input text and get Thank you for contacting page" do
        page.click_link('About Us', href: '/Article/About-Us')
        find("[href='/Info/Contact-us.aspx']").click
        sleep 3
        expect(page).to have_content("Email us")
        find("[id*='Name.First']").set("automation_test")
        find("[id*='Name.Last']").set("automation_test")
        find("[id*='Emails.PRIMARY.Address']").set("automation_test@novus.io")
        find("[id*='Emails.PRIMARY.Address_Validate']").set("automation_test@novus.io")
        execute_script('window.scroll(0,500);')
        sleep 3
        find("[id*='Phones.MOBILE.Number']").set("999999999999") 
        find("[id*='order_id_text_field']").set("70444567") 
        find("[id*='Incident.Threads']").set("automation_test: here is some text in the comments textbox")
        
        find("#rn_FormSubmit_19_Button").click
        expect(page).to have_selector(".thank-you-confirm-text.thank-you-confirm-title")
        expect(page).to have_selector(".thank-you-confirm-message")
        expect(page).to have_content("One of our representatives will respond to your email within the next 48h. 
        Thanks for your patience.")
        #Percy::Capybara.snapshot(page, name: 'Email us result page')
      end

    end

    it "Contact Us link" do
      page.click_link('Contact Us', href: '/Article/Contact-Us');
      expect(page).to have_selector("h1", :text => "Contact Us")
      expect(page).to have_selector(".article-content")
      expect(page).to have_selector("[href='/Info/Contact-us']")
      #Percy::Capybara.snapshot(page, name: 'Contact us page')
    end

    it "MyNameNecklace Reviews link" do
      page.click_link('MyNameNecklace Reviews', href: '/Article/MyNameNecklace-Reviews')
      expect(page).to have_selector("h1", :text => "MyNameNecklace Reviews")
      expect(page).to have_selector(".reviewsArticleContent")
      expect(page).to have_selector(".agile_carousel")
      #Percy::Capybara.snapshot(page, name: 'Reviews page')
    end

    it "Facebook icon link" do
      find("[href='https://www.facebook.com/mynamenecklaceIE']").click
      fb_window = page.driver.browser.window_handles.last
      within_window fb_window do
        expect(page).to have_current_path('https://www.facebook.com/mynamenecklaceIE', url: true)
        page.driver.browser.close
      end

    end

    it "Instagram icon link" do
      find("[href='https://www.instagram.com/mynamenecklace.ie']").click
      insta_window = page.driver.browser.window_handles.last
      within_window insta_window do
        expect(page).to have_current_path('https://www.instagram.com/mynamenecklace.ie/', url: true)
        page.driver.browser.close
      end
    end

  end

end


feature "AS a user i'm clicking on 4 upper bottom links in main page (with 'We promise secure shopping' topic) And verify i'm in the right page" , js: true, :order => :defined do

  describe "AS a user i'm Entering to each one of the links and verify content" do

    before (:each) do
      visit main_site
    end

    it "Free Delivery link" do
      #find("[href='/Article/Delivery-Information']")[0].click
      first('.footer-info-wrapper').click_link('Delivery Information')
      expect(page).to have_content("Delivery Methods & Charges")
      expect(page).to have_content("Estimated Delivery")
      expect(page).to have_content("Shipping Notification")
      expect(page).to have_selector(".article-content [href='/Article/FAQ?s=shipping#FaqArticle']")
      #Percy::Capybara.snapshot(page, name: 'Free Delivery page')
    end

    it "60 Day Returns link" do
      find("[href='/Article/Return-and-Cancellation-Policy']").click
      expect(page).to have_selector("h1", :text => "Return and Cancellation Policy")
      expect(page).to have_selector("h3", :text => "Return Policy")
      expect(page).to have_selector("h3", :text => "Cancellation Policy")
      expect(page).to have_selector(".article-content [href='/Info/Contact-us.aspx']")
      #Percy::Capybara.snapshot(page, name: '60 Day Returns page')
    end

    it "Secure Payment link" do
      find("[href='/Article/Payment-Policy']").click
      expect(page).to have_selector("h1", :text => "Payment Policy")
      expect(page).to have_selector(".article-content")
      expect(page).to have_selector("[alt='Foot_visa']")
      #expect(page).to have_selector("[alt='Foot_laser_ie']") #removed
      expect(page).to have_selector("[alt='Foot_mastercard']")
      expect(page).to have_selector("[alt='Foot_amex']")
      #expect(page).to have_selector("[alt='Foot_Maestro']") #removed
      expect(page).to have_selector("[alt='Paypal_verified_IE']")
      #Percy::Capybara.snapshot(page, name: 'Security payment page')
    end

    it "Gifts link" do
      find(".footerSecureBanner [href='/Products/Gifts/Personalised-Gifts']").click
      expect(page).to have_selector("h1", :text => "Personalised Gifts")
      expect(page).to have_selector(".searchSortBox")
      expect(page).to have_selector(".searchResultBox")
      #Percy::Capybara.snapshot(page, name: 'Gifts page')
    end

  end
end
