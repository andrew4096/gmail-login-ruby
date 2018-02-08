require './helpers/spec_helper.rb'

describe "AS a user i'm visiting all categories on the SE site and check that page is opened properly and items are sorted properly according to selected sort order", :feature => "AS a user i'm visiting all categories on the SE site and check that page is opened properly and items are sorted properly according to selected sort order", :severity => :normal do

before(:step) do |s|
    puts "Before step #{s.current_step}"
  end

  before (:each) do
      visit main_site_se
    end

it "visit all categories in loop and check related options" , :story => "visit all categories in loop and check related options", :severity => :normal do |e|
# create array with categories names
e.step "Collect categories names" do |s|
$categories = all(:css, '.side-menu a').collect(&:text)
p $categories


# create array with categories links
$categories_link = all('.side-menu a').map {|a| a['href'] }
p $categories_link
end

e.step "Go to every category in loop and check content and sorting" do |s|
# go to evevy categoy in loop

$categories.each_with_index { 
  |val, index|
  
  # go to category page
  page.all(".side-menu a")[index].click
  p val
  p index 
  # check that page label is correct
  #expect(find(".CMSBreadCrumbsCurrentItem").text).to eq(val)
  #expect(find(".CMSBreadCrumbsCurrentItem").text).to include(val)
  #expect(find(".categoryBanner").text).to include(val)
  
  # check that url is correct
  
    p page.current_url
    p $categories_link[index]
    cat_link = $categories_link[index].downcase 
    p cat_link 
    sleep 2
    expect(page.current_url).to eq(cat_link)
    #expect(page).to have_content(cat_link)
  
  # check that category has more than 2 items
  expect(page).to have_selector(".catProductTeaser", minimum: 2)

  # sort products by price from low to high
  select("PRIS LÅGT TILL HÖGT", from: "Filter")
  
  sleep 5
  expect(page).to have_selector(".searchResultBox")
  
  # get prices of products
  @prices = page.all(".catPrice").collect(&:text)
  @price1st = @prices.first.slice!(0..-4).to_i
  @price2nd = @prices[1].slice!(0..-4).to_i
  @pricelast = @prices.last.slice!(0..-4).to_i
  p @prices 
  p @price1st 
  p @price2nd 
  p @pricelast 
  # compare 1st and 2nd product price
  expect(@price2nd).to be >= (@price1st)

  # compare 1st and last product price
  expect(@pricelast).to be >= (@price1st)
  sleep 3
  #Percy::Capybara.snapshot(page, name: '1st price < 2nd price on category page')   
  # delay between page
  #sleep 9

}
end 
    end

it "open 1st category and check that sorting is applied for 2nd page as well" , :story => "open 1st category and check that sorting is applied for 2nd page as well", :severity => :normal do |e|
    e.step "Open 1st category" do |s|
    # Open 1st category page
        page.all(".side-menu a")[1].click
    end

    e.step "Check pagination is present on the page" do |s|
    # Check if there is pagination present
    expect(page).to have_selector(".pagerBox")
    end

    e.step "Sort products from low to high price" do |s|
    # sort products by price from low to high
    select("PRIS LÅGT TILL HÖGT", from: "Filter")
    
    end 

    e.step "get prices of products on 1st page" do |s|
    # get prices of products on 1st page
    @prices1page = page.all(".catPrice").collect(&:text)
    @price1st1page = @prices1page.first.slice!(0..-4).to_i
    @pricelast1page = @prices1page.last.slice!(0..-4).to_i
    end
    e.step "compare 1st and last product price" do |s|
    # compare 1st and last product price
    expect(@pricelast1page).to be >= (@price1st1page)
    #Percy::Capybara.snapshot(page, name: '1st price < 2nd price on category page')   
    end 

    e.step "Go to 2nd next page" do |s|
    # click next page
    page.all(".pagerBox a").first.click
    end 
    e.step "check that filter is selected properly" do |s|
    # check that filter is selected properly
    expect(page).to have_select("Filter", selected: "PRIS LÅGT TILL HÖGT")
    end 
    e.step "get prices of products on 2nd page" do |s|
    # get prices of products on 2nd page
    @prices2page = page.all(".catPrice").collect(&:text)
    @price1st2page = @prices2page.first.slice!(0..-4).to_i
    @pricelast2page = @prices2page.last.slice!(0..-4).to_i
     end  
    
    e.step "check that 1st price > than last on the 2nd page" do |s|
    # check that 1st price > than last on the 2nd page
    expect(@pricelast2page).to be >= (@price1st2page)
    #Percy::Capybara.snapshot(page, name: '1st price < 2nd price on 2nd category page')
    end

    e.step "check that 1st price of 2nd page > last price of 1st page" do |s|
    # check that 1st price of 2nd page > last price of 1st page
    expect(@price1st2page).to be >= (@pricelast1page)
    end 
end

end



