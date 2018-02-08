require './helpers/spec_helper.rb'

describe "AS a user i'm clicking on all bottom links in main page (about us, terms, etc...) And verify i'm in the right page and the page has the right functionality" , :feature => "AS a user i'm clicking on all bottom links in main page (about us, terms, etc...) And verify i'm in the right page and the page has the right functionality", :severity => :normal do

  before(:step) do |s|
    puts "Before step #{s.current_step}"
  end

  before (:each) do
      visit main_site_se
    end

it "Need Help link" , :story => "Need Help link", :severity => :normal do |e|

    e.step "Click link and check sections are present" do |s|
        within (".footer-articles-links") do 
        find("[href='/info/kundservice']", :text =>"KUNDSERVICE").click 
        end 
      expect(page).to have_selector(".NewArticleTitleh2", :text => "FRAKT OCH LEVERANS")
      expect(page).to have_selector(".NewArticleTitleh2", :text => "MIN BESTÄLLNING")
      expect(page).to have_selector(".NewArticleTitleh2", :text => "BETALNING")
      expect(page).to have_selector(".NewArticleTitleh2", :text => "RETUR OCH ÅTERBETALNING")
      expect(page).to have_selector(".NewArticleTitleh2", :text => "INFORMATION")
      expect(page).to have_selector(".NewArticleTitleh2", :text => "ALMÄNNA VILLKOR")
      expect(page).to have_selector(".NewArticleTitleh2", :text => "OM MITTNAMNHALSBAND")
      expect(page).to have_selector(".NewArticleTitleh2", :text => "KONTAKTA OSS")
      #Percy::Capybara.snapshot(page, name: 'need help link content from footer')
    end
     
    e.step "Click to open Worldwide section and check content" do |s|
        find(".faqBox .question span", text: "Vilka länder levererar ni till?").click
      expect(page).to have_selector("div.answer", :text => "Ja, vi levererar till hela världen. Klicka ", :visible => true)
        first(".faqBox .question span", text: "Fel kedjelängd").click
      expect(page).to have_selector("div.answer", :text => "Om vi råkat skicka fel kedjelängd skickar vi gärna en ny kedja till dig utan extra kostnad, som du själv får fästa.", :visible => true)
      #Percy::Capybara.snapshot(page, name: 'worldwide section')
    end
end
it "Track my order" , :story => "Track my order", :severity => :normal do |e|

    e.step "Track my order - verify content" do |s|
        within (".footer-articles-links") do 
        find("[href='/track-my-order']").click 
        end 
    expect(page).to have_selector(".EditingFormLabel", :text => "Beställnings ID nummer:")
    expect(page).to have_selector(".EditingFormLabel", :text => "Kund email:")
    expect(page).to have_selector(".FormButton[value='KOLLA BESTÄLLNINGSSTATUS']")
    
        end 
    e.step "Track my order - validations" do |s|
    #    page.click_link('Track My Order', href: '/Footer-menu-links/Need-Help/Track-My-Order')
       fill_in("Beställnings ID nummer:", with: "111")
       fill_in("Kund email:", with: "test")
       find(".btn-primary.FormButton").click
    # TO COMPLETE
    #    expect(page).to have_selector(".ErrorLabel", :text => "The entered values cannot be saved. Please see the fields below for details.")
    #    expect(page).to have_selector(".EditingFormErrorLabel", :text => "Please, enter valid e-mail.")
    #  end
      #Percy::Capybara.snapshot(page, name: 'Track my order form')
    end
end 
it "Delivery info link" , :story => "Delivery info link", :severity => :normal do |e|
    e.step "Cick link and check content" do |s|
      within (".footer-articles-links") do
        find("[href='/info/leverans-information']", :text => "LEVERANS INFORMATION").click
        end
      expect(page).to have_content("Fraktmetoder & Avgifter")
      expect(page).to have_content("Adressinformation")
      expect(page).to have_content("Leveransmeddelande")
      expect(page).to have_content("Beräknad leverans")
      #Percy::Capybara.snapshot(page, name: 'delivery info link from footer')
    end
end

it "Jewellery Size Guide link" , :story => "Jewellery Size Guide link", :severity => :normal do |e|
   

      e.step "Jewellery Size Guide - verify content" do |s|
        find("[href='/info/smycke-storleksguide']").click 
        
        expect(page).to have_content("HUR DU VÄLJER RÄTT LÄNGD PÅ ARMBANDET ?")
        expect(page).to have_content("HUR DU VÄLJER RÄTT RINGSTORLEK ?")
        expect(page).to have_content("HUR DU SKÖTER OM DINA PERSONLIGA SMYCKEN ?")
        expect(page).to have_selector("[href='/info/storleksguide-for-armband']")
        expect(page).to have_selector(".read-more[href='/info/storleksguide-for-ringar']")
        expect(page).to have_selector(".read-more[href='/info/vardinstruktioner']")
        #Percy::Capybara.snapshot(page, name: 'how to Sie guide')
      end

      e.step "Verify HOW TO SELECT THE CORRECT LENGTH? link" do |s|
        find("[href='/info/storleksguide-for-armband']").click 
        
        expect(page).to have_content("Hur mäter jag storleken på handleden?")
        #expect(page).to have_content("Hur kan jag bestämma kedjelängd?")
        expect(page).to have_selector("[alt='Bracelet size guide']")
        expect(page).to have_selector("[alt='how to measure bracelet size']")
        #Percy::Capybara.snapshot(page, name: 'How to Lenght guide')
      end

      e.step "verify HOW DO YOU SELECT CORRECT RING SIZE? link" do |s|
        find("[href='/info/smycke-storleksguide']").click
        find(".read-more[href='/info/storleksguide-for-ringar']").click
        
        expect(page).to have_content("STORLEKSGUIDE FÖR RINGAR")
        expect(page).to have_selector(".ringsTableBox")
        expect(page).to have_selector(".ringsGuideFooterWizardBtn")
        #Percy::Capybara.snapshot(page, name: 'how to ring size guide')
      end

      e.step "verify HOW DO YOU CONSIDER YOUR PERSONAL JEWELRY? link" do |s|
        find("[href='/info/smycke-storleksguide']").click
        find(".read-more[href='/info/vardinstruktioner']").click
        expect(page).to have_content("TA HAND OM DINA PERSONLIGA SMYCKEN")
        expect(page).to have_content("1. Sätt på smycken efter makeup.")
        expect(page).to have_content("2. Vid rengörning ta av smyckerna")
        expect(page).to have_content("3. Smycken vill inte vara med i swimmingpoolen")
        expect(page).to have_content("4. Inga smycken i badkaret")
        expect(page).to have_content("5. Förvara smyckerna rätt.")
        expect(page).to have_content("Särskild omsorg för personliga smycken i guld och silver")
        #Percy::Capybara.snapshot(page, name: 'how do you cinsider your jewerly page')
    
      end

      

    end

it "Care Instructions link" , :story => "Care Instructions link", :severity => :normal do |e|
   e.step "Check Care Instructions page content" do |s|
      find("[href='/info/vardinstruktioner']").click
      expect(page).to have_content("TA HAND OM DINA PERSONLIGA SMYCKEN")
      expect(page).to have_content("Särskild omsorg för personliga smycken i guld och silver")
      #Percy::Capybara.snapshot(page, name: 'Care instructions page')
    end
end 

it "Chain collection link" , :story => "Chain collection link", :severity => :normal do |e|
    e.step "Check Chain collection page content" do |s|
        find("[href='/info/kedjekollektion']").click
        expect(page).to have_content("KEDJEKOLLEKTION")
        expect(page).to have_content("Drottninglänk")
        expect(page).to have_content("Kulkedja")
        expect(page).to have_content("Figaro Kedja")
        expect(page).to have_content("Ärtlänkskedja")
        expect(page).to have_content("Twist Kedja")
        #Percy::Capybara.snapshot(page, name: 'Chain collection page')
   end
end
it "FAQ link" , :story => "FAQ link", :severity => :normal do |e|
    e.step "FAQ link checking" do |s|
      find("[href='/info/vanliga-fragor']").click
      expect(page).to have_content("VANLIGA FRÅGOR - FAQ")
      find(".question span", :text => "Hur kan jag annulera en beställning?").click
      #wait_for_ajax
      #expect(page).to have_selector("div.answer", :text => "Orders must be cancelled within 24 hours after placing the order, as all our items are personalised and therefore custom made.", :visible => true)
      # expect(page).to have_selector("div.answer", :text => "Beställningar måste avbeställas inom 12 timmar efter att du skickat in din beställning eftersom våra smycken är personligt anpassade och specialtillverkade." , :visible => true) #changed since last changes from prod DB
      expect(page).to have_selector("div.answer", :text => "Om du har några mera frågor angående avbeställning, så vänligen " , :visible => true) #changed by @Andrew by QA SE state
      expect(page).to have_content("RETURER OCH ÅTERBETALNINGAR")
      expect(page).to have_content("BEHÖVER DU HJÄLP?")
      expect(page).to have_content("BETALNINGAR")
      expect(page).to have_content("Våra produkter")
      #Percy::Capybara.snapshot(page, name: 'FAQ page')
    end
end
it "Tips and Advice link" , :story => "Tips and Advice link", :severity => :normal do |e|
    e.step "Tips and Advice link checking" do |s|
      find("[href='/info/kopguide']").click 
      expect(page).to have_content("KÖPGUIDE")
      expect(page).to have_content("Information om våra produkter:")
      expect(page).to have_content("Om oss:")
      expect(page).to have_content("För mer information se nedanstående artiklar:")
      #Percy::Capybara.snapshot(page, name: 'Advice page')
    end
end 
it "Terms and conditions link" , :story => "Terms and conditions link", :severity => :normal do |e|
    e.step "Terms and conditions link" do |s|
      within (".footer-articles-links") do
        first("[href='/info/allmanna-villkor']").click
      end 
      expect(page).to have_content("MITTNAMNHALSBAND ALLMÄNNA VILLKOR")
      expect(page).to have_content("Sekretess")
      expect(page).to have_content("Cookiepolicy")
      expect(page).to have_content("Leverans, tullavgifter, tillägg och skatter")
      expect(page).to have_content("Friskrivning och ansvarsbegränsning")
      expect(page).to have_content("Klarna villkor och regler")
      expect(page).to have_content("Marknadsförings användning av din personliga information")
      expect(page).to have_content("Kontakta MittNamnhalsband")
      #Percy::Capybara.snapshot(page, name: 'T&C page')
   end
end 

 #   it "Privacy Policy link" do #the same as terms and conditions above
 #     page.click_link('Privacy Policy', href: '/Article/Privacy-Policy')
 #     expect(page).to have_selector("h1", :text => "Privacy Policy")
 #     expect(page).to have_content("When you register at our site")
 #     expect(page).to have_selector(".article-content")
 #   end
it "Payment Policy link" , :story => "Payment Policy link", :severity => :normal do |e|
    e.step "Payment Policy link" do |s|
      find("[href='/info/betalningspolicy']").click
      expect(page).to have_content("BETALNINGSPOLICY")
      within (".NewArticle-wrap") do
        expect(page).to have_selector("[alt='Klarna']")
        expect(page).to have_selector("[alt='Visa']")
        expect(page).to have_selector("[alt='MasterCard']")
        expect(page).to have_selector("[alt='Banktransaktion']")
        expect(page).to have_selector("[alt='Nordea Bank']")
        expect(page).to have_selector("[alt='Amex']")
        expect(page).to have_selector("[alt='Visa Electron']")
        end 
      expect(page).to have_selector("[alt='PayPal Verified']")
      #Percy::Capybara.snapshot(page, name: 'Payment policy page')
    end
end 
it "Return and Cancellation Policy link" , :story => "Return and Cancellation Policy link", :severity => :normal do |e|
   e.step "Return and Cancellation Policy link" do |s|
    within (".footer-articles-links") do
    find("[href='/info/avbestallnings-och-returneringspolicy']").click
    end 
      expect(page).to have_content("RETUR OCH AVBOKNINGSREGLER")
      expect(page).to have_content("Returpolicy")
      expect(page).to have_content("Avbokningsregler")
    #Percy::Capybara.snapshot(page, name: 'Return Cancellation page')
    end
end 

it "About Us - verify content" , :story => "About Us - verify content", :severity => :normal do |e|
   e.step "About Us - verify content" do |s|
        find("[href='/info/om-oss']").click
        expect(page).to have_content("OM OSS")
        expect(page).to have_selector(".pagesContent")
        #Percy::Capybara.snapshot(page, name: 'About us page')
      end
end
it "verify Email us Page" , :story => "verify Email us Page", :severity => :normal do |e|
      
      e.step "verify Email us Page content" do |s|
        within (".footer-articles-links") do 
        find("[href='/info/kundservice']", :text =>"KONTAKTA OSS").click 
        end 
        find("[href='/contact-us']", :text =>"✉ SKICKA ETT EMAIL TILL OSS").click
        sleep 2
        expect(page).to have_content("SKICKA ETT EMAIL TILL OSS") #Error "Required form 'GeneralQuestion' does not exist."
        expect(page).to have_content("NAMN:")
        expect(page).to have_content("E-POST:")
        expect(page).to have_content("BESTÄLLNINGS-ID:")
        expect(page).to have_content("TELEFON:")
        expect(page).to have_content("ÄMNE:")
        expect(page).to have_content("KOMMENTARER:")
        expect(page).to have_selector(".btn-primary")
        #Percy::Capybara.snapshot(page, name: 'Email us')
      end
      e.step "click here to Email us - verify a user can upload an image in case of Dameged item" do |s|
      #wait until form is customized properly
        # page.click_link('About Us', href: '/Article/About-Us')
        # find("[href='/Info/Contact-us.aspx']").click
        # expect(page).to have_selector("h1", :text => "EMAIL US")
        # expect(page).to have_selector(".EditingFormLabel", :text => "NAME:")
        # expect(page).to have_selector(".EditingFormLabel", :text => "Email:")
        # expect(page).to have_selector(".EditingFormLabel", :text => "ORDER ID:")
        # expect(page).to have_selector(".EditingFormLabel", :text => "TELEPHONE:")
        # expect(page).to have_selector(".EditingFormLabel", :text => "SUBJECT:")
        # select("Damaged Item",from: "SUBJECT:")
        # expect(page).to have_selector(".EditingFormLabel", :text => "COMMENTS:")
        # expect(page).to have_selector(".FormButton[value='Send Email']")
        # expect(page).to have_selector(".uploader-input-file")
        # expect(page).to have_content("No file has been selected..")
      end
      e.step "click here to Email us - validation check with EMPTY input text" do |s|
      #wait until form is customized properly
        # page.click_link('About Us', href: '/Article/About-Us')
        # find("[href='/Info/Contact-us.aspx']").click
        # click_button "Send Email"
        # expect(page).to have_selector(".ErrorLabel", :text => "Please fill in the required fields")
        # expect(page).to have_selector(".EditingFormErrorLabel", :count => 4)
        # expect(page).to have_content("Please select subject of your inquiry")
      end
      e.step "click here to Email us - validation check with FULL input text and get Thank you for contacting page" do |s|
      
      #wait until form is customized properly
      #   page.click_link('About Us', href: '/Article/About-Us')
      #   find("[href='/Info/Contact-us.aspx']").click
      #   fill_in("NAME:", with: "automation_test")
      #   fill_in("Email:", with: "automation_test@novus.io")
      #   fill_in("ORDER ID:", with: "70444567")
      #   fill_in("TELEPHONE:", with: "999999999999")
      #   select("Change My Shipping Method",from: "SUBJECT:")
      #   expect(page).to have_selector(".ExplanationText [href='/Article/Delivery-Information']")
      #   fill_in("COMMENTS:", with: "automation_test: here is some text in the comments textbox")
      #   click_button "Send Email"
      #   expect(page).to have_selector("h1", :text => "Thank you for contacting MyNameNecklace")
      #   expect(page).to have_content("One of our representatives will respond to your email as fast as we can, and will respond to each and every one of you. ")
      end

    end
it "Review link" , :story => "Review link", :severity => :normal do |e|
    e.step "Review link" do |s|
      within (".footer-articles-links") do
        find("[href='/info/recensioner']").click
      end 
      expect(page).to have_content("SÅ HÄR SÄGER NYBLIVNA KUNDER OM OSS")
      #Percy::Capybara.snapshot(page, name: 'Review page')
    end
end 
it "Blog link" , :story => "Blog link", :severity => :normal do |e|
    e.step "Review link" do |s|
      find("[href='/Blog']").click
      expect(page).to have_content("MITTNAMNHALSBAND BLOG")
      expect(page).to have_selector(".blog-hp-inner")
      #Percy::Capybara.snapshot(page, name: 'Blog page')
    end
end 
it "Social network icons" , :story => "Social network icons", :severity => :normal do |e|
  e.step "Facebook icon link" do |s|  
      expect(page).to have_selector("[title='Facebook']")
      expect(page).to have_selector("[href='https://www.facebook.com/MittNamnhalsband']")
      

  end
  e.step "Instagram icon link" do |s| 
    expect(page).to have_selector("[title='Instagram']")
    expect(page).to have_selector("[href='https://www.instagram.com/mittnamnhalsband/']")
      
  end

end

end


describe "AS a user i'm clicking on 3 upper bottom links in main page And verify i'm in the right page" , :feature => "AS a user i'm clicking on 3 upper bottom links in main page And verify i'm in the right page", :severity => :normal do

  before(:step) do |s|
    puts "Before step #{s.current_step}"
  end


    it "AS a user i'm Entering to each one of the links and verify content" , :story => "AS a user i'm Entering to each one of the links and verify content", :severity => :normal do |e|
    
      e.step "Free Delivery link" do |s| 
 
      visit main_site_se
      find(".hp-free-shipping").click
       expect(page).to have_content("FRAKT OCH LEVERANS INFORMATION")
       expect(page).to have_content("Fraktmetoder & Avgifter")
       expect(page).to have_content("Adressinformation")
       expect(page).to have_content("Leveransmeddelande")
       expect(page).to have_content("Beräknad leverans")
      #Percy::Capybara.snapshot(page, name: 'Delivery page')
    end
    
    e.step "60 Day Returns link" do |s| 
      visit main_site_se
      find(".hp-days-returns").click
      
      expect(page).to have_content("RETUR OCH AVBOKNINGSREGLER")
      expect(page).to have_content("Returpolicy")
      expect(page).to have_content("Avbokningsregler")
      #Percy::Capybara.snapshot(page, name: '60 days return page')
    end
    
    e.step "Secure Payment link" do |s| 
      visit main_site_se
       find(".hp-secure-payment").click
        expect(page).to have_content("VI GARANTERAR SÄKER SHOPPING")
        expect(page).to have_content("SÄKER BETALNING")
        expect(page).to have_content("GARANTI")
        expect(page).to have_content("FRAKT INFORMATION")
        expect(page).to have_content("RETUR SERVICE")

       #Percy::Capybara.snapshot(page, name: 'Security payment page')
    end

end
 

end
