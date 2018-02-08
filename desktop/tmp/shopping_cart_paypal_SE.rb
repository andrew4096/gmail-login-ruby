require './helpers/spec_helper.rb'

describe 'Shopping product via Paypal on SE site', :feature => "Shopping product via Paypal  on SE site", :severity => :normal do

 before(:step) do |s|
    puts "Before step #{s.current_step}"
  end

  before (:each) do
      visit main_site_se
    end


it "Search for product, add to basket and buy it via Paypal and check it on OM side", :story => "Search for product, add to basket and buy it via Paypal and check it on OM side", :severity => :normal do |e|
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

    e.step "Get product price from basket" do |s|
        $price1 = get_product_price
    end

    e.step "Add gift box and verify it's in basket" do |s|
        #add_giftbox
    end

    e.step "Add coupon" do |s|
        add_coupon ("ny10")
    end

    e.step "Select not 0 delivery option and check delivery price is changed, total as well" do |s|
        select_delivery
        price2 = get_total_price
        expect(price2).should_not equal($price1)
    end

    e.step "Click Proceed to checkout and fill in custoer details" do |s|
        proceed_paypal
    end
    sleep 3
    e.step "temporary step for giftbox popup" do |s|
        #giftbox_popup     
    end 

sleep 3
    e.step "Fill in account details and click Proceed" do |s|
        first_name = getname
        last_name = getname
        fill_details_click_proceed(first_name, last_name)
    end
sleep 5
    e.step "Fill in paypal login details and login" do |s|
        if page.has_css?("#email")
        fill_in_paypal_details_and_click_login
        end 
    end

    e.step "Click Continue on Paypal side to pay for order" do |s|
        click_button "Continue"
    end

    e.step "Check Thank you page" do |s|
        thankyoupage
        $orderid = thankyoupage[0]
        $order_total_price = thankyoupage[1].slice!(0..-4).to_i
        p $order_total_price
        #Percy::Capybara.snapshot(page, name: 'Paypal Payment is successful for order on IE site')
        # add item count check here
    end 

    e.step "Kentico log in as global_admin_user" do |s|
     visit main_site_admin_se
     user_login('global_admin_user')
    end

    e.step "Search for the order in Orders Application" do |s|
     bo_search_for_orderid($orderid)
    end

    e.step "Verify order status and price match" do |s| 
    #bo_price = PriceExtract.new 
     within_frame ("cmsdesktop") do
      within ("[data-objectid='#{$orderid}']") do
        @bo_order_price = find("td:nth-child(5)").text.slice!(0..-4).to_i
        ($order_total_price).should eq(@bo_order_price)
        expect(page).to have_selector(".tag-dark", :text => "Payment received")
        expect(page).to have_selector(".tag-dark", :text => "Payment received")
        expect(page).to have_selector(".StatusEnabled", :text => "Yes")
        #Percy::Capybara.snapshot(page, name: 'Paypal Order has Payment received status')
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
        #Percy::Capybara.snapshot(page, name: 'Automatic order export for paypal order is successful in BO')
    end 

    e.step "Login to old OM SE" do |s|
     visit om_admin_login_se
     om_user_login_se
   end

   e.step "Find order in OM By Receipt ID" do |s|
    #click_link ('link3')
    #click_button 'm_btnGetOrders'
    select('Receipt ID', :from => 'm_dropListSearchCriteria1')
    fill_in("m_txtSearchOrder1", :with => $orderid)
    click_button 'm_btnSearchOrders'
    expect(page).to have_content($omname)
   end

   e.step "Enter into the Order and Search for Receipt ID and validate items" do |s|
     find("[value='Select']", match: :first).click
     #expect(page).to have_selector("#m_panelOrderDisplayRight table", count: 2)
     expect(page).to have_selector("#m_txtBoxReceiptID[value='#{$orderid}']")
     expect(find("#m_txtBoxShippingAddress").text).not_to be_empty
     #Percy::Capybara.snapshot(page, name: 'Check order in OM site with shipping address details')
   end

end

it "Add 2 products to the shopping cart, and apply a valid coupon, buy it via Paypal", :story => "Add 2 products to the shopping cart, and apply a valid coupon, buy it via Paypal", :severity => :normal do |e|
    e.step "Click the Basket icon to open it and verify it's empty" do |s|
        
        clear_basket
        expect(page).to have_selector(".emptyCartBox")  
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

    e.step "Add gift box and verify it's in basket" do |s|
        sleep 5
        #add_giftbox
    end

    e.step "Click Proceed to checkout and fill in custoer details" do |s|
        proceed_paypal
    end

    sleep 3
    e.step "temporary step for giftbox popup" do |s|
        #giftbox_popup     
    end 

sleep 3
    e.step "Fill in account details and click Proceed" do |s|
        first_name = getname
        last_name = getname
        fill_details_click_proceed(first_name, last_name)
    end
sleep 5
    e.step "Fill in paypal login details and login" do |s|
        if page.has_css?("#email")
        fill_in_paypal_details_and_click_login
        end 
    end

    e.step "Click Continue on Paypal side to pay for order" do |s|
        click_button "Continue"
    end

    e.step "Check Thank you page" do |s|
        thankyoupage
        #Percy::Capybara.snapshot(page, name: 'Paypal order is successful for more than 1 product order')
    end 

end 




it "Proceed with invalid coupon", :story => "Proceed with invalid coupon", :severity => :normal do |e|

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
    end

    e.step "Click Proceed with Paypal and check account details page is opened" do |s|
        proceed_paypal
        sleep 3
        
            giftbox_popup     
        
        @first_name = getname
        @last_name = getname
        fill_details_click_proceed(@first_name, @last_name)
        sleep 5
    end 

end

end