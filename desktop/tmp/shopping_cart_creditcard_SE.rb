require './helpers/spec_helper.rb'

describe 'Shopping product via credit card on SE site', :feature => "Shopping product via credit card on SE site", :severity => :normal do

 before(:step) do |s|
    puts "Before step #{s.current_step}"
  end

  before (:each) do
      visit main_site_se
    end

it "Check the basket is empty", :story => "Check the basket is empty", :severity => :normal do |e|
    
    e.step "Visit home page and verified it opened" do |s|
        visit_homepage (main_site_se)
    end

    e.step "Click the Basket icon to open it and verify it's empty" do |s|
        clear_basket
        expect(page).to have_selector(".emptyCartBox")  
    end

end

it "Search for product, add to basket and buy it", :story => "Search for product, add to basket and buy it", :severity => :normal do |e|
    e.step "Click the Basket icon to open it and verify it's empty" do |s|
        
        clear_basket
        expect(page).to have_selector(".emptyCartBox") 
        #Percy::Capybara.snapshot(page, name: 'Empty Shoppingcard') 
    end
    
    e.step "Search for product via search field and verified product page is opened" do |s|
        search_product ("Vertikalt Infinity Namnhalsband")
        #Percy::Capybara.snapshot(page, name: 'Namnhalsband Product page is displayed')
    end

    e.step "Add product details on product page and add it to basket" do |s|
    set_option_product_2_option
    add_product_to_basket
    #Temporary steps for custom product flow
    sleep 6
    click_basket
    #Temporary steps end
    check_product_in_basket ("Vertikalt Infinity Namnhalsband")
    #Percy::Capybara.snapshot(page, name: 'Namnhalsband prodcut is in basket')
    end

    e.step "Get product price from basket" do |s|
        $price1 = get_product_price
    end

    e.step "Add coupon and verify it's applied" do |s|
        add_coupon ("ny10")
        # get new total price string
        
        new_total_price = get_total_price
        extract = PriceExtract.new
        # get int from product price string
        product_price = extract.price_extract_slice_se ($price1)
        p product_price
        # get int from new total price string to int
        total_price = extract.price_extract_slice_se (new_total_price)
        p total_price
        # convert total price from int to float
        float_total_price = total_price.to_f
        p float_total_price
        # calculate new product price with coupon in float
        c_price = coupon_price(product_price, 10)
        p c_price
        # compare new total price with calculated as strings
        expect(c_price.to_s).to eq(float_total_price.to_s) #change to string
        #Percy::Capybara.snapshot(page, name: 'Namnhalsband prodcut coupon is applied')
    end
    # alternative coupon test
    #e.step "Add coupon and verify it's applied properly" do |s|
        
        #add_coupon_check (coupon, coupon_percentage, product_price, total_price)
    #end 

    e.step "Add gift box and verify it's in basket" do |s|
        #add_giftbox
    end

    e.step "Click Proceed to checkout and fill in customer details" do |s|
        click_proceed_to_checkout
        #Percy::Capybara.snapshot(page, name: 'Customer details page is opened')
    end
sleep 3
    e.step "temporary step for giftbox popup" do |s|
        #giftbox_popup     
    end 

    e.step "Fill in account details and click Proceed" do |s|
        first_name = getname
        last_name = getname
        $omname = last_name
        fill_details_click_proceed(first_name, last_name)
        #Percy::Capybara.snapshot(page, name: 'Creditcard Payments details page is opened')
    end
sleep 5
    e.step "Fill in payment details and Pay" do |s|
        fill_details_pay_mastercard
    end

    e.step "Check Thank you page" do |s|
        thankyoupage
        $orderid = thankyoupage[0]
        $order_total_price = thankyoupage[1].slice!(0..-4).to_i
        # add item count check here
        #Percy::Capybara.snapshot(page, name: 'Thank you page is displayed - Creditcard successful payment')
    end 

    e.step "Go to Basket and verify it's empty after order is done" do |s|
        click_basket
        expect(page).to have_selector(".emptyCartBox")  
    end

    e.step "Kentico log in as global_admin_user" do |s|
     visit main_site_admin_se
     user_login('global_admin_user')
     #Percy::Capybara.snapshot(page, name: 'Login to BackOffice as admin is successful')
    end

    e.step "Search for the order in Orders Application" do |s|
     bo_search_for_orderid($orderid)
     #Percy::Capybara.snapshot(page, name: 'Search order by ID')
    end

    e.step "Verify order status and price match" do |s| 
    # order_status_bo_se (order_price_int, order_id)  #Implement after BO fixed
     within_frame ("cmsdesktop") do
      within ("[data-objectid='#{$orderid}']") do
        @bo_order_price = find("td:nth-child(5)").text.slice!(0..-4).to_i
        ($order_total_price).should eq(@bo_order_price)
        expect(page).to have_selector(".tag-dark", :text => "Payment received")
        expect(page).to have_selector(".tag-dark", :text => "Payment received")
        expect(page).to have_selector(".StatusEnabled", :text => "Yes")
        #Percy::Capybara.snapshot(page, name: 'Paid order has correct status - Payment received')
      end
     end
    
   end

   e.step "Edit selected otder" do |s|
     within_frame ("cmsdesktop") do
      within ("[data-objectid='#{$orderid}']") do
        find(".icon-edit").click
        # sleep 300
      end
      end
    end 


   e.step "Wait until order is exported" do |s|
    bo_wait_for_order_status_update_to_success ($orderid)
    #Percy::Capybara.snapshot(page, name: 'Automatic order export is processed for paid order')
    end 


   e.step "Login to old OM SE" do |s|
     visit om_admin_login_se
     om_user_login_se
     #Percy::Capybara.snapshot(page, name: 'Login to OM site is successful')
   end

   e.step "Find order in OM By Receipt ID" do |s|
    #click_link ('link3')
    #click_button 'm_btnGetOrders'
    select('Receipt ID', :from => 'm_dropListSearchCriteria1')
    fill_in("m_txtSearchOrder1", :with => $orderid)
    click_button 'm_btnSearchOrders'
    expect(page).to have_content($omname)
    #Percy::Capybara.snapshot(page, name: 'Search order by ID')
   end

   e.step "Enter into the Order and Search for Receipt ID and validate items" do |s|
     find("[value='Select']", match: :first).click
     #expect(page).to have_selector("#m_panelOrderDisplayRight table", count: 2)
     expect(page).to have_selector("#m_txtBoxReceiptID[value='#{$orderid}']")
     expect(find("#m_txtBoxShippingAddress").text).not_to be_empty
     #Percy::Capybara.snapshot(page, name: 'Current Order contains shipping address')
   end

end

it "Add 2 products to the shopping cart, and apply a valid coupon, then remove 1 product , and 'remove' button link is not changed to 'update' button link", :story => "Add 2 products to the shopping cart, and apply a valid coupon, then remove 1 product , and 'remove' button link is not changed to 'update' button link", :severity => :normal do |e|
    e.step "Click the Basket icon to open it and verify it's empty" do |s|
        
        clear_basket
        expect(page).to have_selector(".emptyCartBox")  
    end


    e.step "Search for 1st product via search field and verified product page is opened" do |s|
        search_product ("Guldpläterat Brick Halsband med Ikon")
        #Percy::Capybara.snapshot(page, name: 'Halsband prodcut page is opened')
    end

    e.step "Add 1st product details on product page and add it to basket" do |s|
        set_option_product_1_option
        add_product_to_basket
        #Temporary steps for custom product flow
        sleep 6
        click_basket
        #Temporary steps end
        check_product_in_basket ("Guldpläterat Brick Halsband med Ikon")
        #Percy::Capybara.snapshot(page, name: 'Halsband prodcut is added to basket')
    end
sleep 3
    e.step "Search 2nd for product via search field and verified product page is opened" do |s|
        search_product ("Vertikalt Infinity Namnhalsband")
    end
sleep 3
    e.step "Add 2nd product details on product page and add it to basket" do |s|
    set_option_product_2_option
    add_product_to_basket
    #Temporary steps for custom product flow
    sleep 6
    click_basket
    #Temporary steps end
    check_product_in_basket ("Vertikalt Infinity Namnhalsband")
    end

    e.step "Add valid coupon" do |s|
    add_coupon ("ny10") 
    end

    e.step "Remove 1st product and check Remove label is not changed" do |s|
        expect(page).to have_selector(".RemoveButton", count: 2)
        @remove_button_text_before = find(".RemoveButton span", match: :first).text
        find(".RemoveButton span", match: :first).click
        expect(page).to have_selector(".RemoveButton", count: 1)
        @remove_button_text_after = find(".RemoveButton span", match: :first).text
        @remove_button_text_before.should eq(@remove_button_text_after)
        #Percy::Capybara.snapshot(page, name: 'Remove label is not changed after removing one of products')
    end 

end 

it "Add product and GiftBox to the shopping cart, continue with creditcart method then change payment method to paypal and verify the is only 1 new order for this flow", :severity => :normal do |e|
    e.step "Check basket is empty and clear it if not" do |s|
        clear_basket
    end

    e.step "Search for 1st product via search field and verified product page is opened" do |s|
        search_product ("Guldpläterat Brick Halsband med Ikon")
    end

    e.step "Add 1st product details on product page and add it to basket" do |s|
        set_option_product_1_option
        add_product_to_basket
        #Temporary steps for custom product flow
        sleep 6
        click_basket
        #Temporary steps end
        check_product_in_basket ("Guldpläterat Brick Halsband med Ikon")
    end
sleep 3

    e.step "Get product price from basket" do |s|
        $price_for_delivery = get_product_price
    end

    e.step "Select not 0 delivery option and check delivery price is changed, total as well" do |s|
        select_delivery
        price2 = get_total_price
        expect(price2).should_not equal($price_for_delivery)
        #Percy::Capybara.snapshot(page, name: 'Delivery price is changed according to selected option')
    end

    e.step "Add gift box and verify it's in basket" do |s|
       # add_giftbox
    end

    #e.step "Add valid coupon" do |s|
    #add_coupon ("ny10") 
    #end

    e.step "Click Proceed to checout and fill in custoer details" do |s|
        click_proceed_to_checkout
    end

    e.step "temporary step for giftbox popup" do |s|
        #giftbox_popup
    end

    e.step "Fill in account details and click Proceed" do |s|
        first_name = getname
        last_name = getname
        fill_details_click_proceed(first_name, last_name)
    end

    e.step "Return to shopping cart" do |s|
        return_to_cart
        #Percy::Capybara.snapshot(page, name: 'Return to shoppingcart after paymentdetailspage')
    end 

    e.step "click Proceed with Paypal" do |s|
        proceed_paypal
        #Percy::Capybara.snapshot(page, name: 'Paypal payments details page is opened')
    end

    e.step "Fill in account details and click Proceed" do |s|
        $first_name1 = getname
        $last_name1 = getname
        fill_details_click_proceed($first_name1, $last_name1)
        $email1 = "#{$first_name1}@novus.io"
    end

    e.step "Fill in paypal login details and login" do |s|
        if page.has_css?("#email")
        fill_in_paypal_details_and_click_login
        end 
        #Percy::Capybara.snapshot(page, name: 'Paypal login is successful')
    end

    e.step "Click Continue on Paypal side to pay for order" do |s|
        click_button "Continue"
    end

    e.step "Check Thank you page is displayed and get order details" do |s|
        thankyoupage
        #add items in order check on thank you page
        #Percy::Capybara.snapshot(page, name: 'Thankyou page is opened for Paypal payment')
    end 

    e.step "Login to BO as admin user" do |s|
        visit main_site_admin_se
        user_login('global_admin_user')
    end 

    e.step "search for order and check it's only 1 order in BO" do |s|
        sarchforuniqueorder($first_name1, $last_name1, $email1)
        #Percy::Capybara.snapshot(page, name: 'Search order by email in BO')
    end

end


it "Proceed with invalid coupon", :story => "Proceed with invalid coupon", :severity => :normal do |e|

    e.step "Click the Basket icon to open it and verify it's empty" do |s|
        
        clear_basket
        expect(page).to have_selector(".emptyCartBox")  
    end
    
    e.step "Search for product via search field and verified product page is opened" do |s|
        search_product ("Vertikalt Infinity Namnhalsband")
    end

    e.step "Add product details on product page and add it to basket" do |s|
    set_option_product_2_option
    add_product_to_basket
    #Temporary steps for custom product flow
    sleep 6
    click_basket
    #Temporary steps end
    check_product_in_basket ("Vertikalt Infinity Namnhalsband")
    end

    e.step "Add gift box and verify it's in basket" do |s|
        #add_giftbox
    end

    e.step "Add invalid coupon and check for error" do |s|
        add_coupon ("invalid")
        expect(page).to have_selector("[id*='DiscountCoupon_lblError']")
        #Percy::Capybara.snapshot(page, name: 'Error is displayed for invalid coupon')
        
    end

    e.step "Click Proceed and check account details page is opened" do |s|
        click_proceed_to_checkout
        #temporary action with giftbox popup
        #giftbox_popup
        @first_name = getname
        @last_name = getname
        fill_details_click_proceed(@first_name, @last_name)
        #Percy::Capybara.snapshot(page, name: 'Customer details page is opened after invalid coupon is applied')
    end 

end 

 

end