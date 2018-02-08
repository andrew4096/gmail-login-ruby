require './helpers/spec_helper.rb'
#require './helpers/config_helper.rb'

  describe "Entering into the banners and verify content",
   :feature => "AS a user I'm clicking on all banners in main page (Slider, Collection banners, etc...) and verify I'm in the right page and the page has the right functionality",
    js: true, :order => :defined do

    before (:each) do
      visit main_site_se
    end

    it "Slider Top, all banners" do
      expect(page).to have_selector(".bx-wrapper") #.mainBanner
      expect(page).to have_selector(".hp-banner", :count => 5)
      expect(page).to have_css(".hpBestSeller")
      find(".pager-link.pager-3").click
      find(".pager-link.pager-1").click
      find(".pager-link.pager-4").click
      find(".pager-link.pager-2").click
      find(".fa.fa-caret-right").click
      find(".fa.fa-caret-right").click
      find(".fa.fa-caret-left").click
      find(".bx-wrapper").click
      expect(page).to have_selector(".catProductTeaser", :minimum => 3)
      expect(page).to have_no_css(".best-seller-inner")
      #Percy::Capybara.snapshot(page, name: 'All banners are present')
    end

    it "Left top banner" do
      find(".hp-banner.hp-b1").click
      expect(page).to have_selector(".searchSortBox [name*='SmartSearchFilter']")
      expect(page).to have_selector(".catProductTeaser", :minimum => 2)
      expect(page).to have_no_css(".best-seller-inner")
      #Percy::Capybara.snapshot(page, name: 'Left top banner content')
    end

    it "Right top banner" do
      find(".hp-banner.hp-b2").click
      expect(page).to have_selector(".searchSortBox [name*='SmartSearchFilter']")
      expect(page).to have_selector(".catProductTeaser", :minimum => 2)
      expect(page).to have_no_css(".best-seller-inner")
    end

    it "Central banner" do
      find(".hp-banner.hp-b3").click
      expect(page).to have_css(".searchSortBox [name*='SmartSearchFilter']")
      expect(page).to have_selector(".catProductTeaser", :minimum => 2)
      expect(page).to have_no_css(".best-seller-inner")
      #Percy::Capybara.snapshot(page, name: 'Central banner content')
    end

    it "Left bottom banner" do
      find(".hp-banner.hp-b4").click
      expect(page).to have_selector(".searchSortBox [name*='SmartSearchFilter']")
      expect(page).to have_selector(".catProductTeaser", :minimum => 2)
      expect(page).to have_no_css(".best-seller-inner")
    end

    it "Right bottom banner" do
      find(".hp-banner.hp-b5").click
      expect(page).to have_selector(".categoryContent", :text => "Infinity smycken för evig kärlek")
      expect(page).to have_selector(".catProductTeaser", :minimum => 1)
      expect(page).to have_no_css(".best-seller-inner")
      #Percy::Capybara.snapshot(page, name: 'Right botoom banner content')
    end

    it "Sidebar Top banner on Homepage (Free Delivery)" do
      find(".hp-shipping-inner").click
      expect(page).to have_content("Fraktmetoder & Avgifter")
      expect(page).to have_selector("tr", :text => "Standard Leverans")
      expect(page).to have_css("a[href^='/contact-us']")
      #Percy::Capybara.snapshot(page, name: 'Free Delivery banner content')
    end

    it "Bottom Also Like Items banner (OUR MOST POPULAR)" do
      expect(page).to have_content("KOLLA IN V\u00C5RA B\u00C4STS\u00C4LJARE")
      expect(page).to have_selector(".best-seller-inner", :count => 6)
      page.all(".best-seller-inner")[0].click
      expect(page).to have_selector(".pink.finalPrice")
      expect(page).to have_selector("[itemprop='price']")
      expect(page).to have_css(".main-iamge")
      #Percy::Capybara.snapshot(page, name: 'Also Like banner content')
    end

  end

  describe "Finding Products and check the right result with ",
   :feature => "AS a user I'm finding Products and will get the right result with",
    js: true, :order => :defined do

    before (:each) do
      visit main_site_se
    end

    it "search Product with click the 'Search' button" do
      find('.searchInput').set('18k guld')
      find('.fa-search').click
      expect(page).to have_content("Litet 18k roseguldpläterat Klassiskt Namnhalsband")
      page.all(".catProductTeaser")[0].click 
      expect(page).to have_selector(".productTitle")
      expect(page).to have_selector(".productMainImageContainer")
      #Percy::Capybara.snapshot(page, name: 'Search by clicking Search icon')
    end

    it "search Product without click the 'Search' button (Predictive Search)" do
      find('.searchInput').set('Infinity' + ' ')
      sleep 2
      within(".predictiveSearchResults") do
        sleep 3
        # use Collection link (should be first)
        page.all(".category-text")[0].click
      end
      expect(page).to have_selector(".cat-title", text: "Infinity smycken")
      find('.searchInput').set('Infinity' + ' ')
      sleep 2
      within(".predictiveSearchResults") do
        sleep 3
         # use Product direct link
        first(".category-text", :text => "Silver Infinity Halsband").click
      end
      expect(page).to have_selector(".pink.finalPrice")
      expect(page).to have_selector(".productMainImageContainer")
      expect(page).to have_no_selector(".cat-title")
      find('.searchInput').set('Infinity' + ' ')
      within(".predictiveSearchResults") do
        sleep 5
         # use "See all search results" link
        find(".category-text", text: "Visa fler Träffar").click
      end
      expect(page).to have_selector(".catProductTeaser")
<<<<<<< HEAD
      expect(page).to have_selector(".searchFacets", text: "TYP")
=======
      expect(page).to have_selector(".facetsBox", text: "TYP")
      #Percy::Capybara.snapshot(page, name: 'Search via predictive search')
>>>>>>> ab4b82976de9a3eafef4166f21d0fcbdd215da76
    end

  end

  describe "Sortinging Products on search page using left side menu",
   :feature => "AS a user I'm finding Products and will get the right result with",
    js: true, :order => :defined do

    before (:each) do
      visit main_site_se
    end  

    it "side menu 'FILTER BY TYPE' on Search page" do
      find('.searchInput').set('Silver' + ' ')
      find('.fa-search').click
      expect(page).to have_selector(".searchFacets", :text => "PRIS")
      # click one checkbox and make sure that sorting is correct
      check 'Halsband'
      click_button ('Apply')
      expect(page).to have_selector(".catProductName", :text => "Halsband")
      expect(page).to have_no_selector(".catProductName", :text => "Nyckelring")
      uncheck 'Halsband'
      expect(page).to have_selector(".catProductName")
      check 'Armband'
      click_button ('Apply')
      expect(page).to have_selector(".catProductName", :text => "Armband")
      expect(page).to have_no_selector(".catProductName", :text => "Halsband")
      uncheck 'Armband'
      expect(page).to have_selector(".catProductName")
      check 'Ringa'
      click_button ('Apply')
      expect(page).to have_selector(".catProductName", :text => "Ring")
      expect(page).to have_no_selector(".catProductName", :text => "Nyckelring")
      uncheck 'Ringa'
      expect(page).to have_selector(".catProductName")
      check 'Nyckelring'
      click_button ('Apply')
      expect(page).to have_selector(".catProductName", :text => "Nyckelring")
      expect(page).to have_no_selector(".catProductName", :text => "Armband")
      # click all checkboxes and make sure that all product types are on page
      check 'Ringa'
      check 'Armband'
      check 'Halsband'
      click_button ('Apply')
      expect(page).to have_selector(".catProductName", :text => "Ring")
      expect(page).to have_selector(".catProductName", :text => "Armband")
      expect(page).to have_selector(".catProductName", :text => "Halsband")
      #Percy::Capybara.snapshot(page, name: 'Type filters on search page')
    end
    
    it "side menu 'FILTER BY PRICE' on Search page" do
      find('.searchPlaceholder').set('Guld' + ' ')  
      find('.fa-search').click
      # expect(page).to have_selector(".facetsBox", :text => "PRIS") # config bug!
      expect(page).to have_selector(".DropDownField")
      check '- 250'
      click_button ('Apply')
      select("PRIS LÅGT TILL HÖGT", from: "Filter", wait: 3)
      @prices = page.all(".catPrice").collect(&:text)
      @pricefirst = @prices.first.slice!(0..-4).to_i
      @pricelast = @prices.last.slice!(0..-4).to_i
      expect(@pricefirst).to be < (@pricelast)
      expect(@pricelast).to be < (1250)
      uncheck '- 250'
      check '250 - 500'
      click_button ('Apply')
      select("PRIS LÅGT TILL HÖGT", from: "Filter", wait: 3) # Search.Results.Filter.Price.Low.High
      @prices = page.all(".catPrice").collect(&:text)
      @pricefirst = @prices.first.slice!(0..-4).to_i
      @pricelast = @prices.last.slice!(0..-4).to_i
      expect(@pricefirst).to be < (@pricelast) # there is a bug - should failed
      expect(@pricefirst).to be < (500)
      expect(@pricelast).not_to be < (250)
      select("PRIS HÖGT TILL LÅGT", from: "Filter") # SKUPrice DESC
      @prices = page.all(".catPrice").collect(&:text)
      @pricefirst = @prices.first.slice!(0..-4).to_i
      @pricelast = @prices.last.slice!(0..-4).to_i
      expect(@pricelast).to be < (@pricefirst)
      expect(@pricefirst).to be < (501)
      expect(@pricelast).not_to be < (250)
      uncheck '250 - 500'
      check '750 - 1000'
      click_button ('Apply')
      select("PRIS HÖGT TILL LÅGT", from: "Filter")
      @prices = page.all(".catPrice", :visible => true).collect(&:text)
      @pricefirst = @prices.first.slice!(0..-4).to_i
      @pricelast = @prices.last.slice!(0..-4).to_i
      expect(@pricelast).to be < (@pricefirst)
      expect(@pricefirst).to be < (1001)
      expect(@pricelast).not_to be < (750)
      uncheck '750 - 1000'
      check '+ 1250'
      click_button ('Apply')
      # expect(page).to have_content("Kontrollera stavningen, du kan")
      @prices = page.all(".catPrice", :visible => true).collect(&:text)
      @pricefirst = @prices.first.slice!(0..-4).to_i
      @pricelast = @prices.last.slice!(0..-4).to_i
      # expect(@pricelast).to be < (@pricefirst)
      expect(@pricefirst).not_to be < (1250)
      uncheck '+ 1250'
      #Percy::Capybara.snapshot(page, name: 'Price filter on Search page')
    end
        
    it "side menu 'FILTER BY MATERIAL' on Search page" do
      find('.searchInput').set('Mammor')
      find('.fa-search').click
      # expect(page).to have_selector(".facetsBox", :text => "MATERIAL")
      select("BÄSTSÄLJARE", from: "Filter")
      check '14k Guld'
      expect(page).to have_content("14k")
      uncheck '14k Guld'
      sleep 5
      check 'Silver'
      expect(page).to have_content("Silver")
      uncheck 'Silver'
      sleep 5
      check '18k Guld' # Pläterat
      expect(page).to have_content("18k")
      uncheck '18k Guld'
      sleep 5
      check '18k Roseguldplätering'
      expect(page).to have_content("Roseguldpl\u00E4tering")
      # uncheck '18k Roseguldplätering' #Roseguldplätering?
      sleep 5
      check 'Rostfritt Stål'
      expect(page).to have_content("Flytande berlock")
      uncheck 'Rostfritt Stål'
      sleep 5
      check '10k guld'
      expect(page).to have_content("10K guld")
      uncheck '10k guld'
      #Percy::Capybara.snapshot(page, name: 'Material filter on Search page')
    end

  end