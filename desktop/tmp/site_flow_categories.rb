require './helpers/spec_helper.rb'
describe "AS a user i'm visiting all categories on the site and check that page is opened properly and items are sorted properly according to selected sort order", :feature => "AS a user i'm visiting all categories on the site and check that page is opened properly and items are sorted properly according to selected sort order", :severity => :normal, type: :feature, js: true, :order => :defined do

#RSpec::Steps.steps "AS a user i'm visiting all categories on the site and check that page is opened properly and items are sorted properly according to selected sort order", :feature => "AS a user i'm visiting all categories on the site and check that page is opened properly and items are sorted properly according to selected sort order", type: :feature, js: true, :order => :defined do

  #describe "Visit every category on the site, check page name, sort products by prices and compare the prices after sorting" do

    before (:each) do
      visit main_site
    end

    it "visit all categories in loop and check related options" , :story => "visit all categories in loop and check related options", :severity => :normal do
# create array with categories names
$categories = all(:css, '.side-menu-box a').collect(&:text)

# create array with categories links
$categories_link = all('.side-menu-box a').map {|a| a['href'] }

# go to evevy categoy in loop
$categories.each_with_index { 
  |val, index|
  
  # go to category page
  page.all(".side-menu a")[index].click
  p val

  # check that page label is correct
  #expect(find(".CMSBreadCrumbsCurrentItem").text).to eq(val)
  #expect(find(".CMSBreadCrumbsCurrentItem").text).to include(val)
  #expect(find(".categoryBanner").text).to include(val)
  
  # check that url is correct
  
    p page.current_url
    p $categories_link[index]
    sleep 2
    expect(page.current_url).to eq($categories_link[index])
  
  # check that category has more than 2 items
  expect(page).to have_selector(".catProductTeaser", minimum: 2)

  # sort products by price from low to high
  select("Price Low to High", from: "Filter")
  wait_for_ajax
  sleep 5
  expect(page).to have_selector(".searchResultBox")
  
  # get prices of products
  @prices = page.all(".catPrice").collect(&:text)
  @price1st = @prices.first.split("\u20AC")[1]
  @price2nd = @prices[1].split("\u20AC")[1]
  @pricelast = @prices.last.split("\u20AC")[1]

  # compare 1st and 2nd product price
  expect(@price2nd).to be >= (@price1st)

  # compare 1st and last product price
  expect(@pricelast).to be >= (@price1st)

  # delay between page
  sleep 3
  #Percy::Capybara.snapshot(page, name: '1st price < 2nd price on category page')
}

    end

   it "open 1st category and check that sorting is applied for 2nd page as well" , :story => "open 1st category and check that sorting is applied for 2nd page as well", :severity => :normal do

    # Open 1st category page
    find(".side-menu a", :text =>"Necklaces").click

    # Check if there is pagination present
    expect(page).to have_selector(".pagerBox")
    # sort products by price from low to high
    select("Price Low to High", from: "Filter")

    # get prices of products on 1st page
    @prices1page = page.all(".catPrice").collect(&:text)
    @price1st1page = @prices1page.first.split("\u20AC")[1]
    @pricelast1page = @prices1page.last.split("\u20AC")[1]

    # compare 1st and last product price
    expect(@pricelast1page).to be >= (@price1st1page)

    # click next page
    page.all(".pagerBox a").first.click

    # check that filter is selected properly
    expect(page).to have_select("Filter", selected: "Price Low to High")

    # get prices of products on 2nd page
    @prices2page = page.all(".catPrice").collect(&:text)
    @price1st2page = @prices2page.first.split("\u20AC")[1]
    @pricelast2page = @prices2page.last.split("\u20AC")[1]
     
    # check that 1st price > than last on the 2nd page
    expect(@pricelast2page).to be >= (@price1st2page)

    # check that 1st price of 2nd page > last price of 1st page
    expect(@price1st2page).to be >= (@pricelast1page)
    #Percy::Capybara.snapshot(page, name: '1st price < 2nd price on 2nd category page')
    end
=begin
  end

  describe "user story 2" do

    before (:each) do
      visit main_site
    end

    it "step1" do

    end

    it "step2" do

    end
=end
 # end



end


# in order to run one scenerio with countinues scenario test in steps use this one , instead of describe - make sure its should be out of feature scope
# RSpec::Steps.steps "user story", type: :feature, js: true do
#   step "first step" do
#
#   end
#   step "secound step" do
#
#   end
# end
