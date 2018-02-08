require './helpers/spec_helper.rb'

feature "As A QA user i'm validating content and items which are not related to the user flow" , js: true, :order => :defined do

  describe "Validating content and items" do

    before (:each) do
      visit main_site
    end

    it "verify there is a valid 404 page, when page is not found" do
      visit "#{main_site}not-a-valid-page.aspx"
      expect(page).to have_selector(".img[src='/errors/images/404.png']")
      #Percy::Capybara.snapshot(page, name: '404 page is displayed properly on IE')
      #expect(page).to have_selector("title", text: "Page not found | Mynamenecklace IE")
      expect(page).to have_selector("a[href='/']")
      find("[href='/']").click
      expect(page).to have_current_path(main_site, url: true)
    end

    it "verify there is a Favico on the main page" do
      expect(page).to have_selector("[href*='/favicon.ico'][rel='shortcut icon']")
    end

  end
end



feature "As A User i'm checking and clicking on all articles and verify their content" , js: true, :order => :defined do

  describe "clicking on all articles and verify their content and functionality" do

    before (:each) do
      visit main_site
    end

    it "topHeaderBox - FREE DELIVERY - click and verify" do
      find(".topHeaderIcons [href='/Article/Delivery-Information']").click
      expect(page).to have_content("Delivery Methods & Charges")
      expect(page).to have_content("Estimated Delivery")
      expect(page).to have_content("Shipping Notification")
      expect(page).to have_selector(".article-content [href='/Article/FAQ?s=shipping#FaqArticle']")
      #Percy::Capybara.snapshot(page, name: 'Free delivery page content')
    end

    it "topHeaderBox - NEED HELP? - click and verify" do
      find(".topHeaderLinks [href='/Article/Need-Help']").click
      #page.click_link('Need Help', href: '/Footer-menu-links/Need-Help/Need-Help')
      page.click_link('Need Help', href: '/Article/Need-Help')
      expect(page).to have_selector(".faqSectionLeft h3", :text => "MY ORDER")
      expect(page).to have_selector(".faqSectionLeft h3", :text => "RETURN AND REFUNDS")
      expect(page).to have_selector(".faqSectionLeft h3", :text => "ABOUT MYNAMENECKLACE")
      expect(page).to have_selector(".faqSectionRight h3", :text => "PRIVACY AND SECURITY")
      expect(page).to have_selector(".faqSectionRight h3", :text => "PAYMENT")
      expect(page).to have_selector(".faqSectionRight h3", :text => "HELPFUL INFORMATION")
      #Percy::Capybara.snapshot(page, name: 'Need help page content')

      find(".faqBox .question span", text: "Do You Ship Worldwide?").click
      expect(page).to have_selector("div.answer", :text => "Yes, We Ship Worldwide.", :visible => true)
      find(".faqBox .question span", text: "Ring Size Incorrect").click
      expect(page).to have_selector("div.answer", :text => "If your ring size is incorrect, we will resize your ring the first time for free!", :visible => true)
    end

    it " Main Site Logo - click and verify it takes to home page" do
      find(".mnnLogo[href='/']").click
      expect(page).to have_current_path(main_site, url: true)
    end

    it "sidebarTopBanner - FREE DELIVERY - click and verify" do
      find(".sidebarTopBanner [href='/Article/Delivery-Information']").click
      expect(page).to have_content("Delivery Methods & Charges")
      expect(page).to have_content("Estimated Delivery")
      expect(page).to have_content("Shipping Notification")
      expect(page).to have_selector(".article-content [href='/Article/FAQ?s=shipping#FaqArticle']")
    end

    it "sidebarFbBox - Facebook like button - verify" do
      find(".sidebarFbBox")
      expect(find(".sidebarFbBox")).to have_selector(".fb_iframe_widget.fb-like")
    end

    it "Bottom page - certificates-wrapper (Payment option logos) - verify" do
      find(".certificates-wrapper")
      expect(find(".certificates-wrapper")).to have_selector("img", :count => 5)
      expect(find(".certificates-wrapper")).to have_selector(".footerPaymentText")
    end

    it "Bottom page - copyright description" do
      find(".footerLine.container")
      expect(find(".footerLine.container")).to have_selector(".copyright")
    end

  end

end

feature "As A User i'm checking design of the site, including images, icons , and text " , js: true, :order => :defined do

  describe "I'm verifying there is a design and items are proprly set on the site" do

    before (:each) do
      visit main_site
    end

    it "Verify the Title of the site" do
      expect(page).to have_selector("#head title", :text => "Name Necklace & Personalised Jewellery | MyNameNecklace IE")     
    end

    it "Drill down option is available and able to navigate to the product from topMenu" do

    end

  end

  describe "Drill down option is available and able to navigate to the product from topMenu" , js: true, :order => :defined do

    before (:each) do
      visit main_site
    end

    it "Verify the top menu is exist with 4 categories" do
      expect(page).to have_selector(".topMenuItem", :count => 4)
    end

    it "Necklaces number of Collections" do
      expect(find(".topMenu .topMenuItem", text: "Necklaces", match: :first)).to have_selector(".subMenuItem", :count => 5)
    end

    it "Necklaces top menu - Navigate to 1st collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Necklaces", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Necklaces", match: :first).all(".subMenuItem")[0].text
      find(".topMenu .topMenuItem", text: "Necklaces", match: :first).all(".subMenuItem")[0].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser ", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Necklaces top menu - Navigate to 2nd collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Necklaces", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Necklaces", match: :first).all(".subMenuItem")[1].text
      find(".topMenu .topMenuItem", text: "Necklaces", match: :first).all(".subMenuItem")[1].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser ", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end
    #
    it "Necklaces top menu - Navigate to 3rd collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Necklaces", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Necklaces", match: :first).all(".subMenuItem")[2].text
      find(".topMenu .topMenuItem", text: "Necklaces", match: :first).all(".subMenuItem")[2].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser ", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end
    #
    it "Necklaces top menu - Navigate to 4rd collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Necklaces", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Necklaces", match: :first).all(".subMenuItem")[3].text
      find(".topMenu .topMenuItem", text: "Necklaces", match: :first).all(".subMenuItem")[3].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser ", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Rings & Things number of Collections" do
      expect(find(".topMenu .topMenuItem", text: "Rings & Things", match: :first)).to have_selector(".subMenuItem", :count => 3)
    end

    it "Rings & Things top menu - Navigate to 1st collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Rings & Things", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Rings & Things", match: :first).all(".subMenuItem")[0].text
      find(".topMenu .topMenuItem", text: "Rings & Things", match: :first).all(".subMenuItem")[0].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Rings & Things top menu - Navigate to 2nd collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Rings & Things", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Rings & Things", match: :first).all(".subMenuItem")[1].text
      find(".topMenu .topMenuItem", text: "Rings & Things", match: :first).all(".subMenuItem")[1].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Rings & Things top menu - Navigate to 3rd collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Rings & Things", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Rings & Things", match: :first).all(".subMenuItem")[2].text
      find(".topMenu .topMenuItem", text: "Rings & Things", match: :first).all(".subMenuItem")[2].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Collections number of Collections" do
      expect(find(".topMenu .topMenuItem", text: "Collections", match: :first)).to have_selector(".subMenuItem", :count => 6)
    end

    it "Collections top menu - Navigate to 1st collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Collections", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Collections", match: :first).all(".subMenuItem")[0].text
      find(".topMenu .topMenuItem", text: "Collections", match: :first).all(".subMenuItem")[0].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Collections top menu - Navigate to 2nd collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Collections", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Collections", match: :first).all(".subMenuItem")[1].text
      find(".topMenu .topMenuItem", text: "Collections", match: :first).all(".subMenuItem")[1].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Collections top menu - Navigate to 3rd collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Collections", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Collections", match: :first).all(".subMenuItem")[2].text
      find(".topMenu .topMenuItem", text: "Collections", match: :first).all(".subMenuItem")[2].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Collections top menu - Navigate to 4rd collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Collections", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Collections", match: :first).all(".subMenuItem")[3].text
      find(".topMenu .topMenuItem", text: "Collections", match: :first).all(".subMenuItem")[3].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Collections top menu - Navigate to 5th collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Collections", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Collections", match: :first).all(".subMenuItem")[4].text
      find(".topMenu .topMenuItem", text: "Collections", match: :first).all(".subMenuItem")[4].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Gifts number of Collections" do
      expect(find(".topMenu .topMenuItem", text: "Gifts", match: :first)).to have_selector(".subMenuItem", :count => 5)
    end

    it "Gifts top menu - Navigate to 1st collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Gifts", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Gifts", match: :first).all(".subMenuItem")[0].text
      find(".topMenu .topMenuItem", text: "Gifts", match: :first).all(".subMenuItem")[0].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Gifts top menu - Navigate to 2nd collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Gifts", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Gifts", match: :first).all(".subMenuItem")[1].text
      find(".topMenu .topMenuItem", text: "Gifts", match: :first).all(".subMenuItem")[1].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Gifts top menu - Navigate to 3rd collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Gifts", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Gifts", match: :first).all(".subMenuItem")[2].text
      find(".topMenu .topMenuItem", text: "Gifts", match: :first).all(".subMenuItem")[2].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end

    it "Gifts top menu - Navigate to 4rd collection and verify there are items to show" do
      find(".topMenu .topMenuItem", text: "Gifts", match: :first).click
      @collection_name =   find(".topMenu .topMenuItem", text: "Gifts", match: :first).all(".subMenuItem")[3].text
      find(".topMenu .topMenuItem", text: "Gifts", match: :first).all(".subMenuItem")[3].click
      expect(page).to have_selector(".CMSBreadCrumbsCurrentItem", :text => @collection_name)
      expect(page).to have_selector(".searchResultBox")
      expect(page).to have_selector(".catProductTeaser", :minimum  => 4)
      #Percy::Capybara.snapshot(page, name: 'cetagory page has content, minimum 4 products')   
    end


  end

end
