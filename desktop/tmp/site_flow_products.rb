require './helpers/spec_helper.rb'

feature "As a user i'm adding all type of products to the shopping cart: Necklaces, Bracelets, Rings, Keychains, and verify their functionality and validation" , js: true, :order => :defined do

  describe "NECKLACE with single name - Sterling Silver Classic Name Necklace" do

    before (:each) do
      visit main_site
      #first("[href='/Category/Full-Necklace-Collection']", wait: 2).click
      first('.sideBar').click_link('Necklaces')
      #find("[title='See detail of Sterling Silver Classic Name Necklace']").click
      visit ("#{main_site}Products/All-Necklaces/Sterling-Silver-Classic-Name-Necklace")
    end

    it "product images and slider" do
      expect(page).to have_selector("[itemprop='name']", :text => "Sterling Silver Classic Name Necklace")
      expect(page).to have_selector(".productMainImageContainer")
      expect(page).to have_selector(".smallImagesBox")
      find(".productMainImageContainer").click
      expect(page).to have_selector(".boxOverlay[style='display: block;']")
      find(".bigImgInnerBox .nextImg").click
      expect(page).to have_selector(".preImg[style='display: block;']")
      find(".bigImgInnerBox .nextImg").click
      #Percy::Capybara.snapshot(page, name: 'Product slider')
    end

    it "validators for empty fields and max chars check" do
      expect(page).to have_selector("[itemprop='name']", :text => "Sterling Silver Classic Name Necklace")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oops, don\u2019t forget to personalize it!")
      page.all("input.form-control[type='text']")[0].set("this is a text with more then 20 chars test")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "Text has to be no more than 10 characters long")
    end

    it "price comparison + price comparison on adding more birthstones" do
      expect(page).to have_selector("[itemprop='name']", :text => "Sterling Silver Classic Name Necklace")
      @listprice = find('.originalPrice').text.slice!(1..-1).to_i
      @finalprice = find('.finalPrice').text.slice!(1..-1).to_i
      @yousave_price = find('div.productInfoLine.instantSavings span:nth-child(2)').text.slice!(1..-7).to_i
      (@listprice - @finalprice).should eq(@yousave_price)
    end

    it "description and modal links" do
      expect(page).to have_selector("[itemprop='name']", :text => "Sterling Silver Classic Name Necklace")
      find(".fa-plus", :text => "INFORMATION").click
      expect(page).to have_selector(".fa-minus.productDescHeader", :text => "INFORMATION")
      find(".fa-plus", :text => "INSTRUCTIONS").click
      sleep 3
      find(".Instruction .modal-toggle[data-modal-binding='Chain-Length-Guide']").click
      sleep 3
      expect(page).to have_selector("#Chain-Length-Guide")
      expect(page).to have_selector("button.close[type='button'][data-dismiss='modal']")
      expect(page).to have_css("div[style='text-align: center;']")
      find("#Chain-Length-Guide button.close").click
      find(".modal-toggle[data-modal-binding='Kids-Safety-Policy']").click
      expect(page).to have_selector("#Kids-Safety-Policy.modal[style='display: block; padding-right: 17px;']")
      find("#Kids-Safety-Policy button.close").click
    end

    it "adding to shopping cart verification" do
      expect(page).to have_selector("[itemprop='name']", :text => "Sterling Silver Classic Name Necklace")
      expect(page).to have_selector(".ProductOptionSelector", :count => 2) #page generation has been changed, now it's 3 items with such selector'
      page.all("input.form-control[type='text']")[0].set("auto_test")
      find(".AddToCartLink").click
      find(".shopping-cart-wrapper .items-table", wait: 7).click
      expect(page).to have_content("Sterling Silver Classic Name Necklace")
    end

    it "You may also like products are visible" do
      expect(page).to have_selector("[itemprop='name']", :text => "Sterling Silver Classic Name Necklace")
      expect(page).to have_selector(".alsoLikeTitle", :text => "You may also like")
      expect(page).to have_selector(".alsoLikeitem", :count => 4)
    end

  end

  describe "NECKLACE with dynamic price option - Family Tree Birthstone Necklace" do

    before (:each) do
      visit main_site
      #first("[href='/Category/Full-Necklace-Collection']", wait: 2).click
      first('.sideBar').click_link('Necklaces')
      #find("[title='See detail of Family Tree Floating Locket with Birthstones']").click
      visit ("#{main_site}Products/All-Necklaces/Family-Tree-Floating-Locket-with-Birthstones") 
    end

    it "validators for empty fields and max chars check" do
      expect(page).to have_selector("[itemprop='name']", :text => "Family Tree Floating Locket with Birthstones")
      find(".AddToCartLink").click
      #expect(page).to have_selector(".OptionCategoryError", :text => "Please select an option") # Message is changed due to update from prod DB
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oops, don\u2019t forget to personalize it!")
      select("3 Birthstones (+ €10)", from: "Select number of birthstones:")
      select("February - Amethyst", from: "1st birthstone:")
      find(".AddToCartLink").click
      #expect(page).to have_selector(".OptionCategoryError", :text => "Please select an option") # Message is changed due to update from prod DB
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oops, don\u2019t forget to personalize it!")
      #Percy::Capybara.snapshot(page, name: 'Product fields validations')
    end

    it "show and hide functionality + adding to shopping cart verification" do
      expect(page).to have_selector("[itemprop='name']", :text => "Family Tree Floating Locket with Birthstones")
      expect(page).to have_selector(".ProductOptionSelector", :count => 4) # Count is changed due to update from prod DB
      select("7 Birthstones (+ €30)", from: "Select number of birthstones:")
      expect(page).to have_selector(".ProductOptionSelector", :count => 10)
      select("February - Amethyst", from: "1st birthstone:")
      select("February - Amethyst", from: "2nd birthstone:")
      select("May - Emerald", from: "3rd birthstone:")
      select("July - Ruby", from: "4th birthstone:")
      select("July - Ruby", from: "5th birthstone:")
      select("August - Peridot", from: "6th birthstone:")
      select("August - Peridot", from: "7th birthstone:")
      find(".AddToCartLink").click
      sleep 3
      find(".shopping-cart-wrapper .items-table").click
      expect(page).to have_content("Family Tree Floating Locket with Birthstones")
    end

    it "product images and slider" do
      expect(page).to have_selector("[itemprop='name']", :text => "Family Tree Floating Locket with Birthstones")
      expect(page).to have_selector(".productMainImageContainer")
      expect(page).to have_selector(".smallImagesBox")
      find(".productMainImageContainer").click
      expect(page).to have_selector(".boxOverlay[style='display: block;']")
      find(".bigImgInnerBox .nextImg").click
      expect(page).to have_selector(".preImg[style='display: block;']")
      find(".bigImgInnerBox .nextImg").click
      find(".bigImgInnerBox .nextImg").click
    end

    it "price comparison + price comparison on adding more birthstones" do
      expect(page).to have_selector("[itemprop='name']", :text => "Family Tree Floating Locket with Birthstones")
      @listprice = find('.originalPrice').text.slice!(1..-1).to_i
      @finalprice = find('.finalPrice').text.slice!(1..-1).to_i
      @yousave_price = find('div.productInfoLine.instantSavings span:nth-child(2)').text.slice!(1..-7).to_i
      (@listprice - @finalprice).should eq(@yousave_price)
      # after adding more Birthstones
      select("7 Birthstones (+ €30)", from: "Select number of birthstones:")
      expect(page).to have_selector(".ProductOptionSelector", :count => 10)
      @listprice = find('.originalPrice').text.slice!(1..-1).to_i
      @finalprice = find('.finalPrice').text.slice!(1..-1).to_i
      @yousave_price = find('div.productInfoLine.instantSavings span:nth-child(2)').text.slice!(1..-7).to_i
      (@listprice - @finalprice).should eq(@yousave_price)
    end

    it "description and modal links" do
      expect(page).to have_selector("[itemprop='name']", :text => "Family Tree Floating Locket with Birthstones")
      find(".fa-plus", :text => "INFORMATION").click
      expect(page).to have_selector(".fa-minus.productDescHeader", :text => "INFORMATION")
      find(".fa-plus", :text => "INSTRUCTIONS").click
      sleep 3
      find(".Instruction .modal-toggle[data-modal-binding='Chain-Length-Guide']").click
      sleep 3
      expect(page).to have_selector("#Chain-Length-Guide")
      expect(page).to have_selector("button.close[type='button'][data-dismiss='modal']")
      expect(page).to have_css("div[style='text-align: center;']")
      find("#Chain-Length-Guide button.close").click
      find(".modal-toggle[data-modal-binding='Kids-Safety-Policy']").click
      expect(page).to have_selector("#Kids-Safety-Policy.modal[style='display: block; padding-right: 17px;']")
      find("#Kids-Safety-Policy button.close").click
    end

    it "You may also like products are visible" do
      expect(page).to have_selector("[itemprop='name']", :text => "Family Tree Floating Locket with Birthstones")
      expect(page).to have_selector(".alsoLikeTitle", :text => "You may also like")
      expect(page).to have_selector(".alsoLikeitem", :count => 4)
    end

  end


  describe "BRACELET with single name - Engraved Silver Infinity Bracelet" do

    before (:each) do
      visit main_site
      #first("[href='/Category/Personalised-Bracelets']", wait: 2).click
      first('.sideBar').click_link('Bracelets')
      find("[title='See detail of Engraved Silver Infinity Bracelet']").click
    end

    it "product images and slider" do
      expect(page).to have_selector("[itemprop='name']", :text => "Engraved Silver Infinity Bracelet")
      expect(page).to have_selector(".productMainImageContainer")
      expect(page).to have_selector(".smallImagesBox")
      find(".productMainImageContainer").click
      expect(page).to have_selector(".boxOverlay[style='display: block;']")
      find(".bigImgInnerBox .nextImg").click
      expect(page).to have_selector(".preImg[style='display: block;']")
      find(".bigImgInnerBox .nextImg").click
    end

    it "validators for empty fields and max chars check" do
      expect(page).to have_selector("[itemprop='name']", :text => "Engraved Silver Infinity Bracelet")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oops, don\u2019t forget to personalize it!")
      page.all("input.form-control[type='text']")[0].set("this is a text with more then 20 chars test")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "Text has to be no more than 9 characters long")
    end

    it "price comparison + price comparison on adding more birthstones" do
      expect(page).to have_selector("[itemprop='name']", :text => "Engraved Silver Infinity Bracelet")
      @listprice = find('.originalPrice').text.slice!(1..-1).to_i
      @finalprice = find('.finalPrice').text.slice!(1..-1).to_i
      @yousave_price = find('div.productInfoLine.instantSavings span:nth-child(2)').text.slice!(1..-7).to_i
      (@listprice - @finalprice).should eq(@yousave_price)
      #Percy::Capybara.snapshot(page, name: 'Product price comparing')
    end

    it "description and modal links" do
      expect(page).to have_selector("[itemprop='name']", :text => "Engraved Silver Infinity Bracelet")
      find(".fa-plus", :text => "INFORMATION").click
      expect(page).to have_selector(".fa-minus.productDescHeader", :text => "INFORMATION")
      find(".fa-plus", :text => "INSTRUCTIONS").click
      sleep 3
      find("[data-modal-binding='Choose-Bracelet-Size']", wait: 1).click
      expect(page).to have_selector("#Choose-Bracelet-Size")
      expect(page).to have_selector("button.close[data-dismiss='modal'][type='button']")
      find("#Choose-Bracelet-Size .close").click
      sleep 3
      find(".modal-toggle[data-modal-binding='Kids-Safety-Policy']").click
      expect(page).to have_selector("#Kids-Safety-Policy.modal[style='display: block; padding-right: 17px;']")
      find("#Kids-Safety-Policy button.close").click
    end

    it "adding to shopping cart verification" do
      expect(page).to have_selector("[itemprop='name']", :text => "Engraved Silver Infinity Bracelet")
      expect(page).to have_selector(".ProductOptionSelector", :count => 2)
      page.all("input.form-control[type='text']")[0].set("auto_test")
      find(".AddToCartLink").click
      find(".shopping-cart-wrapper .items-table", wait: 7).click
      expect(page).to have_content("Engraved Silver Infinity Bracelet")
    end

    it "You may also like products are visible" do
      expect(page).to have_selector("[itemprop='name']", :text => "Engraved Silver Infinity Bracelet")
      expect(page).to have_selector(".alsoLikeTitle", :text => "You may also like")
      expect(page).to have_selector(".alsoLikeitem", :count => 4)
    end

  end

  describe "RING with single name - Irish Claddagh Ring with Engraving" do

    before (:each) do
      visit main_site
      #first("[href='/Category/Personalised-Rings']", wait: 2).click
      first('.sideBar').click_link('Rings')
      find("[title='See detail of Irish Claddagh Ring with Engraving']").click
    end

    it "product images and slider + products statis" do
      expect(page).to have_selector("[itemprop='name']", :text => "Irish Claddagh Ring with Engraving")
      expect(page).to have_selector(".productPublicStatus")
      expect(page).to have_selector(".productMainImageContainer")
      expect(page).to have_selector(".smallImagesBox")
      find(".productMainImageContainer").click
      expect(page).to have_selector(".boxOverlay[style='display: block;']")
      find(".bigImgInnerBox .nextImg").click
      expect(page).to have_selector(".preImg[style='display: block;']")
      find(".bigImgInnerBox .nextImg").click
    end

    it "validators for empty fields and max chars check" do
      expect(page).to have_selector("[itemprop='name']", :text => "Irish Claddagh Ring with Engraving")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oops, don\u2019t forget to personalize it!")
      select("3", from: "Select ring size:")
      sleep 3
      #find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oops, don\u2019t forget to personalize it!")
      page.all("input.form-control[type='text']")[0].set("this is a text with more then 20 chars test")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "Text has to be no more than 20 characters long")
    end

    it "price comparison" do
      expect(page).to have_selector("[itemprop='name']", :text => "Irish Claddagh Ring with Engraving")
      @listprice = find('.originalPrice').text.slice!(1..-1).to_i
      @finalprice = find('.finalPrice').text.slice!(1..-1).to_i
      @yousave_price = find('div.productInfoLine.instantSavings span:nth-child(2)').text.slice!(1..-7).to_i
      (@listprice - @finalprice).should eq(@yousave_price)
    end

    it "description and modal links" do
      expect(page).to have_selector("[itemprop='name']", :text => "Irish Claddagh Ring with Engraving")
      find(".fa-plus", :text => "INFORMATION").click
      expect(page).to have_selector(".fa-minus.productDescHeader", :text => "INFORMATION")
      find(".fa-plus", :text => "INSTRUCTIONS").click
      sleep 3
      find("[data-modal-binding='Ring-Size-Guide']").click
      sleep 3
      expect(page).to have_selector("#Ring-Size-Guide")
      expect(page).to have_selector("button.close[data-dismiss='modal'][type='button']")
      find("#Ring-Size-Guide .close").click
      find(".modal-toggle[data-modal-binding='Kids-Safety-Policy']").click
      expect(page).to have_selector("#Kids-Safety-Policy.modal[style='display: block; padding-right: 17px;']")
      find("#Kids-Safety-Policy button.close").click
      #Percy::Capybara.snapshot(page, name: 'Product description')
    end

    it "adding to shopping cart verification" do
      expect(page).to have_selector("[itemprop='name']", :text => "Irish Claddagh Ring with Engraving")
      #expect(page).to have_selector(".form-control", :count => 2)
      select("3", from: "Select ring size:")
      page.all("input.form-control[type='text']")[1].set("auto_test")
      find(".AddToCartLink").click
      find(".shopping-cart-wrapper .items-table", wait: 7).click
      expect(page).to have_content("Irish Claddagh Ring with Engraving")
    end

    it "You may also like products are visible" do
      expect(page).to have_selector("[itemprop='name']", :text => "Irish Claddagh Ring with Engraving")
      expect(page).to have_selector(".alsoLikeTitle", :text => "You may also like")
      expect(page).to have_selector(".alsoLikeitem", :count => 4)
    end

  end


  describe "KEYCHAIN with single name - Individually engraved Mother Keychain" do

    before (:each) do
      visit main_site
      #first("[href='/Category/Personalised-Keychains']", wait: 2).click
      first('.sideBar').click_link('Keychains')
      find("[title='See detail of Individually engraved Mother Keychain']").click
    end

    it "product images and slider + products statis" do
      expect(page).to have_selector("[itemprop='name']", :text => "Individually engraved Mother Keychain")
      expect(page).to have_selector(".productPublicStatus")
      expect(page).to have_selector(".productMainImageContainer")
      expect(page).to have_selector(".smallImagesBox")
      find(".productMainImageContainer").click
      expect(page).to have_selector(".boxOverlay[style='display: block;']")
      find(".bigImgInnerBox .nextImg").click
      expect(page).to have_selector(".preImg[style='display: block;']")
      find(".bigImgInnerBox .nextImg").click
    end

    it "validators for empty fields and max chars check" do
      expect(page).to have_selector("[itemprop='name']", :text => "Individually engraved Mother Keychain")
      find(".AddToCartLink").click
      expect(page).to have_selector(".OptionCategoryError", :text => "*Oops, don\u2019t forget to personalize it!") #Message text is changed after update from prod DB
      select("Disc", from: "Select pendant type:")
      #find(".AddToCartLink", wait: 5).click
      expect(page).to have_selector("[value='571']", :text => "Disc")
      sleep 3
      page.all("input.form-control[type='text']")[0].set("this is a text with more then 20 chars test")
      #wait_for_ajax
      find(".AddToCartLink").click
      #expect(page).to have_selector(".OptionCategoryError", :text => "Text has to be no more than 20 characters long.")#Message text is changed after update from prod DB
      expect(page).to have_selector(".OptionCategoryError", :text => "Text has to be no more than 8 characters long")
      
  end
    

    it "price comparison" do
      expect(page).to have_selector("[itemprop='name']", :text => "Individually engraved Mother Keychain")
      @listprice = find('.originalPrice').text.slice!(1..-1).to_i
      @finalprice = find('.finalPrice').text.slice!(1..-1).to_i
      @yousave_price = find('div.productInfoLine.instantSavings span:nth-child(2)').text.slice!(1..-7).to_i
      (@listprice - @finalprice).should eq(@yousave_price)
    end

    it "description and modal links" do
      expect(page).to have_selector("[itemprop='name']", :text => "Individually engraved Mother Keychain")
      find(".fa-plus", :text => "INFORMATION").click
      expect(page).to have_selector(".fa-minus.productDescHeader", :text => "INFORMATION")
      find(".fa-plus", :text => "INSTRUCTIONS").click
      sleep 3
      find(".modal-toggle[data-modal-binding='Kids-Safety-Policy']").click
      expect(page).to have_selector("#Kids-Safety-Policy.modal[style='display: block; padding-right: 17px;']")
      find("#Kids-Safety-Policy button.close").click
    end

    it "adding to shopping cart verification" do
      expect(page).to have_selector("[itemprop='name']", :text => "Individually engraved Mother Keychain")
      expect(page).to have_selector(".ProductOptionSelector", :count => 2)
      select("Disc", from: "Select pendant type:")
      page.all("input.form-control[type='text']")[1].set("autotest")
      find(".AddToCartLink").click
      sleep 3
      find(".shopping-cart-wrapper .items-table", wait: 7).click
      expect(page).to have_content("Individually engraved Mother Keychain")
      #Percy::Capybara.snapshot(page, name: 'Product adding to shopping cart')
    end

    it "You may also like products are visible" do
      expect(page).to have_selector("[itemprop='name']", :text => "Individually engraved Mother Keychain")
      expect(page).to have_selector(".alsoLikeTitle", :text => "You may also like")
      expect(page).to have_selector(".alsoLikeitem", :count => 4)
    end

  end

  describe "Gift Box - only a Gift Box" do

    before (:each) do
      visit ("#{main_site}Products/GiftBox/Gift-Box") #"https://qa.kentico-test.com/Products/GiftBox/Gift-Box"
    end

    it "product main image and name" do
      expect(page).to have_selector("[itemprop='name']", :text => "Gift Box")
      expect(page).to have_selector(".productMainImageContainer")
    end

    it "validators for max chars check" do
      expect(page).to have_selector("[itemprop='name']", :text => "Gift Box")
      find("textarea.form-control").set("test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test")
      find(".AddToCartLink").click
      expect(page).to have_selector(".ErrorLabel", :text => "Text has to be no more than 280 characters long")
    end

    it "price comparison" do
      expect(page).to have_selector("[itemprop='name']", :text => "Gift Box")
      @listprice = find('.originalPrice').text.slice!(1..-1).to_i
      @finalprice = find('.finalPrice').text.slice!(1..-1).to_i
      @yousave_price = find('div.productInfoLine.instantSavings span:nth-child(2)').text.slice!(1..-7).to_i
      (@listprice - @finalprice).should eq(@yousave_price)
    end

    it "description and modal links" do
      expect(page).to have_selector("[itemprop='name']", :text => "Gift Box")
      find(".fa-plus", :text => "INFORMATION").click
      expect(page).to have_selector(".fa-minus.productDescHeader", :text => "INFORMATION")
      find(".fa-plus", :text => "INSTRUCTIONS").click
    end

    it "adding to shopping cart verification" do
      expect(page).to have_selector("[itemprop='name']", :text => "Gift Box")
      #expect(page).to have_selector(".form-control", :count => 1)
      find("textarea.form-control").set("test test test giftbox")
      find(".AddToCartLink").click
      find(".shopping-cart-wrapper .items-table", wait: 7).click
      expect(page).to have_selector(".item-name", :text => "Gift Box")
    end

    it "You may also like products are visible" do
      expect(page).to have_selector("[itemprop='name']", :text => "Gift Box")
      expect(page).to have_selector(".alsoLikeTitle", :text => "You may also like")
      expect(page).to have_selector(".alsoLikeitem", :count => 4)
      #Percy::Capybara.snapshot(page, name: 'Product also like section')
    end

  end

end

feature "As a user i'm adding all type of products to the shopping cart from: You May Also Like , Footer Reviews Carusel" , js: true, :order => :defined do

  describe "Add any product from You may aslo like offers (any of 4 of them)" do

    before (:each) do
      visit main_site
      #first("[href='/Category/Full-Necklace-Collection']", wait: 2).click
      first('.sideBar').click_link('Necklaces')
      #find("[title='See detail of Sterling Silver Classic Name Necklace']").click
      visit ("#{main_site}Products/All-Necklaces/Sterling-Silver-Classic-Name-Necklace")
      @productname = find(".alsoLiktitle", match: :first).text
      find(".alsoLikeItems").find(".alsoLikeitem", match: :first).click
    end

    it "checking if a click on one item from you may also like, takes us to the product page " do
      expect(page).to have_selector("[itemprop='name']", :text => @productname)
    end

    it "price comparison" do
      @listprice = find('.originalPrice').text.slice!(1..-1).to_i
      @finalprice = find('.finalPrice').text.slice!(1..-1).to_i
      @yousave_price = find('div.productInfoLine.instantSavings span:nth-child(2)').text.slice!(1..-7).to_i
      (@listprice - @finalprice).should eq(@yousave_price)
    end

    it "You may also like products are visible" do
      expect(page).to have_selector("[itemprop='name']", :text => @productname)
      expect(page).to have_selector(".alsoLikeTitle", :text => "You may also like")
      expect(page).to have_selector(".alsoLikeitem", :count => 4)
    end

  end

  describe "Add any product from Footer Reviews Carusel (3 products)" do

    before (:each) do
      visit main_site
      find(".slide_number_1").click
      find(".carouselItemLink", match: :first).click
      @productname = find("[itemprop='name']").text
    end

    it "checking if a click on one item from you may also like, takes us to the product page " do
      expect(page).to have_selector("[itemprop='name']", :text => @productname)
      #Percy::Capybara.snapshot(page, name: 'Product added from footer carusel')
    end

    it "price comparison" do
      @listprice = find('.originalPrice').text.slice!(1..-1).to_i
      @finalprice = find('.finalPrice').text.slice!(1..-1).to_i
      @yousave_price = find('div.productInfoLine.instantSavings span:nth-child(2)').text.slice!(1..-7).to_i
      (@listprice - @finalprice).should eq(@yousave_price)
    end

    it "You may also like products are visible" do
      expect(page).to have_selector("[itemprop='name']", :text => @productname)
      expect(page).to have_selector(".alsoLikeTitle", :text => "You may also like")
      expect(page).to have_selector(".alsoLikeitem", :count => 4)
    end

  end

end

    describe "Adding random product to the Shopping cart" do
      it "find random product from categories and add it to the shopping cart" do
        visit main_site
        # expect(WebMock).not_to have_request(:get, main_site)
        # add_random_product_to_the_shopping_cart
      end

    end
