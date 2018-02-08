require './helpers/spec_helper.rb'

feature "AS a user I'm clicking on all banners in main page (Slider, Collection banners, etc...) and verify I'm in the right page and the page has the right functionality" , js: true, :order => :defined do
  
    def site
      return main_site
      # return prod_site
    end

  describe "Entering into each one of the banners and verify content" do

    before (:each) do
      visit site
    end

    it "Slider Top, all banners" do
      expect(page).to have_selector(".bx-wrapper")
      expect(page).to have_selector(".CMSBanner", :count => 5)
      expect(page).to have_css(".alsoLikeItems")
      find(".pager-link.pager-1").click
      find(".pager-link.pager-2").click
      find(".pager-link.pager-3").click
      find(".bx-wrapper").click
      expect(page).to have_no_content("OUR MOST POPULAR")
      expect(page).to have_selector(".catProductTeaser", :minimum => 2)
      expect(page).to have_no_css(".alsoLikeItems")
      #Percy::Capybara.snapshot(page, name: 'All banners are present')
    end

    it "Left top banner" do
      page.all(".CMSBanner")[0].click
      expect(page).to have_selector(".searchSortBox [name*='SmartSearchFilter']")
      expect(page).to have_selector(".catProductTeaser", :minimum => 2)
      expect(page).to have_no_css(".alsoLikeItems")
    end

    it "Right top banner" do
      page.all(".CMSBanner")[1].click
      expect(page).to have_selector(".searchSortBox [name*='SmartSearchFilter']")
      expect(page).to have_selector(".catProductTeaser", :minimum => 2)
      expect(page).to have_no_css(".alsoLikeItems")
      #Percy::Capybara.snapshot(page, name: 'Right top banner content')
    end

    it "Central banner" do
      find(".hpBannerFull").click
      expect(page).to have_css(".searchSortBox [name*='SmartSearchFilter']")
      expect(page).to have_selector(".catProductTeaser", :minimum => 2)
      expect(page).to have_no_css(".alsoLikeItems")
    end

    it "Left bottom banner" do
      page.all(".CMSBanner")[3].click
      expect(page).to have_selector(".searchSortBox [name*='SmartSearchFilter']")
      expect(page).to have_selector(".catProductTeaser", :minimum => 2)
      expect(page).to have_no_css(".alsoLikeItems")
      #Percy::Capybara.snapshot(page, name: 'Left bottom banner content')
    end

    it "Right bottom banner" do
      page.all(".CMSBanner")[4].click
      #expect(page).to have_selector(".categoryBanner", :text => "Name Necklaces")
      expect(page).to have_selector(".categoryBanner", :text => "Engraved Jewellery") #changed since last changes from prod DB
      expect(page).to have_selector(".catProductTeaser", :minimum => 2)
      expect(page).to have_no_css(".alsoLikeItems")
    end

    it "Sidebar Top banner on Homepage (Free Delivery)" do
      find(".sidebarTopBanner").click
      expect(page).to have_content("Delivery Methods & Charges")
      #expect(page).to have_selector("tr", :text => "Free Delivery")
      expect(page).to have_css("a[href^='/Article/FAQ']")
      #Percy::Capybara.snapshot(page, name: 'Free delivery banner content')
    end

    it "Bottom Also Like Items banner (OUR MOST POPULAR)" do
      expect(page).to have_content("OUR MOST POPULAR")
      expect(page).to have_selector(".alsoLikeitem", :count => 4)
      page.all(".alsoLikeitem")[2].click
      expect(page).to have_selector(".finalPrice")
      expect(page).to have_selector("[itemprop='price']") # BUG: [itemprop='availability'] is absent
      expect(page).to have_css(".add-to-cart-link")
      #Percy::Capybara.snapshot(page, name: 'Also like banner content')
    end

  end

  describe "AS a user I'm finding Products and will get the right result with " do

    before (:each) do
      visit site
    end

    it "search Product with click the 'Search' button" do
      find('.searchInput').set('18ct Gold-Plated')
      find('.fa-search').click
      sleep 5
      expect(page).to have_content("18ct Gold-Plated Silver Classic Name Necklace")
      find("[href$='/Products/All-Necklaces/18ct-Gold-Plated-Silver-Classic-Name-Necklace']").click
      expect(page).to have_selector("[itemprop='name']", :text => "18ct Gold-Plated Silver Classic Name Necklace")
      expect(page).to have_selector(".productMainImageContainer")
      #Percy::Capybara.snapshot(page, name: 'Product Search via Search icon')
    end

    it "search Product without click the 'Search' button (Predictive Search)" do
      find('.searchInput').set('Engraved Infinity' + ' ')
      within(".predictiveSearchResults") do
        sleep 5
         # use Collection link
        #page.all(".category-text")[0].click
        find(".category-text", match: :first).click
      end
      # expect(page).to have_selector(".categoryBanner", text: "Infinity Collection")
      find('.searchInput').set('Engraved Infinity')
      within(".predictiveSearchResults") do
        sleep 5
         # use Product direct link
        find(".category-text", :text => "Engraved Infinity" + ' ', match: :first).click
      end
      expect(page).to have_selector(".finalPrice")
      expect(page).to have_selector(".productMainImageContainer")
      expect(page).to have_no_selector(".categoryBanner")
      find('.searchInput').set('Engraved Infinity')
      within(".predictiveSearchResults") do
        sleep 5
         # use "See all search results" link
        find(".category-text", text: "See all search results").click
      end
      expect(page).to have_selector(".catProductTeaser", :count => 20)
      expect(page).to have_selector(".facetsBox", text: "FILTER BY TYPE")
      #Percy::Capybara.snapshot(page, name: 'Predictive Search')
    end

    it "side menu 'FILTER BY TYPE' on Search page" do
      find('.searchInput').set('Silver')
      find('.fa-search').click
      expect(page).to have_selector(".facetsBox", :text => "FILTER BY TYPE")
      # click one checkbox and make sure that sorting is correct
      check 'Necklace'
      expect(page).to have_selector(".catProductName", :text => "Necklace")
      expect(page).to have_no_selector(".catProductName", :text => "Bracelet")
      uncheck 'Necklace'
      expect(page).to have_selector(".catProductName")
      check 'Bracelet'
      expect(page).to have_selector(".catProductName", :text => "Bracelet")
      expect(page).to have_no_selector(".catProductName", :text => "Ring")
      uncheck 'Bracelet'
      expect(page).to have_selector(".catProductName")
      check 'Ring'
      expect(page).to have_selector(".catProductName", :text => "Ring")
      expect(page).to have_no_selector(".catProductName", :text => "Keychain")
      uncheck 'Ring'
      expect(page).to have_selector(".catProductName")
      check 'Keychain'
      expect(page).to have_selector(".catProductName", :text => "Keychain")
      expect(page).to have_no_selector(".catProductName", :text => "Necklace")
      # click all checkboxes and make sure that all product types are on page
      check 'Ring'
      check 'Bracelet'
      check 'Necklace'
      expect(page).to have_selector(".catProductName", :text => "Ring")
      expect(page).to have_selector(".catProductName", :text => "Bracelet")
      expect(page).to have_selector(".catProductName", :text => "Necklace")
      #Percy::Capybara.snapshot(page, name: 'Type filter on search page')
    end
    
    it "side menu 'FILTER BY PRICE' on Search page" do
      find('.searchInput').set('Gold')  
      find('.fa-search').click
      expect(page).to have_selector(".facetsBox", :text => "FILTER BY PRICE")
      expect(page).to have_selector(".DropDownField")
      check '€0 - €50'
      select("price: low to high", from: "Filter", wait: 3)
      @prices = page.all(".catPrice").collect(&:text)
      @pricefirst = @prices.first.split("\u20AC")[1]
      @pricelast = @prices.last.split("\u20AC")[1]
      expect(@pricelast).to be > (@pricefirst)
      expect(@pricelast).to be < ("50")
      uncheck '€0 - €50'
      check '€50 - €250'
      select("price: low to high", from: "Filter")
      @prices = page.all(".catPrice").collect(&:text)
      @pricefirst = @prices.first.split("\u20AC")[1].to_i
      @pricelast = @prices.last.split("\u20AC")[1].to_i
      expect(@pricelast).to be > (@pricefirst)
      expect(@pricefirst).to be > (50)
      expect(@pricelast).not_to be > (250)
      select("price: high to low", from: "Filter")
      @prices = page.all(".catPrice").collect(&:text)
      @pricefirst = @prices.first.split("\u20AC")[1].to_i
      @pricelast = @prices.last.split("\u20AC")[1].to_i
      expect(@pricefirst).to be > (@pricelast)
      expect(@pricefirst).to be < (250)
      expect(@pricelast).to be > (50)
      uncheck '€50 - €250'
      check '€250 - €5000'
      # select("price: low to high", from: "Filter")
      # @prices = page.all(".catPrice").collect(&:text)
      # @pricefirst = (@prices.first.split("\u20AC")[1]).to_i
      # @pricelast = (@prices.last.split("\u20AC")[1]).to_i
      # expect(@pricelast).to be > (@pricefirst)
      # expect(@pricefirst).to be > (250)
      # expect(@pricelast).not_to be > (5000)
      # select("price: high to low", from: "Filter")
      # @prices = page.all(".catPrice").collect(&:text)
      # @pricefirst = @prices.first.split("\u20AC")[1].to_i
      # @pricelast = @prices.last.split("\u20AC")[1].to_i
      # expect(@pricefirst).to be > (@pricelast)
      # expect(@pricefirst).to be < (5000)
      # expect(@pricelast).to be > (250)
      # IE site does not contains Products with price highest than 250 euros, so should be expected empty search:
      expect(page).to have_content("Tips for better search results:")
      uncheck '€250 - €5000'
      #Percy::Capybara.snapshot(page, name: 'Price filter on Search page')
    end
        
    it "side menu 'FILTER BY MATERIAL' on Search page" do
      find('.searchInput').set('Gold')
      find('.fa-search').click
      expect(page).to have_selector(".facetsBox", :text => "FILTER BY MATERIAL")
      select("relevance", from: "Filter")
      check 'Silver'
      expect(page).to have_content("Silver")
      uncheck 'Silver'
      check '18ct Gold Plating'
      expect(page).to have_content("18ct Gold Plated")
      uncheck '18ct Gold Plating'
      check 'Rose Gold Plating'
      expect(page).to have_content("Rose Gold")
      uncheck 'Rose Gold Plating'
      check 'Solid Gold'
      expect(page).to have_content("Gold")
      uncheck 'Solid Gold'
      check 'White Gold'
      expect(page).to have_content("Tips for better search results:")
      uncheck 'White Gold'
      #Percy::Capybara.snapshot(page, name: 'Material filter on Search page')
    end

  end

end