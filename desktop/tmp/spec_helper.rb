require "./helpers/spec_browser_ch.rb"
# require "./helpers/spec_non_browser_poltergeist.rb" # non browser driver

# RSpec.configure do |c|
#       c.include AllureRSpec::Adaptor
#     end

module WaitForAjax  #use "wait_for_ajax" in tests to wait ajax loading
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end
# sites link methods
def prod_site
  return 'https://www.mynamenecklace.ie/'
end

def prod_site_admin_login
  return 'https://www.mynamenecklace.ie/Admin/CMSAdministration.aspx'
end

def main_site
  #return 'https://qa.kentico-test.com/'
  return 'https://qa.ems.ie/'
end

def main_site_se
  return 'https://qa.ems.se'
end

def main_site_admin_login
  return 'https://qa.ems.ie/Admin/CMSAdministration.aspx'
end

def main_site_admin_se
  return 'https://qa.ems.se/Admin/CMSAdministration.aspx'
end 

def om_admin_login
  return 'http://office.demo.mynamenecklace.ie/'
end

def om_admin_login_se
  return 'http://office.demo.mittnamnhalsband.se/Admin/Login.aspx?ReturnUrl=%2fAdmin%2fEcomAdminOrdersManager.aspx'
end 
# login methods
def user_login(usertype)
if page.has_no_css?('header')
  case usertype
  when 'global_admin_user'
      fill_in("User name:", :with => "auto_qa_admin@novus.io")
      fill_in("Password:", :with => "12345678")
      click_button 'Login1_LoginButton'
    when 'admin_user'
      fill_in("User name:", :with => "auto_qa_viewer@novus.io")
      fill_in("Password:", :with => "12345678")
      click_button 'Login1_LoginButton'
    when 'editor_user'
      fill_in("User name:", :with => "auto_qa_editor@novus.io")
      fill_in("Password:", :with => "12345678")
      click_button 'Login1_LoginButton'
  end
end
end

def om_user_login
  fill_in("m_txtBoxUserName", :with => "automation")
  fill_in("m_txtBoxPassword", :with => "automation")
  click_button 'm_btnLogin'
end

def om_user_login_se
  fill_in("m_txtBoxUserName", :with => "mark")
  fill_in("m_txtBoxPassword", :with => "mark")
  click_button 'm_btnLogin'
end

def fill_in_paypal_details_and_click_login
  paypaliframe = find(:xpath, '//*[@id="injectedUnifiedLogin"]/iframe')[:name]
  page.driver.browser.switch_to.frame paypaliframe
  fill_in("email", :with => "developer@specifik.com")
  fill_in("password", :with => "developer")
  click_button "btnLogin"
end

# payment page details
def fill_in_account_details
  #fill_in("First name:", :with => "automation_test")
  find("[name*='CustomerFirstName']").set("automation_test")
  #fill_in("Last Name:", :with => "automation_test")
  find("[name*='CustomerLastName']").set("automation_test")
  fill_in("Email:", :with => "automation_test@novus.io")
end

def fill_in_creditcard__payment_details
  fill_in("Card number", with: "5555555555554444")
  #fill_in("First name", with: "automation_test")
  find("[name*='txtFirstName']").set("automation_test")
  #fill_in("Last name", with: "automation_test")
  find("[name*='txtLastName']").set("automation_test")
  find(".exp-date option[value='1']").click
  #find("[name*='drpMonths']").click
  #find("[value='2']", :text => '02').click
  #select("[value='2']", from: "[name*='drpMonths']").select_option
  find(".exp-date option[value='2019']").click
  fill_in("Security code", with: "111")
end

def fill_in_creditcard_billing_information
  within(".billing-information-wrapper") do
    fill_in("Name:", with: "automation_test")
    fill_in("Email:", with: "automation_test@novus.io")
    fill_in("Phone number (optional):", with: "9987545645646")
    fill_in("Street Address:", with: "Test_Street")
    fill_in("City:", with: "Test_City")
    select('Ireland', from: 'Country:')
    fill_in("Zip/ Postal code:", with: "88788")
  end
end

def fill_in_creditcard_shipping_information
  within(".shipping-information-wrapper") do
    fill_in("Name:", with: "automation_test")
    fill_in("Email:", with: "automation_test@novus.io")
    fill_in("Street Address:", with: "Test_Street")
    fill_in("City:", with: "Test_City")
    select('Ireland', from: 'Country:')
    fill_in("Zip/ Postal code:", with: "88788")
  end
end

def fill_in_tgpayment_details
  fill_in("m_txtCardNumber", with: "123123")
  select('05', from: 'm_dropListCardDateMonth')
  select('2018', from: 'm_dropListCardYear')
  fill_in("m_txtCvv", with: "666")

  fill_in("m_txtBoxFirstName", with: "automation test")
  fill_in("m_txtPhoneNumber", with: "98798798778")
  fill_in("m_txtBoxBillingAddress", with: "Best Street")
  fill_in("m_txtBoxCity", with: "Bombabu")
  select('Cavan', from: 'm_dropListStateName')
  fill_in("m_txtBoxZipCode", with: "23423")
  click_button "m_btnPayment"
end

def caching_all_products
  $categories = all('.side-menu-box a').map { |a| a['href'] }
  $categories.each_with_index do |val1, index1|
    page.all('.side-menu a')[index1].click

    # $pages_num = all('.pagerBox a').map { |a| a['a'] }
    # $pages_num.each_with_index do |val2, index2|
    # page.all('.pagerBox a')[index2].click
    # p $pages_num.count

      $products = all('.catProductTeaser a').map { |a| a['href'] }
      $products.each_with_index do |val3, index3|
        page.all('.catProductTeaser a')[index3].click
        page.all('.side-menu a')[index1].click
        page.all('.pagerBox a')[index2].click
      end
    end
  # end
end

def add_random_product_to_the_shopping_cart
  $categories_link = all('.side-menu-box a').map { |a| a['href'] }
  page.all('.side-menu a')[rand($categories_link.size)].click

  if page.has_selector?(".pagerBox")
    $pages_num = all('.pagerBox a').map { |a| a['a'] }
    if rand(0..$pages_num.count) != 0
      page.all('.pagerBox a')[rand($pages_num.size)].click
    end
  end

  $products_link = all('.catProductTeaser a').map { |a| a['href'] }
  page.all('.catProductTeaser a')[rand($products_link.size)].click

  $product_name = find("[itemprop='name']").text

  $select_size = all('.ProductOptionSelectorContainer select').map { |a| a['select'] }
  $select_size.each_with_index do |val, index|
    @num_of_options = (all("select")[index].all("option")).size
    page.all('.ProductOptionSelectorContainer select')[index].find(:xpath, "option[#{rand(2..@num_of_options)}]").select_option
  end
  # sleep 6
  $input_size = all('.ProductOptionSelectorContainer input').map { |a| a['input'] }
  $input_size.each_with_index do |val, index|
    @rand_name = Array.new(3){[*'a'..'z', *'A'..'Z'].sample}.join
    page.all('.ProductOptionSelectorContainer input')[index].set(@rand_name)
  end

  # if there are new options has been opened after selecting dropdown with show&hide functionality - function update the category optios and fill them in
  if page.has_selector?("[selected='selected'][value='0']")
    $select_size = all('.ProductOptionSelectorContainer select').map { |a| a['select'] }
    $select_size.each_with_index do |val, index|
       @num_of_options = (all("select")[index].all("option")).size
      page.all('.ProductOptionSelectorContainer select')[index].find(:xpath, "option[#{rand(2..@num_of_options)}]").select_option
    end

    $input_size = all('.ProductOptionSelectorContainer input').map { |a| a['input'] }
    $input_size.each_with_index do |val, index|
      @rand_name = Array.new(3){[*'a'..'z', *'A'..'Z'].sample}.join
      page.all('.ProductOptionSelectorContainer input')[index].set(@rand_name)
    end

  end

  find(".AddToCartLink").click

    # in case there is an error with one of the options, enter to another loop to
    if page.has_selector?(".OptionCategoryError")
      $select_size = all('.ProductOptionSelectorContainer select').map { |a| a['select'] }
      $select_size.each_with_index do |val, index|
        @num_of_options = (all("select")[index].all("option")).size
        page.all('.ProductOptionSelectorContainer select')[index].find(:xpath, "option[#{rand(2..@num_of_options)}]").select_option
      end

      $input_size = all('.ProductOptionSelectorContainer input').map { |a| a['input'] }
      $input_size.each_with_index do |val, index|
        @rand_name = Array.new(3){[*'a'..'z', *'A'..'Z'].sample}.join
        page.all('.ProductOptionSelectorContainer input')[index].set(@rand_name)
      end

      find(".AddToCartLink").click
    end
    # sleep 3
  expect(page).to have_selector(".shopping-cart-wrapper")
  expect(page).to have_content($product_name)
end

def activate_automatic_export
  find('.cms-nav-icon-large').click
  fill_in("app_search", with: "Store configuration")
  find(".app-configuration").click
  find(".app-configuration").click
  within_frame ("cmsdesktop") do
    find("#TabLink_11").click
    sleep 1
    page.find("#TabItem_1").drag_to(page.find("#TabItem_12"))
    find(".tab-title", text: "Automatic order export").click
    find(".tab-title", text: "Automatic order export").click
  end
  within_frame ("cmsdesktop") do
   within_frame ("c") do
     execute_script('document.getElementById("m_c_chkIsAutoOrderExportEnabled_checkbox").checked = true;')
     click_button "Save"
     expect(page).to have_selector(".alert-success")
    end
  end
end

def bo_search_for_orderid(order_id)
  find('.cms-nav-icon-large').click
  find(".accordion-toggle", text: "E-commerce").click
  find('.app-orders').click
  find('.app-orders').click
   within_frame ("cmsdesktop") do
     fill_in("m_c_orderListElem_gridElem_cf_txtOrderId", with: order_id)
     click_button "Search"
     expect(page).to have_selector("[data-objectid='#{order_id}']", :count => 1)
   end
end

def bo_wait_for_order_status_update_to_success(order_id)
  within_frame ("cmsdesktop") do
   within_frame ("c") do
     expect(page).to have_selector("#m_c_editOrderGeneral_ncporderid", text: order_id)
     expect(page).to have_selector("#m_c_editOrderGeneral_OrderStatusID_s_drpSingleSelect", text: "Payment received")
   end
 end

  within_frame ("cmsdesktop") do
     @max_time_wait = 300
     @time_count = 0
     while @max_time_wait > @time_count
       sleep 5
       find("#TabLink_0").click
       within_frame ("c") do
         if  find("#m_c_editOrderGeneral_OrderExportStatus_dropDownList option:checked").text == "Success"
           #find(:css, 'select#country').value ).to eq('BR')
           return
         else
           p "current count is = #{@time_count}, adding more 5 sec"
           @time_count += 5
         end
       end
     end
   end

   within_frame ("cmsdesktop") do
    within_frame ("c") do
      expect(page).to have_selector("#m_c_editOrderGeneral_OrderExportStatus_dropDownList option", text: "Success")
    end
  end
end
#homepage methods
def visit_homepage (instance)
    visit instance
    expect(page).to have_selector(".mnnLogo")
end

def trackmyordertop
        find(".top-right-item [href='/track-my-order']").click 
        expect(page).to have_selector(".track-order-inner")
        expect(page).to have_selector(".order-tracking-teaser")
        expect(page).to have_selector("[id*='orderid']")
        expect(page).to have_selector("[id*='ordercustomerid']")
        expect(page).to have_selector(".btn-primary")
end 

def favicon
  expect(page).to have_selector("[href='/App_Themes/Favicons/favicon.ico']")
end 

def click_basket
    find(".shopping-cart-total-items-container").click
end

def clear_basket
    find(".shopping-cart-total-items-container").click
    until page.has_no_css?(".RemoveButton") do
      first(".RemoveButton").click
      sleep 3
      expect(page).to have_selector(".pagesContent")
    end   
end 

def submenus_for_1st_topmenu (i)
        n = i - 1
        submenu_array = Array(0..n)
        p submenu_array
        submenu_array.each_with_index { 
            |val, index|
        find(".topMenu .topMenuItem", match: :first).click
        find(".topMenu .topMenuItem", match: :first).all(".subMenuItem")[index].click
        expect(page).to have_selector(".searchResultBox")
        }
end 

def submenus_for_x_topmenu (topmenu_number, submenu_number)
        m = topmenu_number - 1
        n = submenu_number - 1
        submenu_array = Array(0..n)
        p submenu_array
        submenu_array.each_with_index { 
            |val, index|
        all(".topMenu .topMenuItem")[m].click
        all(".topMenu .topMenuItem")[m].all(".subMenuItem")[index].click
        expect(page).to have_selector(".searchResultBox")
        }
end 

def search_product (exact_product_name)
    find('.searchInput').set(exact_product_name) #+ ' ')
      within(".predictiveSearchResults") do
        sleep 7
        first(".category-text").click
        #find(".category-text")[0].click 
      end
      expect(page).to have_selector(".productTitle", :text => "#{exact_product_name}")
end

def add_product_to_basket
  find("[id*='AddToCartButton']").click
end 

def check_product_in_basket (exact_product_name)
  expect(page).to have_selector(".item-name", :text => "#{exact_product_name}")
end 

def giftbox_popup
    sleep 2
          if page.has_css?(".binary-popup-dialog")
            find("[id*='btnCancel']").click 
          end
end

# page not found
def check404 (site, text)
        visit "#{site}/not-a-valid-page.aspx"
        expect(page).to have_selector(".thank-you-inner", :text => text)
        expect(page).to have_selector(".topHeader")
        expect(page).to have_selector(".topMenu")
        expect(page).to have_selector(".sideBar")
        expect(page).to have_selector(".footerSecure")
        expect(page).to have_selector(".footerReviews")
        expect(page).to have_selector(".footerCustomerTitleReviews")
        expect(page).to have_selector(".footerBannerWrap")
        expect(page).to have_selector(".footerCollectionWrapper") 
end 

#product page
def set_option_product_2_option
  page.all("input.form-control[type='text']")[0].set("test1")
  page.all("input.form-control[type='text']")[1].set("test2")
end 

def set_option_product_1_option
  page.all("input.form-control[type='text']")[0].set("test2")
end 

def get_product_price
  return find(".item-total").text
end

def alsolike (productname)
  expect(page).to have_selector("[itemprop='name']", :text => productname)
  expect(page).to have_selector(".alsoLikeItems")
  expect(page).to have_selector(".related-prod-item", :count => 4)
end

def comparepricesave_se
  @listprice = find('.originalPrice').text.slice!(0..-4).to_i
  @finalprice = find('.finalPrice').text.slice!(0..-4).to_i
  @yousave_price = find("[id*='PriceSaving']").text.slice!(0..-10).to_i 
  (@listprice - @finalprice).should eq(@yousave_price)
end 

def product_image_slider
  expect(page).to have_selector(".productPublicStatus")
  expect(page).to have_selector(".productMainImageContainer")
  expect(page).to have_selector(".smallImagesBox")
  find(".productMainImageContainer").click
  expect(page).to have_selector(".boxOverlay[style='display: block;']")
  find(".bigImgInnerBox .nextImg").click
  expect(page).to have_selector(".preImg[style='display: block;']")
  find(".bigImgInnerBox .nextImg").click
end
#basket page
def add_giftbox
  find('.shopping-giftbox-msg').click
  expect(page).to have_selector(".productTitle")
  find("textarea.form-control",wait: 1).set("Automation test adding a gift box text")
  sleep 3
  find(".AddToCartLink").click
  expect(page).to have_selector("[alt='Gift Box preview']")
end 

def add_coupon (coupon)
  first(".fa-plus").click
  find(".coupon-text").set(coupon)
  find(".btn-apply-coupon").click
  expect(page).to have_selector(".shopping-products-wrap")
end 

def add_coupon_check (coupon, coupon_percentage, product_price, total_price)
  first(".fa-plus").click
  find(".coupon-text").set(coupon)
  find(".btn-apply-coupon").click
  expect(page).to have_selector(".shopping-products-wrap")
  float_total_price = total_price.to_f
  discount = product_price.to_f * coupon_percentage.to_f / 100
  product_end_price = product_price.to_f - discount       
  expect(product_end_price.to_s).to eq(float_total_price.to_s) 
end

def coupon_price (p_price, c_percentage) # returns float!!!
  discount = p_price.to_f * c_percentage.to_f / 100
  p_end_price = p_price.to_f - discount
  return p_end_price
end 

def select_delivery
  delivery_price1 = find(".checkout-shipping-selections-total .TotalViewer .Value").text
  p delivery_price1
  page.all(".shipping-option-wrapper")[1].click
  sleep 3
  delivery_price2 = find(".checkout-shipping-selections-total .TotalViewer .Value").text 
  expect(delivery_price2).should_not equal(delivery_price1)
end 

def get_total_price
  return find(".total-value").text 
end 

def click_proceed_to_checkout
  first(".proceed-checkout-button").click
end 

#payment page
def fill_details_click_proceed (fname, lname)
  expect(page).to have_selector(".account-wrapper")
  find("[name*='CustomerFirstName']").set(fname)
  find("[name*='CustomerLastName']").set(lname)
  find("[name*='CustomerEmail']").set("#{fname}@novus.io")
  find("[name*='DocumentWizardButton']").click
end 

def  fill_details_pay_mastercard
  expect(page).to have_selector("#m_sectionPersonal")
  expect(page).to have_selector("#m_sectionBilling")
  find("#m_radioListCardType1_1").click
  expect(page).to have_selector("[name='m_txtCardNumber']")
  find("[name='m_txtCardNumber']").set("123123")
  find("#m_dropListCardDateMonth option[value='12']").click
  find("#m_dropListCardYear option[value='19']").click
  find("#m_txtCvv").set("111")
  find("#m_txtBoxBillingAddress").set("automation_test_address")
  find("#m_txtBoxCity").set("automation_test_city")
  find("#m_txtBoxZipCode").set("11111")
  find("[name='m_btnPayment']").click
end 

class PriceExtract 
  def price_extract_se (price_string) 
  price_int = price_string.split(" kr")[0]
  price_int.to_i  
  return price_int
  end 

  def price_extract_slice_se (price_str)
    price_i = price_str.slice!(0..-4).to_i
    return price_i 
  end 
end 

def return_to_cart
  find("#m_hyperLinkReturnToShoppingCart").click
  expect(page).to have_selector(".checkout-cart-content")
end   

def proceed_paypal
  find(".paypal-checkout").click
  #expect(page).to have_selector(".account-wrapper")
end 

def thankyoupage
  expect(page).to have_selector(".thank-you-inner")
  expect(page).to have_selector(".thanksOrderBox")
  orderid = find("[id*='OrderIdLabel']").text
  totalcost = find("[id*='TotalCostLabel']").text
  itemcount = find("[id*='OrderItemsCount']").text
  orderarray = [orderid, totalcost, itemcount]
  return orderarray
end 

def getname
  timenow = Time.new.strftime("%m%d%H%M")
  randomname = "automation#{timenow}"
  return randomname
end 
#BO office page
def sarchforuniqueorder (first_name, last_name, uniqueemail)
    find('.cms-nav-icon-large').click
    find(".accordion-toggle", text: "E-commerce").click
    find('.app-orders').click
    find('.app-orders').click
      within_frame ("cmsdesktop") do
        fill_in("m_c_orderListElem_gridElem_cf_txtCustomerNameOrCompanyOrEmail", with: uniqueemail)
        click_button "Search"
        expect(page).to have_content("#{first_name} #{last_name}", :count => 1)
      end
end 



def order_status_bo_se (order_price_int, order_id)
  within_frame ("cmsdesktop") do
      within ("[data-objectid='#{order_id}']") do
        bo_order_price = find("td:nth-child(5)").text.slice!(0..-4).to_i
        (order_price_int).should eq(bo_order_price)
        expect(page).to have_selector(".tag-dark", :text => "Payment received")
        expect(page).to have_selector(".tag-dark", :text => "Payment received")
        expect(page).to have_selector(".StatusEnabled", :text => "Yes")
      end
     end
end 

def perfomance_page_details(link)
  visit link 
  
sleep 5
   json = execute_script("if (window.performance && window.performance.timing) {
     let timing = window.performance.timing;
     let timing_obj = {};
     /*timing*/
     timing_obj.pageLoadingTime = timing.loadEventEnd - timing.navigationStart;
     timing_obj.dnsHandshake = timing.domainLookupEnd - timing.domainLookupStart;
     timing_obj.tcpConnect = timing.connectEnd - timing.connectStart;
     timing_obj.timeToReachServer = timing.responseStart - timing.requestStart;
     timing_obj.serverResponseTime = timing.responseEnd - timing.responseStart;
     timing_obj.totalNetworkLatency = timing.responseEnd - timing.fetchStart;
     timing_obj.domInteractive = performance.timing.domInteractive - performance.timing.navigationStart;
  return timing_obj;
 }
")
p json 
return json 
end 