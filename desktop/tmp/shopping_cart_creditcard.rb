require './helpers/spec_helper.rb'

feature "AS a user i'm clicking on empty shopping cart, and verify it shows the right message , and no errors" , js: true, :order => :defined do

  describe "AS a user i'm clicking on empty shopping cart " do

    before (:each) do
      visit main_site
    end


    it "click on shopping cart with 0 items and verify it is empty" do
      expect(page).to have_content("Shopping Cart (0)")
      find(".headerCart").click
      expect(page).to have_selector(".emptyCartBox", :text => "Your shopping cart is empty")
      expect(page).to have_selector(".continue-shopping-button")
      #Percy::Capybara.snapshot(page, name: 'Empty shopping cart on IE site')
    end

    it "in the shopping cart click on Continue shopping button" do
      expect(page).to have_content("Shopping Cart (0)")
      find(".headerCart").click
      find(".continue-shopping-button").click
      expect(page).to have_current_path(main_site, url: true)
    end

  end

end

RSpec::Steps.steps "As a user i'm adding necklace and GiftBox to the shopping cart, then adding coupon, comment, and checking out with Creditcard method ", type: :feature, js: true, :order => :defined do

  step "Adding Carrie style Necklace to the shopping cart ", :story => "Adding Carrie style Necklace to the shopping cart " do
    visit main_site
    # visit "https://qa.kentico-test.com/Products/Shop-by-type/Necklaces/Infinity-Name-Necklace"
    #find("[href='/Products/Shop-by-type/Necklaces']", wait: 2).click
    first('.sideBar').click_link('Necklaces')
    find("[title='See detail of Infinity Name Necklace']").click
    page.all("input.form-control[type='text']")[0].set("test1")
    page.all("input.form-control[type='text']")[1].set("test2")
    select("50 cm", from: "Select chain length:")
    find(".AddToCartLink").click
    #Percy::Capybara.snapshot(page, name: 'Necklace is added to shopping cart')
  end

  step "Click on add a gift box link in shopping cart page, and adding it to the shopping cart", :story => "Click on add a gift box link in shopping cart page, and adding it to the shopping cart" do
    # visit "https://qa.kentico-test.com/Products/GiftBox/Gift-Box"
    find(".shopping-cart-wrapper")
    find("[href='/Products/GiftBox/Gift-Box']", match: :first).click
    find("textarea.form-control",wait: 1).set("Automation test adding a gift box text")
    find(".AddToCartLink").click
    #Percy::Capybara.snapshot(page, name: 'GiftBox is added to shopping cart')
  end

  step "Add Coupon (Promotional Code)", :story => "Add Coupon (Promotional Code)" do
    find('.promotional-subtotal-wrapper').click
    find('div.coupon-wrapper input.coupon-text').set('EXTRA10')
    find('.apply-button-wrapper').click
    sleep 3
    # @total_before_coupon = page.all('.subtotal-wrapper .TotalViewer span')[1].text
    #Percy::Capybara.snapshot(page, name: 'Coupon is applied ')
  end

  step "Expedited Delivery up to 12-14 business days option", :story => "Expedited Delivery up to 12-14 business days option" do
    find("[type='radio'][value='8']").select_option
    expect(page).to have_selector(".total-delivery-price-wrapper .Value", :text => "€6.95")
    sleep 3
    #Percy::Capybara.snapshot(page, name: 'Delivery option is applied')
  end

  step "Add a comment", :story => "Add a comment" do
    find('.comments-wrapper').click
    find('.comments-content-wrapper textarea').set('Automation test - adding some commets to the order')
  end

  step "Click Proceed to checkout", :story => "Click Proceed to checkout" do
    # click_button "PROCEED TO CHECKOUT"
    #page.all(".btn-primary")[1].click
    find("[value='PROCEED TO CHECKOUT']").click
  end
 # Popup is not displayed due to the rule that gift box is added, no popup should be displayed
 # step "Binary popup - Click No Thanks, Proceed to checkout", :story => "Binary popup - Click No Thanks, Proceed to checkout" do
  #  expect(page).to have_selector(".binary-popup-dialog")
  # click_button "No Thanks, Proceed to checkout"
  #end

  step "Account page - fill in Information", :story => "Account page - fill in Information" do
    expect(page).to have_selector(".account-wrapper")
    #Percy::Capybara.snapshot(page, name: 'Customer details page is opened')
    fill_in_account_details
    select("Ireland",from: "Country:")
  end

  step "Account page - Click Proceed to checkout button", :story => "Account page - Click Proceed to checkout button" do
    click_button "PROCEED TO CHECKOUT"
  end

  step "Creditcard payment page - fill in Payment Details using Mastercard", :story => "Creditcard payment page - fill in Payment Details using Mastercard" do
    fill_in_creditcard__payment_details
    expect(page).to have_selector("[src='/App_Themes/Global/Images/Mastercard.png']")
    #Percy::Capybara.snapshot(page, name: 'Payment details page is opened')
  end

  step "Creditcard payment page - fill in BILLING INFORMATION", :story => "Creditcard payment page - fill in BILLING INFORMATION" do
    fill_in_creditcard_billing_information
    
  end

  step "Creditcard payment page - Click Pay button", :story => "Creditcard payment page - Click Pay button" do
    click_button "PAY"
  end

  step "Thank you page - verify order details", :story => "Thank you page - verify order details" do
    expect(page).to have_selector("[action='/Checkout/Thank-you-page']")
    expect(page).to have_content("Your Order Has Been Received")
    expect(page).to have_no_selector(".thanksOrderCode", match: :first , :text =>"-")
    #Percy::Capybara.snapshot(page, name: 'Thanksyou page is displayed for creditcard payment on IE site')
  end

end

RSpec::Steps.steps "As a user i'm adding 5 items to the shopping cart, and checking out with Creditcard method ", type: :feature, js: true, :order => :defined do

  step "Adding Carrie style Necklace to the shopping cart ", :story => "Adding Carrie style Necklace to the shopping cart " do
    visit main_site
    # visit "https://qa.kentico-test.com/Products/Shop-by-type/Necklaces/Infinity-Name-Necklace"
    #find("[href='/Products/Shop-by-type/Necklaces']", wait: 2).click
    first('.sideBar').click_link('Necklaces')
    find("[title='See detail of Infinity Name Necklace']").click
    page.all("input.form-control[type='text']")[0].set("test1")
    page.all("input.form-control[type='text']")[1].set("test2")
    select("50 cm", from: "Select chain length:")
    find(".AddToCartLink").click
  end

  step "Click on add a gift box link in shopping cart page, and adding it to the shopping cart", :story => "Click on add a gift box link in shopping cart page, and adding it to the shopping cart" do
    # visit "https://qa.kentico-test.com/Products/GiftBox/Gift-Box"
    find(".shopping-cart-wrapper")
    find("[href='/Products/GiftBox/Gift-Box']", match: :first).click
    find("textarea.form-control",wait: 1).set("Automation test adding a gift box text")
    find(".AddToCartLink").click
  end

  step "Adding NECKLACE with dynamic price option - Family Tree Birthstone Necklace", :story => "Adding NECKLACE with dynamic price option - Family Tree Birthstone Necklace" do
    find(".continue-shopping-wrapper .continue-shopping-button").click
    #find("[href='/Products/Shop-by-type/Necklaces']", wait: 2).click
    #first('.sideBar').click_link('Necklaces')
    #find("[title='See detail of Family Tree Floating Locket with Birthstones']").click
    #'Category/Full-Necklace-Collection/Family-Tree-Floating-Locket-with-Birthstones' in case link is incorrect
    visit (main_site + 'Products/All-Necklaces/Family-Tree-Floating-Locket-with-Birthstones')
    select("7 Birthstones (+ €30)", from: "Select number of birthstones:")
    expect(page).to have_selector("[id*='CategName']", :count => 10)
    select("February - Amethyst", from: "1st birthstone:")
    select("February - Amethyst", from: "2nd birthstone:")
    select("May - Emerald", from: "3rd birthstone:")
    select("July - Ruby", from: "4th birthstone:")
    select("July - Ruby", from: "5th birthstone:")
    select("August - Peridot", from: "6th birthstone:")
    select("August - Peridot", from: "7th birthstone:")
    find(".AddToCartLink").click
    expect(page).to have_content("Family Tree Floating Locket with Birthstones")
    expect(page).to have_selector(".shopping-cart-wrapper") 
    #Percy::Capybara.snapshot(page, name: 'Floating locket is added to shoppingcart') 
  end

  step "Adding BRACELET with single name - Engraved Silver Infinity Bracelet", :story => "Adding BRACELET with single name - Engraved Silver Infinity Bracelet" do
    find(".continue-shopping-wrapper .continue-shopping-button").click
    #find("[href='/Category/Personalised-Bracelets']", wait: 2).click
    first('.sideBar').click_link('Bracelets')
    find("[title='See detail of Engraved Silver Infinity Bracelet']").click
    page.all("input.form-control[type='text']")[0].set("auto_test")
    find(".AddToCartLink").click
    expect(page).to have_content("Engraved Silver Infinity Bracelet")
    #Percy::Capybara.snapshot(page, name: 'Bracelet is added to shoppincart')
  end

  step "Adding RING with single name - Irish Claddagh Ring with Engraving", :story => "Adding RING with single name - Irish Claddagh Ring with Engraving" do
    find(".continue-shopping-wrapper .continue-shopping-button").click
    #find("[href='/Category/Personalised-Rings']", wait: 2).click
    first('.sideBar').click_link('Rings')
    find("[title='See detail of Irish Claddagh Ring with Engraving']").click
    select("10", from: "Select ring size:")
    page.all("input.form-control[type='text']")[1].set("auto_test")
    find(".AddToCartLink").click
    expect(page).to have_content("Irish Claddagh Ring with Engraving")
    #Percy::Capybara.snapshot(page, name: 'Ring is added to shopping cart')
  end

  step "Add Coupon (Promotional Code)", :story => "Add Coupon (Promotional Code)" do
    find('.promotional-subtotal-wrapper').click
    find('div.coupon-wrapper input.coupon-text').set('EXTRA10')
    find('.apply-button-wrapper').click
  end

  step "Add a comment", :story => "Add a comment" do
    find('.comments-wrapper').click
    find('.comments-content-wrapper textarea').set('Automation test - adding some commets to the order')
  end

  step "Click Proceed to checkout", :story => "Click Proceed to checkout" do
    # click_button "PROCEED TO CHECKOUT"
    #page.all(".btn-primary")[1].click
    find("[value='PROCEED TO CHECKOUT']").click
  end
  # Popup is not displayed due to the rule that gift box is added, no popup should be displayed
  #  step "Binary popup - Click No Thanks, Proceed to checkout", :story => "Binary popup - Click No Thanks, Proceed to checkout" do
  #    expect(page).to have_selector(".binary-popup-dialog")
  #    click_button "No Thanks, Proceed to checkout"
  #  end

  step "Account page - fill in Information", :story => "Account page - fill in Information" do
    expect(page).to have_selector(".account-wrapper")
    fill_in_account_details
    select("Ireland",from: "Country:")
  end

  step "Account page - Click Proceed to checkout button", :story => "Account page - Click Proceed to checkout button" do
    click_button "PROCEED TO CHECKOUT"
  end

  step "Creditcard payment page - fill in Payment Details using Mastercard", :story => "Creditcard payment page - fill in Payment Details using Mastercard" do
    fill_in_creditcard__payment_details
    expect(page).to have_selector("[src='/App_Themes/Global/Images/Mastercard.png']")
  end

  step "Creditcard payment page - fill in BILLING INFORMATION", :story => "Creditcard payment page - fill in BILLING INFORMATION" do
    fill_in_creditcard_billing_information
  end

  step "Creditcard payment page - Click Pay button", :story => "Creditcard payment page - Click Pay button" do
    click_button "PAY"
  end

  step "Thank you page - verify order details", :story => "Thank you page - verify order details" do
    expect(page).to have_selector("[action='/Checkout/Thank-you-page']")
    expect(page).to have_content("Your Order Has Been Received")
    expect(page).to have_no_selector(".thanksOrderCode", match: :first , :text =>"-")
    #Percy::Capybara.snapshot(page, name: 'Creditcard payment for more than 1 product order is successful')
  end

end


RSpec::Steps.steps "As a user i'm doing Full E2E flow and checking out with CreditCard method (including purchase, automatic export, verify order in OM, and then verify order export status in Kentico BO)", type: :feature, js: true, :order => :defined do

  step "Adding Carrie style Necklace to the shopping cart ", :story => "Adding Carrie style Necklace to the shopping cart " do
    visit main_site
    # visit "https://qa.kentico-test.com/Products/Shop-by-type/Necklaces/Infinity-Name-Necklace"
    #find("[href='/Products/Shop-by-type/Necklaces']", wait: 2).click
    first('.sideBar').click_link('Necklaces')
    find("[title='See detail of Infinity Name Necklace']").click
    page.all("input.form-control[type='text']")[0].set("test1")
    page.all("input.form-control[type='text']")[1].set("test2")
    select("50 cm", from: "Select chain length:")
    find(".AddToCartLink").click
  end

  step "Click on add a gift box link in shopping cart page, and adding it to the shopping cart", :story =>  "Click on add a gift box link in shopping cart page, and adding it to the shopping cart" do
    # visit "https://qa.kentico-test.com/Products/GiftBox/Gift-Box"
    find(".shopping-cart-wrapper")
    find("[href='/Products/GiftBox/Gift-Box']", match: :first).click
    visit "#{main_site}Products/GiftBox/Gift-Box"
    find("textarea.form-control",wait: 1).set("Automation test adding a gift box text")
    find(".AddToCartLink").click
  end

  step "Add Coupon (Promotional Code)", :story => "Add Coupon (Promotional Code)" do
    find('.promotional-subtotal-wrapper').click
    find('div.coupon-wrapper input.coupon-text').set('EXTRA10')
    find('.apply-button-wrapper').click
  end

  step "Add a comment", :story => "Add a comment" do
    find('.comments-wrapper').click
    find('.comments-content-wrapper textarea').set('Automation test - adding some commets to the order')
  end

  step "Click Proceed to checkout", :story => "Click Proceed to checkout" do
    #  click_button "PROCEED TO CHECKOUT"
    #page.all(".btn-primary")[1].click
    find("[value='PROCEED TO CHECKOUT']").click
  end
  # Popup is not displayed since giftbox is added, the rule is working in this way now
  #  step "Binary popup - Click No Thanks, Proceed to checkout", :story => "Binary popup - Click No Thanks, Proceed to checkout" do
  #    expect(page).to have_selector(".binary-popup-dialog")
  #    click_button "No Thanks, Proceed to checkout"
  #  end

  step "Account page - fill in Information", :story => "Account page - fill in Information" do
    expect(page).to have_selector(".account-wrapper")
    fill_in_account_details
    select("Ireland",from: "Country:")
  end

  step "Account page - Click Proceed to checkout button", :story => "Account page - Click Proceed to checkout button" do
    click_button "PROCEED TO CHECKOUT"
  end

  step "Creditcard payment page - fill in Payment Details using Mastercard", :story => "Creditcard payment page - fill in Payment Details using Mastercard" do
    fill_in_creditcard__payment_details
    # expect(page).to have_selector("[src='/App_Themes/Global/Images/Mastercard.png']")
  end

  step "Creditcard payment page - fill in BILLING INFORMATION", :story => "Creditcard payment page - fill in BILLING INFORMATION" do
    fill_in_creditcard_billing_information
  end

  step "Creditcard payment page - Click Pay button", :story => "Creditcard payment page - Click Pay button" do
    click_button "PAY"
  end

   step "Thank you page - verify order details", :story => "Thank you page - verify order details" do
     find("[action='/Checkout/Thank-you-page']", wait: 20)
     expect(page).to have_selector("[action='/Checkout/Thank-you-page']")
     expect(page).to have_content("Your Order Has Been Received")
     $order_number = page.all(".thanksOrderCode")[0].text
     p $order_number
     $order_total_cost = page.all(".thanksOrderCode")[1].text.slice!(1..-1).to_i
     p $order_total_cost
     expect(page).to have_no_selector(".thanksOrderCode", match: :first , :text =>"-")
   end

   step "Kentico log in as global_admin_user", :story => "Kentico log in as global_admin_user" do
     visit main_site_admin_login
     user_login('global_admin_user')
     #Percy::Capybara.snapshot(page, name: 'Login to BO for IE site')
   end
#Step is not actual since export is not set up on environment 
   #step "Go to Store configuration and activate 'Enable automatic order export' checkbox", :story => "Go to Store configuration and activate 'Enable automatic order export' checkbox" do
     #activate_automatic_export
   #end

   step "Search for the order in Orders Application", :story => "Search for the order in Orders Application" do
     bo_search_for_orderid($order_number)
     #Percy::Capybara.snapshot(page, name: 'Search order by ID in BO')
   end

   step "Verify order status and price match", :story => "Verify order status and price match" do
     within_frame ("cmsdesktop") do
      within ("[data-objectid='#{$order_number}']") do
        @bo_order_price = find("td:nth-child(5)").text.slice!(1..-1).to_i
        ($order_total_cost).should eq(@bo_order_price)
        expect(page).to have_selector(".tag-dark", :text => "Payment received")
        expect(page).to have_selector(".tag-dark", :text => "Payment received")
        expect(page).to have_selector(".StatusEnabled", :text => "Yes")
        #Percy::Capybara.snapshot(page, name: 'Credit card order has status - Payment received')
      end
     end
   end

   step "Edit selected otder", :story => "Edit selected otder" do
     within_frame ("cmsdesktop") do
      within ("[data-objectid='#{$order_number}']") do
        find(".icon-edit").click
        # sleep 300
      end
     end
   end
# Step is not actual since functinality is not available in Kentico BO UI side
   step "Waiting (max 5 minutes) for automatic export to update order status to 'Payment received' status ", :story => "Waiting (max 5 minutes) for automatic export to update order status to 'Payment received' status " do
    bo_wait_for_order_status_update_to_success($order_number)
    #Percy::Capybara.snapshot(page, name: 'Automatic order export for creditcard order is successful')
   end

   step "Login to old OM", :story => "Login to old OM" do
     visit om_admin_login
     om_user_login
     #Percy::Capybara.snapshot(page, name: 'Login to OM for IE site')
   end

   step "Find order in OM By Receipt ID", :story => "Find order in OM By Receipt ID" do
    click_link ('link3')
    click_button 'm_btnGetOrders'
    select('Receipt ID', :from => 'm_dropListSearchCriteria1')
    fill_in("m_txtSearchOrder1", :with => $order_number)
    click_button 'm_btnSearchOrders'
    expect(page).to have_content("automation_test")
    #Percy::Capybara.snapshot(page, name: 'Search order by ID in OM')
   end

   step "Enter into the Order and Search for Receipt ID and validate items", :story => "Enter into the Order and Search for Receipt ID and validate items" do
     find("[value='Select']", match: :first).click
     expect(page).to have_selector("#m_panelOrderDisplayRight table", count: 2)
     expect(page).to have_selector("#m_txtBoxReceiptID[value='#{$order_number}']")
     expect(find("#m_txtBoxShippingAddress").text).not_to be_empty
     #Percy::Capybara.snapshot(page, name: 'Order contains shipping address')
   end

end

RSpec::Steps.steps "As a user i should be able to checkout with CreditCard with Invalid Coupon code, and move on to the Account page", type: :feature, js: true, :order => :defined do

  step "Adding Carrie style Necklace to the shopping cart ", :story => "Adding Carrie style Necklace to the shopping cart " do
    visit main_site
    # visit "https://qa.kentico-test.com/Products/Shop-by-type/Necklaces/Infinity-Name-Necklace"
    #find("[href='/Products/Shop-by-type/Necklaces']", wait: 2).click
    first('.sideBar').click_link('Necklaces')
    find("[title='See detail of Infinity Name Necklace']").click
    page.all("input.form-control[type='text']")[0].set("test1")
    page.all("input.form-control[type='text']")[1].set("test2")
    select("50 cm", from: "Select chain length:")
    find(".AddToCartLink").click
  end

  step "Click on add a gift box link in shopping cart page, and adding it to the shopping cart", :story => "Click on add a gift box link in shopping cart page, and adding it to the shopping cart" do
    # visit "https://qa.kentico-test.com/Products/GiftBox/Gift-Box"
    find(".shopping-cart-wrapper")
    find("[href='/Products/GiftBox/Gift-Box']", match: :first).click
    find("textarea.form-control",wait: 1).set("Automation test adding a gift box text")
    find(".AddToCartLink").click
  end

  step "Add an Invalid Coupon (Promotional Code) and validate the user got message", :story => "Add an Invalid Coupon (Promotional Code) and validate the user got message" do
    find('.promotional-subtotal-wrapper').click
    find('div.coupon-wrapper input.coupon-text').set('InvalidCoupon')
    find('.apply-button-wrapper').click
    expect(page).to have_selector(".coupon-box .Error span", text: "Coupon code is not valid.")
    #Percy::Capybara.snapshot(page, name: 'Error is displayed for invalid coupon')
  end

  step "Click Proceed to checkout", :story => "Click Proceed to checkout" do
    #  click_button "PROCEED TO CHECKOUT"
    #page.all(".btn-primary")[1].click
    find("[value='PROCEED TO CHECKOUT']").click
    expect(page).to have_selector(".pagesContent")
    #Percy::Capybara.snapshot(page, name: 'Account page is opened after invalid coupon was applied')
    
  end
 #Popup is not displayed since giftbox is added to cart
  #step "Binary popup - Click No Thanks, Proceed to checkout", :story => "Binary popup - Click No Thanks, Proceed to checkout" do
    #expect(page).to have_selector(".binary-popup-dialog")
    #expect(page).to have_selector(".modal-content")
    #click_button "No Thanks, Proceed to checkout"
    #first("[value='No Thanks, Proceed to checkout']").click
    
  #end

  step "Account page - fill in Information", :story => "Account page - fill in Information" do
    expect(page).to have_selector(".account-wrapper")
    #expect(page).to have_selector("[id*='Order_customerForm_pnlForm']")
    
  end

end

RSpec::Steps.steps "As a user i'm selecting different shipping option (Expedited Delivery), and the price update should take less then a 2 secounds", type: :feature, js: true, :order => :defined do

  step "Adding Carrie style Necklace to the shopping cart ", :story => "Adding Carrie style Necklace to the shopping cart " do
    visit main_site
    # visit "https://qa.kentico-test.com/Products/Shop-by-type/Necklaces/Infinity-Name-Necklace"
    #find("[href='/Products/Shop-by-type/Necklaces']", wait: 2).click
    first('.sideBar').click_link('Necklaces')
    find("[title='See detail of Infinity Name Necklace']").click
    page.all("input.form-control[type='text']")[0].set("test1")
    page.all("input.form-control[type='text']")[1].set("test2")
    select("50 cm", from: "Select chain length:")
    find(".AddToCartLink").click
  end

  step "selecting different shipping option (Expedited Delivery)", :story => "selecting different shipping option (Expedited Delivery)" do
    @shipping_price_before = find(".shopping-cart-wrapper .Value span").text.slice!(1..-1).to_i
    find("[type='radio'][value='8']").click
    wait_for_ajax
    sleep 2
    @shipping_price_after = find(".shopping-cart-wrapper .Value span").text.slice!(1..-1).to_i
    @shipping_price_before.should_not eq(@shipping_price_after)
    #Percy::Capybara.snapshot(page, name: 'Price is changed after another shipping option is changed')
  end

end


RSpec::Steps.steps "As a user i'm adding 2 products to the shopping cart, and apply a valid coupon, then removing 1 product , and 'remove' button link is not changed to 'update' button link", type: :feature, js: true, :order => :defined do

  step "Adding Carrie style Necklace to the shopping cart ", :story => "Adding Carrie style Necklace to the shopping cart " do
    visit main_site
    # visit "https://qa.kentico-test.com/Products/Shop-by-type/Necklaces/Infinity-Name-Necklace"
    #find("[href='/Products/Shop-by-type/Necklaces']", wait: 2).click
    first('.sideBar').click_link('Necklaces')
    find("[title='See detail of Infinity Name Necklace']").click
    page.all("input.form-control[type='text']")[0].set("test1")
    page.all("input.form-control[type='text']")[1].set("test2")
    select("50 cm", from: "Select chain length:")
    find(".AddToCartLink").click
    expect(page).to have_content("Infinity Name Necklace")
  end

  step "Adding BRACELET with single name - Engraved Silver Infinity Bracelet", :story => "Adding BRACELET with single name - Engraved Silver Infinity Bracelet" do
    find(".continue-shopping-wrapper .continue-shopping-button").click
    #find("[href='/Products/Shop-by-type/Bracelets']", wait: 2).click
    first('.sideBar').click_link('Bracelets')
    find("[title='See detail of Engraved Silver Infinity Bracelet']").click
    page.all("input.form-control[type='text']")[0].set("auto_test")
    find(".AddToCartLink").click
    expect(page).to have_content("Engraved Silver Infinity Bracelet")
  end

  step "Add Coupon (Promotional Code)", :story => "Add Coupon (Promotional Code)" do
      find('.promotional-subtotal-wrapper').click
      find('div.coupon-wrapper input.coupon-text').set('EXTRA10')
      find('.apply-button-wrapper').click
    end

  step "Remove the 1st item from the shopping cart and ", :story => "Remove the 1st item from the shopping cart and " do
    expect(page).to have_selector(".RemoveButton", count: 2)
    @remove_button_text_before = find(".RemoveButton span", match: :first).text
    find(".RemoveButton span", match: :first).click
    expect(page).to have_selector(".RemoveButton", count: 1)
    @remove_button_text_after = find(".RemoveButton span", match: :first).text
    @remove_button_text_before.should eq(@remove_button_text_after)
    #Percy::Capybara.snapshot(page, name: 'Remove label is not changed after one product is removed from shopping cart')
  end

end


RSpec::Steps.steps "As a user i'm adding A random product and GiftBox to the shopping cart, continue with creditcart method then change payment method to paypal and verify the is only 1 new order for this flow", type: :feature, js: true, :order => :defined do

  step "Adding A random product to the shopping cart ", :story => "Adding A random product to the shopping cart " do
    visit main_site
    add_random_product_to_the_shopping_cart
  end

  step "Click on add a gift box link in shopping cart page, and adding it to the shopping cart", :story => "Click on add a gift box link in shopping cart page, and adding it to the shopping cart" do
    # visit "https://qa.kentico-test.com/Products/GiftBox/Gift-Box"
    find(".shopping-cart-wrapper")
    find("[href='/Products/GiftBox/Gift-Box']", match: :first).click
    find("textarea.form-control",wait: 1).set("Automation test adding a gift box text")
    find(".AddToCartLink").click
  end

  step "Expedited Delivery up to 12-14 business days option", :story => "Expedited Delivery up to 12-14 business days option" do
    find("[type='radio'][value='8']").select_option
    expect(page).to have_selector(".total-delivery-price-wrapper .Value", :text => "€6.95")
    sleep 2
  end

  step "Click Proceed to checkout with Creditcard method", :story => "Click Proceed to checkout with Creditcard method" do
    # click_button "PROCEED TO CHECKOUT"
    #page.all(".btn-primary")[1].click
    find("[value='PROCEED TO CHECKOUT']").click
  end
 #Binary popup is not displayed since giftbox is added to order
  #step "Binary popup - Click on X (close) button", :story => "Binary popup - Click on X (close) button" do
   # expect(page).to have_selector(".binary-popup-dialog")
   # find("button.close").click
  #end

  step "Click Proceed to checkout with Creditcard method again", :story => "Click Proceed to checkout with Creditcard method again" do
    # click_button "PROCEED TO CHECKOUT"
    #page.all(".btn-primary")[1].click
    find("[value='PROCEED TO CHECKOUT']").click
  end

  step "Account page - fill in Information", :story => "Account page - fill in Information" do
    expect(page).to have_selector(".account-wrapper")
    $rand_firstname = Array.new(10){[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join
    $rand_lastname = Array.new(10){[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join
    #fill_in("First name:", :with => $rand_firstname)
    find("[name*='CustomerFirstName']").set($rand_firstname)
    #fill_in("Last Name:", :with => $rand_lastname)
    find("[name*='CustomerLastName']").set($rand_lastname)
    fill_in("Email:", :with => "#{$rand_firstname}-#{$rand_lastname}@novus.io")
    select("Ireland",from: "Country:")
  end

  step "Account page - Click Proceed to checkout button", :story => "Account page - Click Proceed to checkout button" do
    click_button "PROCEED TO CHECKOUT"
  end

  step "Go Back to the Shopping Cart", :story => "Go Back to the Shopping Cart" do
    #find(".checkout-nav-item a[href='/Checkout/Checkout/Shopping-cart']").click
    click_link 'Return to shopping cart'
  end

  step "Click Proceed to checkout with PayPal", :story => "Click Proceed to checkout with PayPal" do
     find(".paypal-checkout").click
     #Percy::Capybara.snapshot(page, name: 'return to shopping cart after checkout and proceed with paypal')
  end

  step "Account page - just click proceed to checkout with existing account details", :story => "Account page - just click proceed to checkout with existing account details" do
    expect(page).to have_selector(".account-wrapper")
    click_button "PROCEED TO CHECKOUT"
  end

  step "PayPal payment page - fill in Payment Details using PayPal and click login", :story => "PayPal payment page - fill in Payment Details using PayPal and click login" do
     fill_in_paypal_details_and_click_login
   end

   step "PayPal payment page - click Continue button", :story => "PayPal payment page - click Continue button" do
     click_button "Continue"
   end

  step "Thank you page - verify order details", :story => "Thank you page - verify order details" do
    expect(page).to have_selector("[action='/Checkout/Thank-you-page.aspx']")
    expect(page).to have_content("Your Order Has Been Received")
    expect(page).to have_no_selector(".thanksOrderCode", match: :first , :text =>"-")
    #Percy::Capybara.snapshot(page, name: 'Paypal payment successful for IE site')
  end

   step "Kentico log in as global_admin_user", :story => "Kentico log in as global_admin_user" do
     visit main_site_admin_login
     user_login('global_admin_user')
   end

   step "Search if there are 2 different order with the same account name", :story => "Search if there are 2 different order with the same account name" do
     find('.cms-nav-icon-large').click
     find(".accordion-toggle", text: "E-commerce").click
     find('.app-orders').click
     find('.app-orders').click
      within_frame ("cmsdesktop") do
        fill_in("m_c_orderListElem_gridElem_cf_txtCustomerNameOrCompanyOrEmail", with: "#{$rand_firstname}-#{$rand_lastname}@novus.io")
        click_button "Search"
        expect(page).to have_content("#{$rand_firstname} #{$rand_lastname}", :count => 1)
      end
      #Percy::Capybara.snapshot(page, name: 'Search order by first name in BO and check there is only one')
   end

end
