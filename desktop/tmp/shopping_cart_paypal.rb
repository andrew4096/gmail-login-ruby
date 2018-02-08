require './helpers/spec_helper.rb'

RSpec::Steps.steps "As a user i'm adding necklace and GiftBox to the shopping cart, then adding coupon, comment, and checking out with PayPal method",:feature => "As a user i'm adding necklace and GiftBox to the shopping cart, then adding coupon, comment, and checking out with PayPal method", type: :feature, js: true, :order => :defined do

  step "Adding Carrie style Necklace to the shopping cart" , :story => "Adding Carrie style Necklace to the shopping cart" do
    
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

  step "Add Coupon (Promotional Code)", :story => "Add Coupon (Promotional Code)" do
    find('.promotional-subtotal-wrapper').click
    find('div.coupon-wrapper input.coupon-text').set('EXTRA10')
    find('.apply-button-wrapper').click
    # @total_before_coupon = page.all('.subtotal-wrapper .TotalViewer span')[1].text
  end

  step "Expedited Delivery up to 12-14 business days option", :story => "Expedited Delivery up to 12-14 business days option" do
    find("[type='radio'][value='8']").select_option
    expect(page).to have_selector(".total-delivery-price-wrapper .Value", :text => "€6.95")
    sleep 2
  end

  step "Add a comment", :story => "Add a comment" do
    find('.comments-wrapper').click
    find('.comments-content-wrapper textarea').set('Automation test - adding some commets to the order')
  end

  step "Click Proceed to checkout", :story => "Click Proceed to checkout" do
    find(".paypal-checkout").click
    #expect(page).to have_selector(".binary-popup-dialog")
  end
  # Popup is not disalyed since giftbox is added according to rules
  #step "Binary popup - Click No Thanks, Proceed to checkout", :story => "Binary popup - Click No Thanks, Proceed to checkout" do
    #expect(page).to have_selector(".binary-popup-dialog")
    #click_button "No Thanks, Proceed to checkout"
  #end

  step "Account page - fill in Information", :story => "Account page - fill in Information" do
    expect(page).to have_selector(".account-wrapper")
    fill_in_account_details
    select("Ireland",from: "Country:")
    #Percy::Capybara.snapshot(page, name: 'Account page is opened for paypal order')
  end

  step "Account page - Click Proceed to checkout button", :story => "Account page - Click Proceed to checkout button" do
    click_button "PROCEED TO CHECKOUT"
  end

  step "PayPal payment page - fill in Payment Details using PayPal and click login", :story => "PayPal payment page - fill in Payment Details using PayPal and click login" do
    if page.has_css?("#email")
    fill_in_paypal_details_and_click_login
    end
  end

  step "PayPal payment page - click Continue button", :story => "PayPal payment page - click Continue button" do
    click_button "Continue"
  end

  step "Thank you page - verify order details", :story => "Thank you page - verify order details" do
    find("[action='/Checkout/Thank-you-page.aspx']", wait: 20)
    expect(page).to have_selector("[action='/Checkout/Thank-you-page.aspx']")
    expect(page).to have_content("Your Order Has Been Received")
    expect(page).to have_no_selector(".thanksOrderCode", match: :first , :text =>"-")
    #Percy::Capybara.snapshot(page, name: 'Thank you page is displayed for paypal order payment')
  end

end

RSpec::Steps.steps "As a user i'm adding 5 items to the shopping cart, and checking out with PayPal method ", type: :feature, js: true, :order => :defined do

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

  step "Adding RING with single name - Irish Claddagh Ring with Engraving", :story => "Adding RING with single name - Irish Claddagh Ring with Engraving" do
    # visit "https://qa.kentico-test.com/Products/All-Rings/Irish-Claddagh-Ring-with-Engraving"
    find(".continue-shopping-wrapper .continue-shopping-button").click
    #find("[href='/Products/Shop-by-type/Rings']", wait: 2).click
    first('.sideBar').click_link('Rings')
    find("[title='See detail of Irish Claddagh Ring with Engraving']").click
    select("10", from: "Select ring size:")
    page.all("input.form-control[type='text']")[1].set("auto_test")
    find(".AddToCartLink").click
    expect(page).to have_content("Irish Claddagh Ring with Engraving")
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
     find(".paypal-checkout").click
  end
  #Popup is not displayed since giftbox is added by the rule
  #step "Binary popup - Click No Thanks, Proceed to checkout", :story => "Binary popup - Click No Thanks, Proceed to checkout" do
    #expect(page).to have_selector(".binary-popup-dialog")
    #click_button "No Thanks, Proceed to checkout"
  #end

  step "Account page - fill in Information", :story => "Account page - fill in Information" do
    expect(page).to have_selector(".account-wrapper")
    fill_in_account_details
    select("Ireland",from: "Country:")
  end

  step "Account page - Click Proceed to checkout button", :story => "Account page - Click Proceed to checkout button" do
    click_button "PROCEED TO CHECKOUT"
  end

  step "PayPal payment page - fill in Payment Details using PayPal and click login", :story => "PayPal payment page - fill in Payment Details using PayPal and click login" do
     if page.has_css?("#email")
     fill_in_paypal_details_and_click_login
      end
   end

   step "PayPal payment page - click Continue button", :story => "PayPal payment page - click Continue button" do
     click_button "Continue"
   end

   step "Thank you page - verify order details", :story => "Thank you page - verify order details" do
     find("[action='/Checkout/Thank-you-page.aspx']", wait: 20)
     expect(page).to have_selector("[action='/Checkout/Thank-you-page.aspx']")
     expect(page).to have_content("Your Order Has Been Received")
     expect(page).to have_no_selector(".thanksOrderCode", match: :first , :text =>"-")
     #Percy::Capybara.snapshot(page, name: 'Paypal order is successful for more than 1 product order')
   end

end

RSpec::Steps.steps "As a user i'm doing Full E2E flow and checking out with PayPal method (including purchase, automatic export, verify order in OM, and then verify order export status in Kentico BO)", type: :feature, js: true, :order => :defined do

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
     find(".paypal-checkout").click
  end
  # Popup is not displayed since giftbox is added, according to the rule
  #step "Binary popup - Click No Thanks, Proceed to checkout", :story => "Binary popup - Click No Thanks, Proceed to checkout" do
    #expect(page).to have_selector(".binary-popup-dialog")
    #click_button "No Thanks, Proceed to checkout"
  #end

  step "Account page - fill in Information", :story => "Account page - fill in Information" do
    expect(page).to have_selector(".account-wrapper")
    fill_in_account_details
    select("Ireland",from: "Country:")
  end

  step "Account page - Click Proceed to checkout button", :story => "Account page - Click Proceed to checkout button" do
    click_button "PROCEED TO CHECKOUT"
  end
  #Paypal sessions is still actual
  step "PayPal payment page - fill in Payment Details using PayPal and click login", :story => "PayPal payment page - fill in Payment Details using PayPal and click login" do
     if page.has_css?("#email")
     fill_in_paypal_details_and_click_login
     end
   end

   step "PayPal payment page - click Continue button", :story => "PayPal payment page - click Continue button" do
     click_button "Continue"
   end

   step "Thank you page - verify order details", :story => "Thank you page - verify order details" do
     find("[action='/Checkout/Thank-you-page.aspx']", wait: 20)
     expect(page).to have_selector("[action='/Checkout/Thank-you-page.aspx']")
     expect(page).to have_content("Your Order Has Been Received")
     $order_number = page.all(".thanksOrderCode")[0].text
     p $order_number
     $order_total_cost = page.all(".thanksOrderCode")[1].text.slice!(1..-1).to_i
     p $order_total_cost
     expect(page).to have_no_selector(".thanksOrderCode", match: :first , :text =>"-")
     #Percy::Capybara.snapshot(page, name: 'Paypal order is successful for IE site')
   end

   step "Kentico log in as global_admin_user", :story => "Kentico log in as global_admin_user" do
     visit main_site_admin_login
     user_login('global_admin_user')
   end
#Step is not actual since export is not set up on environment 
   #step "Go to Store configuration and activate 'Enable automatic order export' checkbox", :story => "Go to Store configuration and activate 'Enable automatic order export' checkbox" do
     #activate_automatic_export
   #end

   step "Search for the order in Orders Application", :story => "Search for the order in Orders Application" do
     bo_search_for_orderid($order_number)
   end

   step "Verify order status and price match", :story => "Verify order status and price match" do
     within_frame ("cmsdesktop") do
      within ("[data-objectid='#{$order_number}']") do
        @bo_order_price = find("td:nth-child(5)").text.slice!(1..-1).to_i
        ($order_total_cost).should eq(@bo_order_price)
        expect(page).to have_selector(".tag-dark", :text => "Payment received")
        expect(page).to have_selector(".tag-dark", :text => "Payment received")
        expect(page).to have_selector(".StatusEnabled", :text => "Yes")
        #Percy::Capybara.snapshot(page, name: 'Payment received status is displayed for paypal order in BO')
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
    #Percy::Capybara.snapshot(page, name: 'Automatic order export is successful for paypal order')
   end

   step "Login to old OM", :story => "Login to old OM" do
     visit om_admin_login
     om_user_login
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
     #Percy::Capybara.snapshot(page, name: 'Order in OM contains shipping address')
   end

end


RSpec::Steps.steps "As a user i should be able to checkout with PayPal with Invalid Coupon code, and move on to the Account page", type: :feature, js: true, :order => :defined do

  step "Adding Carrie style Necklace to the shopping cart ", :story => "Adding Carrie style Necklace to the shopping cart " do
    
    visit main_site
    # visit "https://qa.kentico-test.com/Products/Shop-by-type/Necklaces/Infinity-Name-Necklace"
    first('.sideBar').click_link('Necklaces')
    #find("[href='/Category/Full-Necklace-Collection']", wait: 2).first.click
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
    #Percy::Capybara.snapshot(page, name: 'Error is displayed for applied coupon that invalid')
  end

  step "Click Proceed to checkout", :story => "Click Proceed to checkout" do
     find(".paypal-checkout").click
     expect(page).to have_selector(".pagesContent")
     #Percy::Capybara.snapshot(page, name: 'Account details page is opened with applied coupon that invalid')
  end
 # Popup is not displayed since gift box is added, step is not working properly
  #step "Binary popup - Click No Thanks, Proceed to checkout", :story => "Binary popup - Click No Thanks, Proceed to checkout" do
    #expect(page).to have_selector(".binary-popup-dialog")
    #expect(page).to have_selector(".modal-content")
      #find('.continue-shopping-button', :text => 'No Thanks, Proceed to checkout').click
      
      #find(:xpath, ".//*[@id='p_lt_ctl11_pageplaceholder_p_lt_ctl01_pageplaceholder_p_lt_ctl01_pageplaceholder_p_lt_ctl00_ColumnLayout3_ColumnLayout3_r1_BinaryPopup1_btnCancel']").click
      #first("[value='No Thanks, Proceed to checkout']").click
      #expect(page).to have_selector(".account-wrapper")

  #end

  step "Account page - fill in Information", :story => "Account page - fill in Information" do
    expect(page).to have_selector(".account-wrapper")
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
    sleep 2
    @shipping_price_after = find(".shopping-cart-wrapper .Value span").text.slice!(1..-1).to_i
    @shipping_price_before.should_not eq(@shipping_price_after)
    #Percy::Capybara.snapshot(page, name: 'Shipping price is changed after select another delivery option')
  end

end
