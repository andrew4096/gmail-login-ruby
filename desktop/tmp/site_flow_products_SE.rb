require './helpers/spec_helper.rb'

describe "As a user i'm adding all type of products to the shopping cart: Necklaces, Bracelets, Rings, Keychains, and verify their functionality and validation" , :feature => "As a user i'm adding all type of products to the shopping cart: Necklaces, Bracelets, Rings, Keychains, and verify their functionality and validation", :severity => :normal do

  before(:step) do |s|
    puts "Before step #{s.current_step}"
  end

  before (:each) do
      visit main_site_se
    end

  it "Infinity-style name necklace - next-generation collection", :story => "Infinity-style name necklace - next-generation collection", :severity => :normal do |e|


    e.step "product images and slider" do |s|
      #search_product ("Namnhalsband i infinity-stil")
      visit ("#{main_site_se}/product/namnhalsband-i-infinity-stil-nasta-generationens-kollektion")
      
      product_image_slider
    end

    e.step "validators for empty fields and max chars check" do |s|
      visit ("#{main_site_se}/product/namnhalsband-i-infinity-stil-nasta-generationens-kollektion")
      #visit main_site_se
      #search_product ("Namnhalsband i infinity-stil")
      add_product_to_basket
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oj då, glöm inte att göra det personligt!")
      page.all("input.form-control[type='text']")[0].set("more than 10")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "Texten kan inte vara längre än 9 tecken.")
    end

    e.step "price comparison + price comparison on adding more birthstones" do |s|
      
      @listprice = find('.originalPrice').text.slice!(0..-4).to_i
      p @listprice
      @finalprice = find('.finalPrice').text.slice!(0..-4).to_i
      p @finalprice
      @yousave_price = find("[id*='PriceSaving']").text.slice!(0..-10).to_i
      p @yousave_price 
      (@listprice - @finalprice).should eq(@yousave_price)
    end

    e.step "description and modal links" do |s|
      
      find(".ajax__tab_tab", :text => "INFORMATION").click
      expect(page).to have_selector("[id*='TabsLayout_tabs_tab3'].ajax__tab_panel", :visible => true)
      
    end

    e.step "You may also like products are visible" do |s|
      expect(page).to have_selector("[itemprop='name']", :text => "Namnhalsband i infinity-stil - nästa generationens kollektion")
      expect(page).to have_selector(".alsoLikeItems")
      expect(page).to have_selector(".related-prod-item", :count => 4)
      #Percy::Capybara.snapshot(page, name: 'namnhalsband Product page details')
    end

  end

it "NECKLACE with dynamic price option - Family Tree Birthstone Necklace", :story => "NECKLACE with dynamic price option - Family Tree Birthstone Necklace" , :severity => :normal do |e|

    e.step "visit product page" do |s|
      visit ("#{main_site_se}/product/manadsstens-familjetrad-halsband")
 
    end

    e.step "validators for empty fields and max chars check" do |s|
      expect(page).to have_selector("[itemprop='name']", :text => "Månadsstens Familjeträd halsband")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oj då, glöm inte att göra det personligt!", :count => 2)
      
      first("input.form-control[type='text']").set("test1")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oj då, glöm inte att göra det personligt!", :count => 1)
    end

    e.step "You may also like products are visible" do |s|
      alsolike ("Månadsstens Familjeträd halsband")
    end

    e.step "price comparison" do |s|
      expect(page).to have_selector("[itemprop='name']", :text => "Månadsstens Familjeträd halsband")
      comparepricesave_se
      
      $final_price_before = find('.finalPrice').text.slice!(0..-4).to_i
    end

    e.step "show and hide functionality + adding to shopping cart verification" do |s|
      
      expect(page).to have_selector(".ProductOptionSelector", :count => 5) 
      select("4 Inskriptioner + 4 Månadsstenar (+ 150 kr)", from: "Välj gravyr alternativ:")
      expect(page).to have_selector(".ProductOptionSelector", :count => 11)
      select("Januari - Granat", from: "Första månadsstenen: SE")
      select("Januari - Granat", from: "Andra månadsstenen:")
      select("Januari - Granat", from: "Tredje månadsstenen:")
      select("Januari - Granat", from: "Fjärde månadsstenen:")
      
      page.all("input.form-control[type='text']")[1].set("test1")
      page.all("input.form-control[type='text']")[2].set("test1")
      page.all("input.form-control[type='text']")[3].set("test1")
      
    end

    e.step "price comparison on adding more birthstones" do |s|
      comparepricesave_se
      $final_price_after = find('.finalPrice').text.slice!(0..-4).to_i
      expect($final_price_after).to be > ($final_price_before)
      #Percy::Capybara.snapshot(page, name: 'halsband Product page details')
    end 


    e.step "description and modal links" do |s|
      expect(page).to have_selector("[itemprop='name']", :text => "Månadsstens Familjeträd halsband")
      find(".ajax__tab_tab", :text => "INFORMATION").click
      expect(page).to have_selector("[id*='TabsLayout_tabs_tab3'].ajax__tab_panel", :visible => true)
      find(".ajax__tab_tab", :text => "INSTRUKTIONER").click
      expect(page).to have_selector("[id*='TabsLayout_tabs_tab2'].ajax__tab_panel", :visible => true)
      expect(page).to have_selector(".Instruction")
      page.all(".modal-toggle")[0].click
      sleep 3
      expect(page).to have_selector(".modal-title", :text => "Hur du väljer Kedjelängd?")
      expect(page).to have_selector(".modal-body")
      find(".close").click
      sleep 2
    end

    e.step "product images and slider" do |s|
      expect(page).to have_selector("[itemprop='name']", :text => "Månadsstens Familjeträd halsband")
      product_image_slider
    end
    

  end


  it "BRACELET with single name - Engraved Silver Infinity Bracelet", :story => "BRACELET with single name - Engraved Silver Infinity Bracelet", :severity => :normal do |e|

    e.step "open product page" do |s|
      visit ("#{main_site_se}/product/graverat-silver-infinity-armband")
      
    end

    e.step "validators for empty fields and max chars check" do |s|
      first("input.form-control[type='text']").set("1234567890")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "Texten kan inte vara längre än 9 tecken.")
    end

    e.step "You may also like products are visible" do |s|
      alsolike ("Graverat Silver Infinity Armband")
      #Percy::Capybara.snapshot(page, name: 'Armband Product page details')
    end

    

    

    e.step "price comparison" do |s|
      comparepricesave_se
    end

    e.step "description and modal links" do |s|
      
      find(".ajax__tab_tab", :text => "INFORMATION").click
      expect(page).to have_selector("[id*='TabsLayout_tabs_tab3'].ajax__tab_panel", :visible => true)
      find(".ajax__tab_tab", :text => "INSTRUKTIONER").click
      expect(page).to have_selector("[id*='TabsLayout_tabs_tab2'].ajax__tab_panel", :visible => true)
      expect(page).to have_selector(".Instruction")
      page.all(".modal-toggle")[0].click
      sleep 5
      expect(page).to have_selector(".modal-title", :text => "Hur mäter jag storleken på handleden?")
      expect(page).to have_selector(".modal-body")
      find(".close").click
      sleep 3

      page.all(".modal-toggle")[1].click
      sleep 5
      expect(page).to have_selector(".modal-title", :text => "Speciella Inledande Font")
      expect(page).to have_selector(".modal-body")
      page.all(".close")[1].click
      sleep 3


      page.all(".modal-toggle")[2].click
      sleep 5
      expect(page).to have_selector(".modal-title", :text => "Barns Säkerhet")
      expect(page).to have_selector(".modal-body")
      page.all(".close")[2].click
      sleep 2
    end

    

    e.step "product images and slider" do |s|
      product_image_slider
    end

    e.step "adding to shopping cart verification" do |s|
      visit ("#{main_site_se}/product/graverat-silver-infinity-armband")
      expect(page).to have_selector("[itemprop='name']", :text => "Graverat Silver Infinity Armband")
      expect(page).to have_selector(".ProductOptionSelector", :count => 4)
      page.all("input.form-control[type='text']")[0].set("auto_test")
      find(".AddToCartLink").click
      find(".items-table", wait: 7).click
      expect(page).to have_content("Graverat Silver Infinity Armband")
    end

  end

  it "RING with single name - Graverad namnring - Handgraverad stil", :story => "RING with single name - Graverad namnring - Handgraverad sti", :severity => :normal do |e|

    e.step "Visit prodcut page" do |s|
      visit ("#{main_site_se}/product/graverad-namnring-handgraverad-stil")
    end 

    e.step "You may also like products are visible" do |s|
      
      alsolike ("Graverad namnring - Handgraverad stil")
      #Percy::Capybara.snapshot(page, name: 'Also like section')
    end

    

    e.step "validators for empty fields and max chars check" do |s|
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oj då, glöm inte att göra det personligt!", :count => 2)
      select("54", from: "Välj ringstorlek:")
      
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oj då, glöm inte att göra det personligt!", :count => 1)
      sleep 3
      
      page.all("input.form-control[type='text']")[0].set("this is a text with more then 24 chars test")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "Texten kan inte vara längre än 24 tecken")
    end

    e.step "price comparison" do |s|
      comparepricesave_se
      #Percy::Capybara.snapshot(page, name: 'Ring Product page details')
    end

    e.step "description and modal links" do |s|
      find(".ajax__tab_tab", :text => "INFORMATION").click
      expect(page).to have_selector("[id*='TabsLayout_tabs_tab3'].ajax__tab_panel", :visible => true)
      find(".ajax__tab_tab", :text => "INSTRUKTIONER").click
      expect(page).to have_selector("[id*='TabsLayout_tabs_tab2'].ajax__tab_panel", :visible => true)
      expect(page).to have_selector(".Instruction")
      page.all(".modal-toggle")[1].click
      sleep 5
      expect(page).to have_selector(".modal-title", :text => "Storleksguide för ringar")
      expect(page).to have_selector(".modal-body")
      find(".close").click
      sleep 5

      # page.all(".modal-toggle")[1].click
      # sleep 5
      # expect(page).to have_selector(".modal-title", :text => "Barns Säkerhet")
      # expect(page).to have_selector(".modal-body")
      # find(".close").click
      # sleep 5

    end

    e.step "product images and slider" do |s|
      product_image_slider
      #Percy::Capybara.snapshot(page, name: 'Product image slider')
    end

    e.step "adding to shopping cart verification" do |s|
      visit ("#{main_site_se}/product/graverad-namnring-handgraverad-stil")
      select("54", from: "Välj ringstorlek:")
      page.all("input.form-control[type='text']")[1].set("auto_test")
      find(".AddToCartLink").click
      find(".items-table", wait: 7).click
      expect(page).to have_content("Graverad namnring - Handgraverad stil")
    end

    

  end


  it "KEYCHAIN with single name - Personligt ingraverad Nyckelring", :story => "KEYCHAIN with single name - Personligt ingraverad Nyckelring", :severity => :normal do |e|

    e.step "visit product page" do |s|
      visit ("#{main_site_se}/product/personligt-ingraverad-nyckelring")
    end

    e.step "You may also like products are visible" do |s|
      
      alsolike ("Personligt ingraverad Nyckelring")
    end

    e.step "price comparison" do |s|
      comparepricesave_se
      #Percy::Capybara.snapshot(page, name: 'Keychain Product page details')
    end

    e.step "validators for empty fields and max chars check" do |s|
      
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oj då, glöm inte att göra det personligt!") #Message text is changed after update from prod DB
      
      sleep 3
      page.all("input.form-control[type='text']")[0].set("this is a text with more then 8 chars test")
      #wait_for_ajax
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "Texten kan inte vara längre än 8 tecken.")
      
  end


  e.step "description and modal links" do |s|
    find(".ajax__tab_tab", :text => "INFORMATION").click
    expect(page).to have_selector("[id*='TabsLayout_tabs_tab3'].ajax__tab_panel", :visible => true)
    find(".ajax__tab_tab", :text => "INSTRUKTIONER").click
    expect(page).to have_selector("[id*='TabsLayout_tabs_tab2'].ajax__tab_panel", :visible => true)
    expect(page).to have_selector(".Instruction")
    page.all(".modal-toggle")[0].click
    sleep 7
    expect(page).to have_selector(".modal-title", :text => "Barns Säkerhet")
    expect(page).to have_selector(".modal-body")
    find(".close").click
    sleep 5


  end

    e.step "adding to shopping cart verification" do |s|
      
      expect(page).to have_selector(".ProductOptionSelector", :count => 3)
      
      page.all("input.form-control[type='text']")[0].set("autotest")
      find(".AddToCartLink").click
      sleep 3
      find(".items-table", wait: 7).click
      expect(page).to have_content("Personligt ingraverad Nyckelring")
    end

    

    e.step "product images and slider + products statis" do |s|
      visit ("#{main_site_se}/product/personligt-ingraverad-nyckelring")
      product_image_slider
    end

  end

it "Gift Box - only a Gift Box", :story => "Gift Box - only a Gift Box", :severity => :normal do |e|

    e.step "Visit giftbox page" do |s|
      visit ("#{main_site_se}/product/presentask")
    end

    e.step "You may also like products are visible" do |s|
      
      alsolike ("Presentask")
    end



    e.step "validators for max chars check" do |s|
      
      find("textarea.form-control").set("test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test")
      find(".AddToCartLink").click
      expect(page).to have_selector(".ErrorLabel", :text => "Texten kan inte vara längre än 280 tecken.")
    end

    

    e.step "description and modal links" do |s|
      find(".ajax__tab_tab", :text => "INFORMATION").click
      expect(page).to have_selector("[id*='TabsLayout_tabs_tab3'].ajax__tab_panel", :visible => true)
      find(".ajax__tab_tab", :text => "INSTRUKTIONER").click
      expect(page).to have_selector("[id*='TabsLayout_tabs_tab2'].ajax__tab_panel", :visible => true)
      expect(page).to have_selector(".Instruction")
      page.all(".modal-toggle")[0].click
      sleep 7
      expect(page).to have_selector(".modal-title", :text => "Barns Säkerhet")
      expect(page).to have_selector(".modal-body")
      find(".close").click
      sleep 5
      #Percy::Capybara.snapshot(page, name: 'Gift descirption section')
  
    end

    e.step "adding to shopping cart verification" do |s|
      
      find("textarea.form-control").set("test test test giftbox")
      find(".AddToCartLink").click
      find(".items-table", wait: 7).click
      expect(page).to have_selector(".item-name", :text => "Presentask")
    end

    

  end
end


describe "As a user i'm adding all type of products to the shopping cart from: You May Also Like , Footer Reviews Carusel" , :feature => "As a user i'm adding all type of products to the shopping cart from: You May Also Like , Footer Reviews Carusel", :severity => :normal do

  it "Add any product from You may aslo like offers (any of 4 of them)", :story => "Add any product from You may aslo like offers (any of 4 of them", :severity => :normal do |e|

    e.step "visit site and click 1st product from Also like section" do |s|
      visit main_site_se
      page.all(".best-seller-name")[0].click
      @productname = find(".related-prod-name", match: :first).text
      find(".related-prod-item", match: :first).click
    end
    
    e.step "checking if a click on one item from you may also like, takes us to the product page " do |s|
      expect(page).to have_selector("[itemprop='name']", :text => @productname)
    end

    e.step "You may also like products are visible" do |s|
      
      alsolike (@productname)
    end

    e.step "price comparison" do |s|
      comparepricesave_se
      #Percy::Capybara.snapshot(page, name: 'Product page details from You may also like section')
    end

  end

  it "Add any product from Footer Reviews Carusel (3 products)", :story => "Add any product from Footer Reviews Carusel (3 products)", :severity => :normal do |e|

    e.step "Open 1slide 1st prodcut" do |s|
      visit main_site_se
      find(".hp-banner", match: :first).click
      find(".catProductTeaser.first").click
      @productname = find("[itemprop='name']").text
    end

    e.step "checking if a click on one item from you may also like, takes us to the product page " do |s|
      expect(page).to have_selector("[itemprop='name']", :text => @productname)
    end

    e.step "You may also like products are visible" do |s|
      
      alsolike (@productname)
    end

    e.step "price comparison" do |s|
      comparepricesave_se
    end

  end

end 


 
